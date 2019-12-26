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
      home: LayoutBuilder(
        builder: (context, constraints) {
          return MyHomePage(
            maxWidth: constraints.maxWidth,
            maxHeight: constraints.maxHeight,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.maxWidth, this.maxHeight}) : super(key: key);

  final double maxWidth, maxHeight;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: SetupAssets(),
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

    final completer = Completer<bool>();
    completer.complete(precachingImages(context));
    precache = completer.future;
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
          return LoadingWidget(progress: loadingProgress / (images.length - 1));
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
