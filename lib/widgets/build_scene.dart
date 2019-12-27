import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import 'package:booktrailer/particles/models/particles_system.dart';
import 'package:booktrailer/models/models.dart';
import 'package:booktrailer/widgets/animated_text.dart';
import 'package:booktrailer/widgets/smoke_background.dart';
import 'package:booktrailer/particles/particles_widget.dart';
import 'package:booktrailer/widgets/transitions.dart';

class BuildScene extends StatefulWidget {
  const BuildScene({
    Key key,
    @required this.texts,
    @required this.image,
    this.boxFit = BoxFit.cover,
    this.blink = false,
    this.textAnimationReverse = false,
    this.textAnimationType = TextAnimationType.split,
    this.transitionType = TransitionType.circular,
    this.duration = 10000,
    this.blur = false,
  }) : super(key: key);

  final List<String> texts;
  final String image;
  final BoxFit boxFit;
  final bool blink;
  final bool textAnimationReverse;
  final TextAnimationType textAnimationType;
  final TransitionType transitionType;
  final int duration;
  final bool blur;

  @override
  _BuildSceneState createState() => _BuildSceneState();
}

class _BuildSceneState extends State<BuildScene>
    with SingleTickerProviderStateMixin {
  double width, height;

  CurvedTween<double> particlesAnim;

  final particlesSystem = ParticlesSystem();
  bool isParticleSystemInitialized = false;

  bool isOverlay = false;

  @override
  void initState() {
    super.initState();

    particlesAnim = CurvedTween<double>(
      duration: Duration(milliseconds: 3500),
      setState: setState,
      tickerProvider: this,
      begin: -1.0,
      end: 1.0,
      onAnimating: _onAnimating,
      curve: Curves.easeIn,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      particlesSystem.init(
        totalParticles: 350,
        width: context.size.width,
        height: context.size.height,
      );

      particlesAnim.forward();

      isParticleSystemInitialized = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  @override
  void dispose() {
    particlesAnim.dispose();
    super.dispose();
  }

  void _onAnimating(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      particlesAnim.reverse();
    }
    if (status == AnimationStatus.dismissed) {
      particlesAnim.forward();
    }
  }

  double _calcOpacity(bool isOverlay, double animValue) {
    if (!isOverlay && animValue < 0.5) return 1.0;

    if (animValue > 0.0 && animValue < 0.6) return 1.0 - animValue;

    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return CompositeAnimationWidget(
      duration: widget.duration,
      compositeMap: {
        AnimationType.fadeIn: CompositeTween<double>(
          begin: 0.2,
          end: 1.0,
          curve: const Interval(
            0.6,
            0.8,
            curve: Curves.easeIn,
          ),
        ),
        AnimationType.transition: CompositeTween<double>(
          begin: 0.0,
          end: 100.0,
          curve: const Interval(
            0.75,
            1.0,
            curve: Curves.easeIn,
          ),
        ),
        AnimationType.fadeOut: CompositeTween<double>(
          begin: 1.0,
          end: 0.1,
          curve: const Interval(
            0.9,
            1.0,
            curve: Curves.easeIn,
          ),
        ),
      },
      repeat: false,
      builder: (context, comp) {
        return FadeInWidget(
          duration: 1750,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: height,
                width: width / 2,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    if (!isParticleSystemInitialized ||
                        widget.image == imageFilenames[AssetsImages.tunnel])
                      Container()
                    else
                      Opacity(
                        opacity: _calcOpacity(
                          isOverlay,
                          comp.value(AnimationType.fadeIn),
                        ),
                        child: ParticlesSystemPlayer(
                          animation: particlesAnim,
                          particlesSystem: particlesSystem,
                          maxWidth: width,
                          maxHeight: height,
                        ),
                      ),
                    if (widget.image == imageFilenames[AssetsImages.tunnel])
                      Container()
                    else
                      Opacity(
                        opacity:
                            comp.value(AnimationType.fadeOut) < 1.0 ? 0.0 : 0.1,
                        child: Container(
                          width: width,
                          height: height,
                          child: Image.asset(
                            imageFilenames[AssetsImages.rain],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (widget.image == imageFilenames[AssetsImages.tunnel])
                      Container()
                    else
                      Opacity(
                        opacity:
                            comp.value(AnimationType.fadeOut) < 1.0 ? 0.0 : 0.5,
                        child: SmokeBackground(),
                      ),
                    Opacity(
                      opacity: isOverlay ? 0.5 : 0.0,
                      child: Container(
                        width: width,
                        height: height,
                        child: Image.asset(
                          widget.image,
                          fit: widget.boxFit,
                        ),
                      ),
                    ),
                    AnimatedText(
                      textAnimationType: widget.textAnimationType,
                      width: width,
                      texts: !isOverlay ? widget.texts : [''],
                      reverse: widget.textAnimationReverse,
                      onAnimating: (progress) {
                        if (widget.blink) {
                          if (progress >= 30 && progress <= 34 ||
                              progress >= 46 && progress <= 50) {
                            isOverlay = true;
                          } else {
                            isOverlay = false;
                          }
                        }
                      },
                    ),
                    Opacity(
                      opacity: comp.value(AnimationType.fadeOut),
                      child: Opacity(
                        opacity: comp.value(AnimationType.fadeIn),
                        child: Transition(
                          transitionType: widget.transitionType,
                          height: height,
                          width: width,
                          transition: comp.value(AnimationType.transition),
                          image: widget.image,
                          fit: widget.boxFit,
                          blur: widget.blur,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
