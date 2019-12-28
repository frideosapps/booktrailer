import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import 'models/particles_system.dart';

class ParticlesSystemPlayer extends StatelessWidget {
  ParticlesSystemPlayer({
    Key key,
    @required this.particlesSystem,
  }) : super(key: key);

  final ParticlesSystem particlesSystem;

  @override
  Widget build(BuildContext context) {
    return AnimationCreate(
        duration: 2500,
        begin: -1.0,
        end: 1.0,
        repeat: true,
        reverse: true,
        curve: Curves.easeIn,
        builder: (context, anim) {
          particlesSystem.update(value: anim.value);

          return Stack(
            alignment: Alignment.center,
            children: [
              for (var p in particlesSystem.particles)
                Positioned(
                  left: p.x,
                  top: p.y,
                  child: Container(
                    height: 4 * p.size,
                    width: 4 * p.size,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(p.alpha),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                ),
            ],
          );
        });
  }
}

