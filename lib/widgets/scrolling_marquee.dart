import 'package:flutter/material.dart';

class ScrollingMarquee extends StatefulWidget {
  final String text;
  final TextStyle style;
  final double velocity;

  const ScrollingMarquee({
    super.key,
    required this.text,
    required this.style,
    this.velocity = 50.0,
  });

  @override
  State<ScrollingMarquee> createState() => _ScrollingMarqueeState();
}

class _ScrollingMarqueeState extends State<ScrollingMarquee>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRect(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Flow(
                delegate: _MarqueeFlowDelegate(
                  animationValue: _controller.value,
                ),
                children: [_buildTextItem(), _buildTextItem()],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTextItem() {
    return Padding(
      padding: const EdgeInsets.only(right: 32.0),
      child: Text(
        widget.text,
        style: widget.style,
        maxLines: 1,
        softWrap: false,
      ),
    );
  }
}

class _MarqueeFlowDelegate extends FlowDelegate {
  final double animationValue;

  _MarqueeFlowDelegate({required this.animationValue});

  @override
  void paintChildren(FlowPaintingContext context) {
    final width = context.getChildSize(0)!.width;

    double xOffset = -width * animationValue;

    context.paintChild(0, transform: Matrix4.translationValues(xOffset, 0, 0));

    context.paintChild(
      1,
      transform: Matrix4.translationValues(xOffset + width, 0, 0),
    );
  }

  @override
  bool shouldRepaint(covariant _MarqueeFlowDelegate oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
