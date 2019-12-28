import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

import 'package:booktrailer/widgets/animated_blur.dart';
import 'package:booktrailer/models/models.dart';

class Transition extends StatelessWidget {
  Transition({
    Key key,
    @required this.transitionType,
    @required this.width,
    @required this.height,
    @required this.transition,
    @required this.image,
    @required this.fit,
    this.blur = false,
  }) : super(key: key);

  final TransitionType transitionType;
  final double height;
  final double width;
  final double transition;
  final String image;
  final BoxFit fit;
  final bool blur;

  @override
  Widget build(BuildContext context) {
    Widget child;

    switch (transitionType) {
      case TransitionType.vertical:
        child = TransitionVertical(
          height: height,
          width: width,
          transition: transition,
          image: image,
          fit: fit,
        );
        break;
      case TransitionType.circular:
        child = TransitionCircular(
          height: height,
          width: width,
          transition: transition,
          image: image,
          fit: fit,
        );
        break;
      default:
        child = TransitionHorizontal(
          height: height,
          width: width,
          transition: transition,
          image: image,
          fit: fit,
        );
    }

    if (!blur) return child;

    return AnimatedBlurWeb(
      strength: 12.0,
      duration: 4000,
      child: child,
    );
  }
}

class TransitionVertical extends StatelessWidget {
  const TransitionVertical({
    Key key,
    @required this.width,
    @required this.height,
    @required this.transition,
    @required this.image,
    @required this.fit,
  }) : super(key: key);

  final double width;
  final double height;
  final double transition;
  final String image;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.black,
          height: height,
          width: width,
          child: Image.asset(
            image,
            fit: fit,
          ),
        ),
        Container(
          width: (width / 100) * transition,
          height: height,
          child: Image.asset(
            imageFilenames[AssetsImages.black],
            fit: BoxFit.fill,
          ),
        ),
        Opacity(
          opacity: 1.0 - transition / 100,
          child: Container(
            height: height,
            width: width,
            child: Image.asset(
              image,
              fit: fit,
            ),
          ),
        ),
      ],
    );
  }
}

class TransitionHorizontal extends StatelessWidget {
  const TransitionHorizontal({
    Key key,
    @required this.width,
    @required this.height,
    @required this.transition,
    @required this.image,
    @required this.fit,
  }) : super(key: key);

  final double width;
  final double height;
  final double transition;
  final String image;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.black,
          height: height,
          width: width,
          child: Image.asset(
            image,
            fit: fit,
          ),
        ),
        Opacity(
          opacity: transition / 100,
          child: Container(
            width: width,
            height: (height / 100) * transition,
            child: Image.asset(
              imageFilenames[AssetsImages.black],
              fit: BoxFit.fill,
            ),
          ),
        ),
        Opacity(
          opacity: 1.0 - transition / 100,
          child: Container(
            height: height,
            width: width,
            child: Image.asset(
              image,
              fit: fit,
            ),
          ),
        ),
      ],
    );
  }
}

class TransitionCircular extends StatelessWidget {
  const TransitionCircular({
    Key key,
    @required this.width,
    @required this.height,
    @required this.transition,
    @required this.image,
    @required this.fit,
  }) : super(key: key);

  final double width;
  final double height;
  final double transition;
  final String image;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.black,
          height: height,
          width: width,
          child: Image.asset(
            image,
            fit: fit,
          ),
        ),
        Opacity(
          opacity: (transition / 100),
          child: Transform.scale(
            scale: transition / 50,
            child: Transform.rotate(
              angle: (math.pi / 100) * transition,
              child: Container(
                width: (width / 100) * transition,
                height: (height / 100) * transition,
                child: Image.asset(
                  imageFilenames[AssetsImages.black],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: (1.0 - transition / 100),
          child: Container(
            height: height,
            width: width,
            child: Image.asset(
              image,
              fit: fit,
            ),
          ),
        ),
      ],
    );
  }
}
