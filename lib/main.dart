import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:frideos/frideos.dart';

import 'package:booktrailer/app_state.dart';
import 'package:booktrailer/pages/play_scenes.dart';
import 'package:booktrailer/models/models.dart';
import 'package:booktrailer/pages/menu.dart';
import 'package:booktrailer/widgets/loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'L\'ultima domenica',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: SetupAssets(),
        ),
      ),
    );
  }
}

class SetupAssets extends StatefulWidget {
  const SetupAssets({
    Key key,
  }) : super(key: key);

  @override
  _SetupAssetsState createState() => _SetupAssetsState();
}

class _SetupAssetsState extends State<SetupAssets> {
  final List<Image> images = [];
  Future<bool> precache;
  int loadingProgress = 0;

  @override
  void initState() {
    super.initState();

    for (var img in AssetsImages.values) {
      images.add(Image.asset(imageFilenames[img]));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precache = precachingImages(context);
  }

  Future<bool> precachingImages(BuildContext context) async {
    for (var image in images) {
      await precacheImage(image.image, context);
      setState(() {
        loadingProgress++;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: precache,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingWidget(
            progress: loadingProgress / (images.length - 1),
          );
        } else {
          return ValueBuilder<bool>(
            streamed: appState.isPlaying,
            builder: (context, snapshot) {
              if (snapshot.data) {
                return PlayScenes(
                  key: Key(appState.playScenesKey),
                  language: appState.lang,
                );
              } else {
                return Menu();
              }
            },
          );
        }
      },
    );
  }
}
