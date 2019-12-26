import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import 'models/particles_system.dart';

class ParticlesWidget extends StatefulWidget {
  ParticlesWidget({Key key, @required this.maxWidth, @required this.maxHeight})
      : super(key: key);

  final double maxWidth, maxHeight;

  @override
  _ParticlesWidgetState createState() => _ParticlesWidgetState();
}

class _ParticlesWidgetState extends State<ParticlesWidget>
    with SingleTickerProviderStateMixin {
  CurvedTween<double> anim;

  double width, height;

  final particlesSystem = ParticlesSystem();

  @override
  void initState() {
    super.initState();

    particlesSystem.init(
      totalParticles: 250,
      width: widget.maxWidth,
      height: widget.maxHeight,
    );

    anim = CurvedTween<double>(
      duration: Duration(milliseconds: 3500),
      setState: setState,
      tickerProvider: this,
      begin: -1.0,
      end: 1.0,
      onAnimating: _onAnimating,
      curve: Curves.easeIn,
    );

    anim.forward();

    width = widget.maxWidth;
    height = widget.maxHeight;
  }

  @override
  void dispose() {
    anim.dispose();
    super.dispose();
  }

  void _onAnimating(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      anim.reverse();
    }
    if (status == AnimationStatus.dismissed) {
      anim.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    particlesSystem.update(value: anim.value);

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Opacity(
              opacity: 0.7,
              child: Container(
                child: Stack(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParticlesSystemPlayer extends StatelessWidget {
  ParticlesSystemPlayer({
    Key key,
    @required this.animation,
    @required this.particlesSystem,
    @required this.maxWidth,
    @required this.maxHeight,
  }) : super(key: key);

  final CurvedTween<double> animation;
  final ParticlesSystem particlesSystem;
  final double maxWidth, maxHeight;

  @override
  Widget build(BuildContext context) {
    particlesSystem.update(value: animation.value);

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Opacity(
              opacity: 0.7,
              child: Container(
                child: Stack(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
