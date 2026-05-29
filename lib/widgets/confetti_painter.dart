import 'dart:math' as math;
import 'package:flutter/material.dart';

class ConfettiWidget extends StatefulWidget {
  final bool trigger;

  const ConfettiWidget({super.key, required this.trigger});

  @override
  State<ConfettiWidget> createState() => _ConfettiWidgetState();
}

class _ConfettiWidgetState extends State<ConfettiWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_ConfettiParticle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _controller.addListener(() {
      _updateParticles();
    });

    if (widget.trigger) {
      _spawnAndStart();
    }
  }

  @override
  void didUpdateWidget(covariant ConfettiWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger && !oldWidget.trigger) {
      _spawnAndStart();
    }
  }

  void _spawnAndStart() {
    _particles.clear();
    const colors = [
      Color(0xffFF3D7F),
      Color(0xff00E5D1),
      Color(0xff2979FF),
      Color(0xff76FF03),
      Color(0xffFFD600),
      Color(0xffE040FB),
      Color(0xffFF1744),
    ];

    for (int i = 0; i < 55; i++) {
      final xSpeed = _random.nextDouble() * 200 - 100;
      final ySpeed = -(_random.nextDouble() * 150 + 150);

      _particles.add(
        _ConfettiParticle(
          x: 0.2 + _random.nextDouble() * 0.6,
          y: -0.05,
          vx: xSpeed,
          vy: ySpeed,
          color: colors[_random.nextInt(colors.length)],
          rotation: _random.nextDouble() * math.pi * 2,
          rotationSpeed: _random.nextDouble() * 8 - 4,
          width: 5 + _random.nextDouble() * 4,
          height: 10 + _random.nextDouble() * 6,
          opacity: 1.0,
        ),
      );
    }

    _controller.forward(from: 0.0);
  }

  void _updateParticles() {
    final double dt = 1 / 60;
    const double gravity = 400.0;
    const double drag = 0.95;

    for (var p in _particles) {
      p.vy += gravity * dt;
      p.vx *= drag;
      p.vy *= drag;

      p.x += (p.vx * dt) / 360;
      p.y += (p.vy * dt) / 780;

      p.rotation += p.rotationSpeed * dt;

      if (_controller.value > 0.7) {
        p.opacity = ((1.0 - _controller.value) / 0.3).clamp(0.0, 1.0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.trigger) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: _ConfettiPainter(particles: _particles),
        );
      },
    );
  }
}

class _ConfettiParticle {
  double x;
  double y;
  double vx;
  double vy;
  Color color;
  double rotation;
  double rotationSpeed;
  double width;
  double height;
  double opacity;

  _ConfettiParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.color,
    required this.rotation,
    required this.rotationSpeed,
    required this.width,
    required this.height,
    required this.opacity,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;

  _ConfettiPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      if (p.opacity <= 0) continue;

      final paint = Paint()
        ..color = p.color.withOpacity(p.opacity)
        ..style = PaintingStyle.fill;

      final px = p.x * size.width;
      final py = p.y * size.height;

      if (py > size.height) continue;

      canvas.save();
      canvas.translate(px, py);
      canvas.rotate(p.rotation);

      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: p.width, height: p.height),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => true;
}
