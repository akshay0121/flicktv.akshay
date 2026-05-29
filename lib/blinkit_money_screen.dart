import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lottie/lottie.dart';

import 'widgets/custom_glass_button.dart';
import 'widgets/wallet_widget.dart';

class OnboardingState {
  final bool startWalletRise;
  final bool startConfetti;
  final bool showBrandText;
  final bool showCard1;
  final bool showCard2;
  final bool showCard3;
  final bool showSettings;
  final bool showCta;
  final bool showGiftCard;
  final bool isCompleted;

  const OnboardingState({
    this.startWalletRise = false,
    this.startConfetti = false,
    this.showBrandText = false,
    this.showCard1 = false,
    this.showCard2 = false,
    this.showCard3 = false,
    this.showSettings = false,
    this.showCta = false,
    this.showGiftCard = false,
    this.isCompleted = false,
  });

  OnboardingState copyWith({
    bool? startWalletRise,
    bool? startConfetti,
    bool? showBrandText,
    bool? showCard1,
    bool? showCard2,
    bool? showCard3,
    bool? showSettings,
    bool? showCta,
    bool? showGiftCard,
    bool? isCompleted,
  }) {
    return OnboardingState(
      startWalletRise: startWalletRise ?? this.startWalletRise,
      startConfetti: startConfetti ?? this.startConfetti,
      showBrandText: showBrandText ?? this.showBrandText,
      showCard1: showCard1 ?? this.showCard1,
      showCard2: showCard2 ?? this.showCard2,
      showCard3: showCard3 ?? this.showCard3,
      showSettings: showSettings ?? this.showSettings,
      showCta: showCta ?? this.showCta,
      showGiftCard: showGiftCard ?? this.showGiftCard,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(const OnboardingState());

  final List<Timer> _timers = [];

  void startTimeline() {
    _cancelAllTimers();
    state = const OnboardingState();

    _registerTimer(500, () {
      state = state.copyWith(startWalletRise: true);
    });

    _registerTimer(800, () {
      state = state.copyWith(startConfetti: true);
    });

    _registerTimer(1200, () {
      state = state.copyWith(showBrandText: true);
    });

    _registerTimer(2500, () {
      state = state.copyWith(showCard1: true);
    });

    _registerTimer(2700, () {
      state = state.copyWith(showCard2: true);
    });

    _registerTimer(2900, () {
      state = state.copyWith(showCard3: true);
    });

    _registerTimer(3200, () {
      state = state.copyWith(showSettings: true);
    });

    _registerTimer(3500, () {
      state = state.copyWith(showCta: true);
    });

    _registerTimer(3800, () {
      state = state.copyWith(showGiftCard: true);
    });

    _registerTimer(4000, () {
      state = state.copyWith(isCompleted: true);
    });
  }

  void _registerTimer(int delayMs, VoidCallback action) {
    _timers.add(Timer(Duration(milliseconds: delayMs), action));
  }

  void _cancelAllTimers() {
    for (var timer in _timers) {
      timer.cancel();
    }
    _timers.clear();
  }

  @override
  void dispose() {
    _cancelAllTimers();
    super.dispose();
  }
}

final onboardingStateProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
      return OnboardingNotifier();
    });

class BlinkitMoneyScreen extends ConsumerStatefulWidget {
  const BlinkitMoneyScreen({super.key});

  @override
  ConsumerState<BlinkitMoneyScreen> createState() => _BlinkitMoneyScreenState();
}

class _BlinkitMoneyScreenState extends ConsumerState<BlinkitMoneyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingStateProvider.notifier).startTimeline();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingStateProvider);

    return Scaffold(
      backgroundColor: const Color(0xff0a0a0a),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWebDesktop =
                constraints.maxHeight > 780 && constraints.maxWidth > 500;

            final double canvasWidth = isWebDesktop
                ? 390
                : constraints.maxWidth;
            final double canvasHeight = isWebDesktop
                ? 844
                : constraints.maxHeight;

            return Container(
              width: canvasWidth,
              height: canvasHeight,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xff141414),
                borderRadius: isWebDesktop
                    ? BorderRadius.circular(32)
                    : BorderRadius.zero,
                border: isWebDesktop
                    ? Border.all(color: const Color(0xff2E2E2E), width: 8)
                    : null,
                boxShadow: isWebDesktop
                    ? const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 40,
                          offset: Offset(0, 16),
                        ),
                      ]
                    : null,
              ),
              child: Stack(
                children: [
                  Positioned.fill(child: _buildBackground(canvasHeight)),

                  if (state.startConfetti)
                    Positioned.fill(
                      child: AnimatedOpacity(
                        opacity: state.showCard1 ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 500),
                        child: Lottie.asset(
                          'assets/popper.json',
                          fit: BoxFit.cover,
                          repeat: false,
                        ),
                      ),
                    ),

                  _buildAppBar(state),

                  Positioned.fill(
                    child: SafeArea(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          _buildHeroSection(canvasHeight, state),

                          _buildBottomContentPanel(state),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBackground(double canvasHeight) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff2A2100), Color(0xff141414)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.45],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: canvasHeight * 0.28,
            child: CustomPaint(painter: DotTexturePainter()),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(OnboardingState state) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final double appBarTop = statusBarHeight > 0 ? statusBarHeight + 8 : 16.0;

    return Positioned(
      top: appBarTop,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomGlassButton(
            size: 46,
            blur: 10.0,
            opacity: 0.04,
            color: Colors.white,
            onTap: () {
              ref.read(onboardingStateProvider.notifier).startTimeline();
            },
            child: const Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 28,
            ),
          ),

          AnimatedOpacity(
            opacity: state.showSettings ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: CustomGlassButton(
              size: 46,
              blur: 10.0,
              opacity: 0.04,
              color: Colors.white,
              onTap: () {},
              child: const Icon(
                Icons.settings_outlined,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(double canvasHeight, OnboardingState state) {
    final double targetTopOffset = state.startWalletRise
        ? canvasHeight * 0.15 - 90
        : canvasHeight * 0.45 - 60;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOutCubic,
      top: targetTopOffset,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const WalletWidget(isSwaying: true),
          const SizedBox(height: 10),
          AnimatedOpacity(
            opacity: state.showBrandText ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: AnimatedSlide(
              offset: state.showBrandText ? Offset.zero : const Offset(0, 0.25),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              child: Column(
                children: [
                  Text(
                    'blinkit',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    'MONEY',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      height: 1.15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContentPanel(OnboardingState state) {
    return Positioned(
      bottom: 0,
      left: 16,
      right: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTimelineItem(
            visible: state.showCard1,
            child: _buildFeatureCard(
              iconPath: 'assets/tap.png',
              title: 'Single tap payments',
              subtitle: 'Enjoy seamless payments without the wait for OTPs',
            ),
          ),
          const SizedBox(height: 10),

          _buildTimelineItem(
            visible: state.showCard2,
            child: _buildFeatureCard(
              iconPath: 'assets/zero_fail.png',
              title: 'Zero failures',
              subtitle: 'Zero payment failures ensure you never miss an order',
            ),
          ),
          const SizedBox(height: 10),

          _buildTimelineItem(
            visible: state.showCard3,
            child: _buildFeatureCard(
              iconPath: 'assets/money.png',
              title: 'Real-time refunds',
              subtitle:
                  'No need to wait for refunds. Blinkit Money refunds are instant!',
            ),
          ),
          const SizedBox(height: 14),

          _buildTimelineItem(
            visible: state.showCta,
            slideOffset: const Offset(0, 0.4),
            child: _buildCtaButton(),
          ),
          const SizedBox(height: 10),

          _buildTimelineItem(
            visible: state.showGiftCard,
            slideOffset: const Offset(0, 0.4),
            child: _buildGiftCardRow(),
          ),
          const SizedBox(height: 16),
          _buildMarqueeBackground(state),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required bool visible,
    required Widget child,
    Offset slideOffset = const Offset(0, 0.3),
  }) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset: visible ? Offset.zero : slideOffset,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        child: child,
      ),
    );
  }

  Widget _buildFeatureCard({
    required String iconPath,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xff363636),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xff1E1E1E),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              iconPath,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xffBDBDBD),
                    fontSize: 13,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xff3E8A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          'Add Money',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildGiftCardRow() {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xff222222),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xff2A2A2A),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset('assets/gift-card.png', fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Claim Gift Card',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Enter gift card details to claim your gift card',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xffBDBDBD),
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.white.withOpacity(0.8),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildMarqueeBackground(OnboardingState state) {
    return AnimatedOpacity(
      opacity: state.showGiftCard ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: IgnorePointer(
        child: Text(
          'Enjoy seamless one\ntap payments',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.white.withOpacity(0.12),
            letterSpacing: 0.5,
            height: 1.2,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DotTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffFFD700)
      ..style = PaintingStyle.fill;

    const double spacing = 15.0;
    const double radius = 1.1;

    for (double y = 0; y < size.height; y += spacing) {
      final double progress = y / size.height;
      final double opacity = ((1.0 - progress) * (1.0 - progress)).clamp(
        0.0,
        1.0,
      );

      paint.color = const Color(0xffFFD700).withOpacity(opacity * 0.50);

      final double shift = ((y ~/ spacing) % 2 == 0) ? 0.0 : spacing / 2;

      for (double x = -shift; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x + shift, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
