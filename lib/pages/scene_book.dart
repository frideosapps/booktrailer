import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:frideos/frideos.dart';

import 'package:booktrailer/app_state.dart';
import 'package:booktrailer/models/models.dart';
import 'package:booktrailer/particles/particles_widget.dart';

class BookScene extends StatefulWidget {
  const BookScene({
    Key key,
  }) : super(key: key);

  @override
  _BookSceneState createState() => _BookSceneState();
}

class _BookSceneState extends State<BookScene> {
  double width, height;

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
      child: CompositeAnimationWidget(
        duration: 19250,
        repeat: false,
        compositeMap: {
          AnimationType.fadeIn: CompositeTween<double>(
            begin: 0.0,
            end: 1.0,
            curve: const Interval(
              0.0,
              0.3,
              curve: Curves.linear,
            ),
          ),
          AnimationType.scale: CompositeTween<double>(
            begin: 2.8,
            end: 3.2,
            curve: const Interval(
              0.2,
              0.3,
              curve: Curves.linear,
            ),
          ),
          AnimationType.fadeOut: CompositeTween<double>(
            begin: 1.0,
            end: 0.0,
            curve: const Interval(
              1.0,
              1.0,
              curve: Curves.linear,
            ),
          ),
        },
        builder: (context, comp) {
          return Opacity(
            opacity: comp.value(AnimationType.fadeIn),
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.8,
                  child: ParticlesWidget(
                    maxWidth: width,
                    maxHeight: height,
                  ),
                ),
                Opacity(
                  opacity: 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Transform.translate(
                        offset: Offset(
                          0.0,
                          comp.value(AnimationType.scale) * width / 320,
                        ),
                        child: Transform.scale(
                          scale: comp.value(AnimationType.scale),
                          child: Opacity(
                            opacity: comp.value(AnimationType.fadeIn),
                            child: Text(
                              'Francesco Mineo',
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w300,
                                fontSize: 4.0 + (width / 320.0),
                                shadows: [
                                  Shadow(
                                    blurRadius: 0.0,
                                    color: Colors.grey,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 20,
                      ),
                      Transform.translate(
                        offset: Offset(
                          0.0,
                          comp.value(AnimationType.scale) * width / 320,
                        ),
                        child: Transform.scale(
                          scale: comp.value(AnimationType.scale),
                          child: Opacity(
                            opacity: comp.value(AnimationType.fadeIn),
                            child: Text(
                              'L\'ultima domenica',
                              style: TextStyle(
                                color: Colors.red[700],
                                fontWeight: FontWeight.w300,
                                fontSize: 10.0 + (width / 200.0),
                                shadows: [
                                  Shadow(
                                    blurRadius: 1.0,
                                    color: Colors.red[900],
                                    offset: Offset(-0.2, -0.2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: height / 1.8,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(
                              imageFilenames[AssetsImages.coverPhoto],
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              appState.goToMenu();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 5.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                              child: Text(
                                'Menu',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 64,
                          ),
                          GestureDetector(
                            onTap: appState.play,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber,
                                    blurRadius: 5.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                              child: Text(
                                'Replay',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
