import 'dart:math' as math;
import 'package:flutter/material.dart';

class WalletWidget extends StatefulWidget {
  final bool isSwaying;

  const WalletWidget({super.key, required this.isSwaying});

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _wobbleController;

  @override
  void initState() {
    super.initState();
    _wobbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    if (widget.isSwaying) {
      _wobbleController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant WalletWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSwaying && !_wobbleController.isAnimating) {
      _wobbleController.repeat(reverse: true);
    } else if (!widget.isSwaying && _wobbleController.isAnimating) {
      _wobbleController.stop();
    }
  }

  @override
  void dispose() {
    _wobbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _wobbleController,
      builder: (context, child) {
        final double wobbleFactor = widget.isSwaying
            ? Curves.easeInOut.transform(_wobbleController.value) * 2 - 1
            : 0.0;

        final double swayAngle = wobbleFactor * (8 * math.pi / 180);

        final baseAngleZ = -10 * math.pi / 180;
        final totalAngleZ = baseAngleZ + swayAngle;

        final double floatOffsetY = wobbleFactor * 4.0;

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(-0.05)
            ..rotateY(0.2)
            ..rotateZ(totalAngleZ)
            ..translate(0.0, floatOffsetY, 0.0),
          alignment: Alignment.center,
          child: _buildWalletBody(),
        );
      },
    );
  }

  Widget _buildWalletBody() {
    return Container(
      width: 120,
      height: 120,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 5,
            child: Container(
              width: 110,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.50),
                    blurRadius: 24,
                    spreadRadius: 3,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            'assets/wallet.png',
            width: 110,
            height: 110,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
