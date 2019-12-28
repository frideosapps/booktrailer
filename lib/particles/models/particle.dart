import 'dart:math' as math;

class Particle {
  Particle({
    double x,
    double y,
    double velocity,
    double size,
    int direction,
    int alpha,
  }) {
    this.x = x;
    this.y = y;
    this.velocity = velocity;
    this.size = size;
    this.direction = direction;
    this.alpha = alpha;
  }

  double x;
  double y;

  double velocity;
  double size;

  int alpha;

  int direction;

  move(double width, double height, double value) {
    final rnd = math.Random();
    x += direction * velocity + value;
    y += velocity;

    if (y > height || x < 0.0 || x > width) {
      y = 0.0;
      x = rnd.nextInt(height.toInt()).toDouble();
      size = 0.5 + rnd.nextDouble() * 0.5;
    }
  }
}
