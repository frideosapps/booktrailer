import 'dart:html' as html;

import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import 'package:booktrailer/app_state.dart';
import 'package:booktrailer/particles/particles_widget.dart';
import 'package:booktrailer/models/models.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin {
  double width, height;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appState.particlesSystem.init(
        totalParticles: 150,
        width: context.size.width,
        height: context.size.height,
      );

      setState(() {
        appState.isParticlesSystemInitialized = true;
      });
    });
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
      duration: 1500,
      child: Container(
        child: Stack(
          children: [
            if (appState.isParticlesSystemInitialized)
              Opacity(
                opacity: 0.8,
                child: ParticlesSystemPlayer(
                  particlesSystem: appState.particlesSystem,
                ),
              )
            else
              Container(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Container(
                  height: height / 1.4,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(
                        imageFilenames[AssetsImages.cover],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        appState.lang = Language.english;
                        appState.play();
                      },
                      child: LanguageWidget(
                        text: 'English',
                      ),
                    ),
                    SizedBox(
                      width: 64,
                    ),
                    GestureDetector(
                      onTap: () {
                        appState.lang = Language.italian;
                        appState.play();
                      },
                      child: LanguageWidget(
                        text: 'Italiano',
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Made with ❤️ with ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              html.window.open(
                                  'https://www.flutter.dev', 'Flutter website');
                            },
                            child: Text(
                              'Flutter',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                height: 1.5,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Copyright 2019-2020 - Francesco Mineo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.white70,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(color: Colors.white, blurRadius: 3.0, spreadRadius: 3.0),
          ]),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
