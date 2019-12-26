import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import 'package:booktrailer/models/models.dart';
import 'package:booktrailer/pages/scene_book.dart';
import 'package:booktrailer/pages/scene_last.dart';
import 'package:booktrailer/widgets/scene_widget.dart';

class PlayScenes extends StatelessWidget {
  const PlayScenes({
    Key key,
    @required this.language,
  }) : super(key: key);

  final Language language;

  @override
  Widget build(BuildContext context) {
    return FadeInWidget(
      duration: 2500,
      child: ScenesWidget(
        scenes: [
          Scene(
            widget: SceneWidget(
              key: Key('1'),
              texts: textsScenes[TrailerScene.first][language],
              image: imageFilenames[AssetsImages.city],
              transitionType: TransitionType.circular,
              textAnimationType: TextAnimationType.scale,
              duration: 11500,
            ),
            time: 11500,
          ),
          Scene(
            widget: SceneWidget(
              key: Key('2'),
              texts: textsScenes[TrailerScene.second][language],
              image: imageFilenames[AssetsImages.man],
              transitionType: TransitionType.vertical,
              textAnimationType: TextAnimationType.split,
              duration: 11500,
              blur: true,
              blink: true,
            ),
            time: 11500,
          ),
          Scene(
            widget: SceneWidget(
              key: Key('3'),
              texts: textsScenes[TrailerScene.third][language],
              image: imageFilenames[AssetsImages.alone],
              boxFit: BoxFit.fitHeight,
              transitionType: TransitionType.vertical,
              textAnimationType: TextAnimationType.scale,
              textAnimationReverse: true,
              duration: 11500,
            ),
            time: 11500,
          ),
          Scene(
            widget: SceneWidget(
              key: Key('4'),
              texts: textsScenes[TrailerScene.fourth][language],
              image: imageFilenames[AssetsImages.tunnel],
              transitionType: TransitionType.circular,
              textAnimationType: TextAnimationType.split,
              duration: 10000,
              blur: true,
            ),
            time: 10000,
          ),
          Scene(
            widget: SceneWidget(
              key: Key('5'),
              texts: textsScenes[TrailerScene.fifth][language],
              image: imageFilenames[AssetsImages.eyes],
              transitionType: TransitionType.vertical,
              textAnimationType: TextAnimationType.scale,
              duration: 10000,
            ),
            time: 10000,
          ),
          Scene(
            widget: LastScene(
              key: Key('6'),
              texts: textsScenes[TrailerScene.sixth][language],
            ),
            time: 14000,
          ),
          Scene(
            widget: BookScene(
              key: Key('7'),
            ),
            time: 11000,
          ),
        ],
      ),
    );
  }
}
