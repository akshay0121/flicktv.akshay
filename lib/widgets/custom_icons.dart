import 'dart:math' as math;
import 'package:flutter/material.dart';

class FeatureIconWrapper extends StatelessWidget {
  final Widget child;

  const FeatureIconWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: const Color(0xff141414),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xff2A2A2A), width: 1.5),
        boxShadow: const [
          BoxShadow(color: Colors.black38, offset: Offset(0, 4), blurRadius: 8),
        ],
      ),
      child: Center(child: child),
    );
  }
}

class SingleTapPaymentIcon extends StatelessWidget {
  const SingleTapPaymentIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureIconWrapper(
      child: CustomPaint(
        size: const Size(48, 48),
        painter: _SingleTapPainter(),
      ),
    );
  }
}

class _SingleTapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final phonePaint = Paint()
      ..color = const Color(0xff2E2E2E)
      ..style = PaintingStyle.fill;

    final phoneOutlinePaint = Paint()
      ..color = const Color(0xff4A4A4A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.save();
    canvas.translate(center.dx - 4, center.dy);
    canvas.rotate(-0.08);

    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: 22, height: 38),
      const Radius.circular(5),
    );
    canvas.drawRRect(phoneRect, phonePaint);
    canvas.drawRRect(phoneRect, phoneOutlinePaint);

    final screenPaint = Paint()
      ..shader =
          const LinearGradient(
            colors: [Color(0xffF5C518), Color(0xffD4920A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(
            Rect.fromCenter(center: Offset.zero, width: 18, height: 30),
          )
      ..style = PaintingStyle.fill;

    final screenRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: const Offset(0, -2), width: 18, height: 30),
      const Radius.circular(3),
    );
    canvas.drawRRect(screenRect, screenPaint);

    final dotPaint = Paint()
      ..color = const Color(0xff888888)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(0, 16), 1.5, dotPaint);

    canvas.restore();

    final tapPoint = Offset(center.dx + 4, center.dy - 6);
    final ripplePaint = Paint()
      ..color = const Color(0xffF5C518).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(tapPoint, 5, ripplePaint);
    canvas.drawCircle(
      tapPoint,
      9,
      Paint()
        ..color = const Color(0xffF5C518).withOpacity(0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    final handPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final handOutline = Paint()
      ..color = const Color(0xff141414)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final handPath = Path();
    handPath.moveTo(42, 44);
    handPath.quadraticBezierTo(38, 36, 32, 32);
    handPath.lineTo(26, 20);
    handPath.arcToPoint(
      const Offset(22, 22),
      radius: const Radius.circular(2.5),
      clockwise: false,
    );
    handPath.lineTo(27, 31);

    handPath.lineTo(24, 29);
    handPath.arcToPoint(
      const Offset(22, 32),
      radius: const Radius.circular(2.0),
      clockwise: false,
    );
    handPath.lineTo(27, 35);

    handPath.lineTo(26, 34);
    handPath.arcToPoint(
      const Offset(24, 37),
      radius: const Radius.circular(2.0),
      clockwise: false,
    );
    handPath.lineTo(29, 39);

    handPath.lineTo(29, 39);
    handPath.arcToPoint(
      const Offset(28, 42),
      radius: const Radius.circular(2.0),
      clockwise: false,
    );

    handPath.lineTo(34, 44);
    handPath.quadraticBezierTo(36, 40, 34, 35);
    handPath.arcToPoint(
      const Offset(31, 33),
      radius: const Radius.circular(2.0),
      clockwise: false,
    );
    handPath.lineTo(30, 36);
    handPath.lineTo(33, 44);
    handPath.close();

    canvas.save();
    canvas.translate(8, -12);
    canvas.drawPath(handPath, handPaint);
    canvas.drawPath(handPath, handOutline);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ZeroFailuresIcon extends StatelessWidget {
  const ZeroFailuresIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureIconWrapper(
      child: CustomPaint(
        size: const Size(48, 48),
        painter: _ZeroFailuresPainter(),
      ),
    );
  }
}

class _ZeroFailuresPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final phonePaint = Paint()
      ..color = const Color(0xff2E2E2E)
      ..style = PaintingStyle.fill;

    final phoneOutlinePaint = Paint()
      ..color = const Color(0xff4A4A4A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.save();
    canvas.translate(center.dx - 2, center.dy + 4);
    canvas.rotate(0.05);

    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: 20, height: 36),
      const Radius.circular(4),
    );
    canvas.drawRRect(phoneRect, phonePaint);
    canvas.drawRRect(phoneRect, phoneOutlinePaint);

    final screenPaint = Paint()
      ..color = const Color(0xff1A1A1A)
      ..style = PaintingStyle.fill;
    final screenRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: const Offset(0, -1), width: 16, height: 28),
      const Radius.circular(2.5),
    );
    canvas.drawRRect(screenRect, screenPaint);

    final checkPaint = Paint()
      ..color = const Color(0xffF5C518)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    final checkPath = Path()
      ..moveTo(-3, 0)
      ..lineTo(-1, 2)
      ..lineTo(3, -2);
    canvas.drawPath(checkPath, checkPaint);

    canvas.restore();

    final signalPaint = Paint()
      ..color = const Color(0xffF5C518)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final origin = Offset(center.dx - 2, center.dy - 12);

    canvas.drawArc(
      Rect.fromCircle(center: origin, radius: 8),
      -math.pi * 0.8,
      math.pi * 0.6,
      false,
      signalPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: origin, radius: 14),
      -math.pi * 0.85,
      math.pi * 0.7,
      false,
      signalPaint..color = const Color(0xffF5C518).withOpacity(0.7),
    );

    canvas.drawArc(
      Rect.fromCircle(center: origin, radius: 20),
      -math.pi * 0.9,
      math.pi * 0.8,
      false,
      signalPaint..color = const Color(0xffD4920A).withOpacity(0.4),
    );

    final handPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final handOutline = Paint()
      ..color = const Color(0xff141414)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final handPath = Path()
      ..moveTo(6, 44)
      ..quadraticBezierTo(14, 38, 20, 36)
      ..lineTo(22, 38)
      ..quadraticBezierTo(24, 37, 24, 39)
      ..lineTo(22, 41)
      ..quadraticBezierTo(24, 40, 24, 42)
      ..lineTo(21, 44)
      ..close();

    canvas.save();
    canvas.translate(0, 4);
    canvas.drawPath(handPath, handPaint);
    canvas.drawPath(handPath, handOutline);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RealTimeRefundsIcon extends StatelessWidget {
  const RealTimeRefundsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureIconWrapper(
      child: CustomPaint(
        size: const Size(48, 48),
        painter: _RealTimeRefundsPainter(),
      ),
    );
  }
}

class _RealTimeRefundsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final phonePaint = Paint()
      ..color = const Color(0xff2E2E2E)
      ..style = PaintingStyle.fill;

    final phoneOutlinePaint = Paint()
      ..color = const Color(0xff4A4A4A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.save();
    canvas.translate(center.dx - 6, center.dy + 4);
    canvas.rotate(-0.1);

    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: 20, height: 36),
      const Radius.circular(4),
    );
    canvas.drawRRect(phoneRect, phonePaint);
    canvas.drawRRect(phoneRect, phoneOutlinePaint);

    final screenPaint = Paint()
      ..color = const Color(0xff1A1A1A)
      ..style = PaintingStyle.fill;
    final screenRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: const Offset(0, -1), width: 16, height: 28),
      const Radius.circular(2.5),
    );
    canvas.drawRRect(screenRect, screenPaint);

    canvas.restore();

    canvas.save();
    canvas.translate(center.dx + 8, center.dy - 10);
    canvas.rotate(0.25);

    final moneyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: 24, height: 14),
      const Radius.circular(3),
    );

    final moneyPaint = Paint()
      ..shader =
          const LinearGradient(
            colors: [Color(0xffFFD600), Color(0xffD4920A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(
            Rect.fromCenter(center: Offset.zero, width: 24, height: 14),
          )
      ..style = PaintingStyle.fill;

    canvas.drawRRect(moneyRect, moneyPaint);

    final textPainter = TextPainter(
      text: const TextSpan(
        text: '₹',
        style: TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );

    canvas.restore();

    final motionPaint = Paint()
      ..color = const Color(0xffF5C518).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(center.dx + 4, center.dy + 2), radius: 10),
      -math.pi * 0.4,
      math.pi * 0.5,
      false,
      motionPaint,
    );

    final handPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final handOutline = Paint()
      ..color = const Color(0xff141414)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final handPath = Path()
      ..moveTo(2, 44)
      ..quadraticBezierTo(8, 38, 14, 37)
      ..lineTo(16, 39)
      ..quadraticBezierTo(18, 38, 18, 40)
      ..lineTo(16, 42)
      ..quadraticBezierTo(18, 41, 18, 43)
      ..lineTo(14, 44)
      ..close();

    canvas.save();
    canvas.translate(0, 4);
    canvas.drawPath(handPath, handPaint);
    canvas.drawPath(handPath, handOutline);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GiftCardIcon extends StatelessWidget {
  const GiftCardIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xff302405),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xff5A4A00).withOpacity(0.4),
          width: 1.0,
        ),
      ),
      child: Center(
        child: CustomPaint(
          size: const Size(32, 32),
          painter: _GiftCardPainter(),
        ),
      ),
    );
  }
}

class _GiftCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    final boxRect = Rect.fromLTRB(cx - 10, cy - 3, cx + 10, cy + 10);
    final boxPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xffE040FB), Color(0xffFF1744)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(boxRect)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(boxRect, const Radius.circular(2)),
      boxPaint,
    );

    final lidRect = Rect.fromLTRB(cx - 11, cy - 7, cx + 11, cy - 3);
    final lidPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xffFF3D7F), Color(0xffE040FB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(lidRect)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(lidRect, const Radius.circular(1.5)),
      lidPaint,
    );

    final ribbonPaint = Paint()
      ..color = const Color(0xffFFD600)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(cx - 2, cy - 7, cx + 2, cy + 10),
      ribbonPaint,
    );
    canvas.drawRect(
      Rect.fromLTRB(cx - 11, cy - 5, cx + 11, cy - 4),
      ribbonPaint,
    );

    final bowPaint = Paint()
      ..color = const Color(0xffFFD600)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final leftBowPath = Path()
      ..moveTo(cx, cy - 7)
      ..cubicTo(cx - 6, cy - 13, cx - 8, cy - 7, cx, cy - 7);
    canvas.drawPath(leftBowPath, bowPaint);

    final rightBowPath = Path()
      ..moveTo(cx, cy - 7)
      ..cubicTo(cx + 6, cy - 13, cx + 8, cy - 7, cx, cy - 7);
    canvas.drawPath(rightBowPath, bowPaint);

    canvas.drawLine(
      Offset(cx, cy - 7),
      Offset(cx - 4, cy - 4),
      bowPaint..strokeWidth = 1.5,
    );
    canvas.drawLine(Offset(cx, cy - 7), Offset(cx + 4, cy - 4), bowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
