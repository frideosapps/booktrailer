import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import 'package:booktrailer/app_state.dart';
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

  AnimationCurved<double> particlesAnim;

  bool isOverlay = false;

  @override
  void initState() {
    super.initState();

    particlesAnim = AnimationCurved<double>(
      duration: Duration(milliseconds: 3500),
      setState: setState,
      tickerProvider: this,
      begin: -1.0,
      end: 1.0,
      onAnimating: _onAnimating,
      curve: Curves.easeIn,
    );
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
    return CompositeCreate(
      duration: widget.duration,
      compositeMap: {
        AnimationType.fadeIn: CompositeItem<double>(
          begin: 0.2,
          end: 1.0,
          curve: const Interval(
            0.6,
            0.8,
            curve: Curves.easeIn,
          ),
        ),
        AnimationType.transition: CompositeItem<double>(
          begin: 0.0,
          end: 100.0,
          curve: const Interval(
            0.75,
            1.0,
            curve: Curves.easeIn,
          ),
        ),
        AnimationType.fadeOut: CompositeItem<double>(
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
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              if (!appState.isParticleSystemInitialized ||
                  widget.image == imageFilenames[AssetsImages.tunnel])
                Container()
              else
                Opacity(
                  opacity: _calcOpacity(
                    isOverlay,
                    comp.value(AnimationType.fadeIn),
                  ),
                  child: ParticlesSystemPlayer(
                    particlesSystem: appState.particlesSystem,
                  ),
                ),
              if (widget.image == imageFilenames[AssetsImages.tunnel])
                Container()
              else
                Opacity(
                  opacity: comp.progress < 90 ? 0.1 : 0.0,
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
                  opacity: comp.progress < 90 ? 0.5 : 0.0,
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
                opacity: comp.progress <= 80
                    ? comp.value(AnimationType.fadeIn)
                    : comp.value(AnimationType.fadeOut),
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
            ],
          ),
        );
      },
    );
  }
}
