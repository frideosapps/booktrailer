import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:frideos/frideos.dart';

import 'package:booktrailer/models/models.dart';
import 'package:booktrailer/widgets/animated_text.dart';
import 'package:booktrailer/widgets/smoke_background.dart';
import 'package:booktrailer/particles/particles_widget.dart';
import 'package:booktrailer/particles/models/particles_system.dart';
import 'package:booktrailer/widgets/animated_blur.dart';

class LastScene extends StatefulWidget {
  const LastScene({Key key, this.texts}) : super(key: key);

  final List<String> texts;

  @override
  _LastSceneState createState() => _LastSceneState();
}

class _LastSceneState extends State<LastScene> with TickerProviderStateMixin {
  CurvedTween<double> fadeOut;
  CurvedTween<double> particlesAnim;

  final particlesSystem = ParticlesSystem();
  bool isParticleSystemInitialized = false;

  double width, height;

  @override
  void initState() {
    super.initState();
    fadeOut = CurvedTween<double>(
      duration: Duration(milliseconds: 1500),
      setState: setState,
      tickerProvider: this,
      begin: 1.0,
      end: 0.0,
      curve: Curves.linear,
    );

    particlesAnim = CurvedTween<double>(
      duration: Duration(milliseconds: 3500),
      setState: setState,
      tickerProvider: this,
      begin: -1.0,
      end: 1.0,
      onAnimating: _onAnimating,
      curve: Curves.easeIn,
    );

    particlesAnim.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      particlesSystem.init(
          totalParticles: 350,
          width: context.size.width,
          height: context.size.height);
      isParticleSystemInitialized = true;
    });
  }

  @override
  void dispose() {
    fadeOut.dispose();
    particlesAnim.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  void _onAnimating(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      particlesAnim.reverse();
    }
    if (status == AnimationStatus.dismissed) {
      particlesAnim.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeInWidget(
      duration: 2200,
      child: Opacity(
        opacity: fadeOut.value,
        child: AnimationWidget<double>(
          duration: 3000,
          begin: 0.0,
          end: 1.0,
          curve: Curves.linear,
          repeat: true,
          builder: (context, anim) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: height,
                  width: width / 2,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      if (!isParticleSystemInitialized)
                        Container()
                      else
                        Opacity(
                          opacity: 1.0,
                          child: ParticlesSystemPlayer(
                            animation: particlesAnim,
                            particlesSystem: particlesSystem,
                            maxWidth: width,
                            maxHeight: height,
                          ),
                        ),
                      AnimatedBlurWeb(
                        strength: 12.0,
                        duration: 4000,
                        child: Opacity(
                          opacity: 0.1,
                          child: Container(
                            width: width,
                            height: height,
                            child: Image.asset(
                              imageFilenames[AssetsImages.rain],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Opacity(opacity: 0.6, child: SmokeBackground()),
                      AnimatedTextScale(
                        width: width,
                        texts: widget.texts,
                        isLastScene: true,
                        reverse: true,
                        onCompleted: fadeOut.forward,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
