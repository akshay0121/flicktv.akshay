import 'dart:ui';
import 'package:flutter/material.dart';

class CustomGlassButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final double size;
  final double blur;
  final double opacity;
  final double borderRadius;
  final Color color;

  const CustomGlassButton({
    super.key,
    required this.child,
    required this.onTap,
    this.size = 48.0,
    this.blur = 12.0,
    this.opacity = 0.15,
    this.borderRadius = 100,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(color: Colors.white.withOpacity(0.01)),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: const Alignment(-0.2, -0.2),
                radius: 1.0,
                colors: [
                  color.withOpacity(opacity * 2.5),
                  color.withOpacity(opacity * 1.0),
                ],
              ),
            ),
          ),

          Positioned.fill(
            child: CustomPaint(
              painter: _GlassBorderPainter(
                strokeWidth: 1.2,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity((opacity * 6.0).clamp(0.0, 0.95)),
                    color.withOpacity(0.0),
                    color.withOpacity(0.0),
                    color.withOpacity((opacity * 6.0).clamp(0.0, 0.95)),
                  ],
                  stops: const [0.1, 0.35, 0.65, 0.9],
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: const Alignment(0.1, 0.1),
                  colors: [
                    color.withOpacity((opacity * 3.0).clamp(0.0, 0.4)),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              splashColor: Colors.white.withOpacity(0.15),
              highlightColor: Colors.transparent,
              child: Center(child: child),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Gradient gradient;

  _GlassBorderPainter({required this.strokeWidth, required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(covariant _GlassBorderPainter oldDelegate) => false;
}
