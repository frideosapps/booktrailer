import 'dart:math' as math;

import 'particle.dart';

class ParticlesSystem {
  int totalParticles;
  double width, height;
  double originX, originY;

  List<Particle> particles;

  void init({int totalParticles, double width, double height}) {
    this.totalParticles = totalParticles;
    this.width = width;
    this.height = height;
    originX = width / 2;
    originY = height / 2;
    particles = List<Particle>();
    final rnd = math.Random();

    for (var i = 0; i < totalParticles; i++) {
      final x = rnd.nextDouble() * width;
      final y = rnd.nextDouble() * height;
      final velocity = rnd.nextDouble() * 1.5;
      final size = 0.25 + rnd.nextDouble();
      final direction = rnd.nextDouble() > 0.5 ? 1 : -1;
      final alpha = rnd.nextInt(155);

      particles.add(
        Particle(
          x: x,
          y: y,
          velocity: velocity,
          size: size,
          direction: direction,
          alpha: alpha,
        ),
      );
    }
  }

  void update({double value}) {
    for (var particle in particles) {
      particle.move(width, height, value);
    }
  }
}
