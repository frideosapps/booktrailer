import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:booktrailer/models/models.dart';
import 'package:booktrailer/widgets/animated_blur.dart';

const smokeScale = 1.5;

class SmokeBackground extends StatelessWidget {
  const SmokeBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: smokeScale,
      child: AnimatedBlurWeb(
        child: SmokeWidget(),
      ),
    );
  }
}

class SmokeWidget extends StatelessWidget {
  const SmokeWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(imageFilenames[AssetsImages.smoke]),
        ),
      ),
      alignment: Alignment.bottomCenter,
    );
  }
}
