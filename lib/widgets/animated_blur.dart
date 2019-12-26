import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:frideos/frideos.dart';

class AnimatedBlurWeb extends StatelessWidget {
  const AnimatedBlurWeb({
    Key key,
    this.child,
    this.strength = 9.0,
    this.duration = 4000,
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  final Widget child;
  final double strength;
  final int duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        AnimationWidget<double>(
          begin: strength,
          end: -strength,
          curve: curve,
          duration: duration,
          repeat: true,
          builder: (context, animMov) {
            return Transform.translate(
              offset: Offset(animMov.value, 0.0),
              child: Opacity(
                opacity: 0.5,
                child: child,
              ),
            );
          },
        ),
        AnimationWidget<double>(
          begin: -strength,
          end: strength,
          curve: curve,
          duration: duration,
          repeat: true,
          builder: (context, animMov) {
            return Transform.translate(
              offset: Offset(animMov.value, 0.0),
              child: Opacity(
                opacity: 0.3,
                child: child,
              ),
            );
          },
        ),
      ],
    );
  }
}
