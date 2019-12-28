import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:frideos/frideos.dart';

import 'package:booktrailer/models/models.dart';
import 'package:booktrailer/widgets/animated_text.dart';
import 'package:booktrailer/widgets/smoke_background.dart';
import 'package:booktrailer/particles/particles_widget.dart';
import 'package:booktrailer/app_state.dart';
import 'package:booktrailer/widgets/animated_blur.dart';

class LastScene extends StatefulWidget {
  const LastScene({Key key, this.texts}) : super(key: key);

  final List<String> texts;

  @override
  _LastSceneState createState() => _LastSceneState();
}

class _LastSceneState extends State<LastScene> with TickerProviderStateMixin {
  AnimationCurved<double> fadeOut;
  AnimationCurved<double> particlesAnim;

  double width, height;

  @override
  void initState() {
    super.initState();
    fadeOut = AnimationCurved<double>(
      duration: Duration(milliseconds: 1500),
      setState: setState,
      tickerProvider: this,
      begin: 1.0,
      end: 0.0,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    fadeOut.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    return FadeInWidget(
      duration: 2200,
      child: Opacity(
        opacity: fadeOut.value,
        child: AnimationCreate<double>(
          duration: 3000,
          begin: 0.0,
          end: 1.0,
          curve: Curves.linear,
          repeat: true,
          builder: (context, anim) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                if (!appState.isParticlesSystemInitialized)
                  Container()
                else
                  Opacity(
                    opacity: 0.8,
                    child: ParticlesSystemPlayer(
                      particlesSystem: appState.particlesSystem,
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
            );
          },
        ),
      ),
    );
  }
}
