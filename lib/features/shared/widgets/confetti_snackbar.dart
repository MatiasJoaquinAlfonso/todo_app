import 'dart:math';
import 'package:flutter/material.dart';

class ConfettiSnackbar {
  static void show(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => _ConfettiSnackbarWidget(
        message: message,
        onDismiss: () {
          entry.remove();
        },
      ),
    );

    overlay.insert(entry);
  }
}

class _ConfettiSnackbarWidget extends StatefulWidget {
  final String message;
  final VoidCallback onDismiss;

  const _ConfettiSnackbarWidget({
    required this.message,
    required this.onDismiss,
  });

  @override
  State<_ConfettiSnackbarWidget> createState() => _ConfettiSnackbarWidgetState();
}

class _ConfettiSnackbarWidgetState extends State<_ConfettiSnackbarWidget>
    with TickerProviderStateMixin {
  late final AnimationController _slideController;
  late final AnimationController _confettiController;
  late final List<_ConfettiParticle> _particles;

  @override
  void initState() {
    super.initState();

    // Controls the entire widget sliding up/down
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );

    // Confetti particle animation
    _confettiController = AnimationController(
      vsync: this,
      // duration: const Duration(milliseconds: 1800),
      duration: const Duration(milliseconds: 2500),
    );

    final random = Random();
    _particles = List.generate(20, (i) {
      return _ConfettiParticle(
        x: random.nextDouble(),
        speed: 0.4 + random.nextDouble() * 0.6,
        size: 3.0 + random.nextDouble() * 4.0,
        color: [
          const Color(0xFFFF6B6B),
          const Color(0xFFFFE66D),
          const Color(0xFF4ECDC4),
          const Color(0xFF45B7D1),
          const Color(0xFFA78BFA),
          const Color(0xFFFB923C),
          const Color(0xFF34D399),
          const Color(0xFFF472B6),
        ][random.nextInt(8)],
        horizontalDrift: (random.nextDouble() - 0.5) * 0.4,
        rotation: random.nextDouble() * pi * 2,
        isRect: random.nextBool(),
      );
    });

    _slideController.forward();
    _confettiController.forward();

    // Auto-dismiss: wait, then slide everything back down
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) {
        _slideController.reverse().then((_) {
          if (mounted) widget.onDismiss();
        });
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    // Position: just above the bottom nav bar (nav bar ~56px + safe area)
    final navBarTop = kBottomNavigationBarHeight + bottomPadding;

    return Positioned(
      bottom: navBarTop + 2,
      left: 16,
      right: 16,
      // Snackbar ~52px. We use Clip.none so confetti can overflow above.
      height: 52,
      child: AnimatedBuilder(
        animation: _slideController,
        builder: (context, child) {
          final slideValue = CurvedAnimation(
            parent: _slideController,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          ).value;
          final translateY = (1.0 - slideValue) * 80;

          return Transform.translate(
            offset: Offset(0, translateY),
            child: child,
          );
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Confetti — overflows above and below the snackbar
            Positioned(
              top: -90,
              bottom: -80,
              left: -20,
              right: -20,
              child: AnimatedBuilder(
                animation: _confettiController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _ConfettiPainter(
                      particles: _particles,
                      progress: _confettiController.value,
                    ),
                  );
                },
              ),
            ),

            // Snackbar
            Positioned(
              top: 0,
              left: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF2D2D3A)
                      : const Color(0xFF323240),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded,
                        color: Color(0xFF4ECDC4), size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
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

// ---------------------------------------------------------------------------
// Confetti data & painter
// ---------------------------------------------------------------------------

class _ConfettiParticle {
  final double x;
  final double speed;
  final double size;
  final Color color;
  final double horizontalDrift;
  final double rotation;
  final bool isRect;

  _ConfettiParticle({
    required this.x,
    required this.speed,
    required this.size,
    required this.color,
    required this.horizontalDrift,
    required this.rotation,
    required this.isRect,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;

  _ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Canvas: top=-180 above snackbar, snackbar center ≈ 180+26 = 206
    // Particles burst UP from center, then gravity pulls them down
    final centerY = size.height * 0.7; // snackbar area in the canvas

    for (final p in particles) {
      final t = (progress * (0.5 + p.speed * 0.5)).clamp(0.0, 1.0);

      // Phase 1: burst upward (0→0.35)
      // Phase 2: gravity fall (0.35→1.0)
      final burstT = (t / 0.35).clamp(0.0, 1.0);
      final fallT = ((t - 0.35) / 0.65).clamp(0.0, 1.0);

      final burstUp = Curves.easeOutCubic.transform(burstT) * size.height * 0.45;
      final gravityFall = Curves.easeIn.transform(fallT) * size.height * 0.85;

      final currentY = centerY - burstUp + gravityFall;
      final currentX = size.width * p.x + (p.horizontalDrift * size.width * t);

      // Fade out in the last 30%
      final opacity = t > 0.7 ? (1.0 - ((t - 0.7) / 0.3)) : 1.0;

      final paint = Paint()..color = p.color.withAlpha((opacity * 220).toInt());

      canvas.save();
      canvas.translate(currentX, currentY);
      canvas.rotate(p.rotation + t * pi * 3);

      if (p.isRect) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset.zero, width: p.size, height: p.size * 0.5),
            const Radius.circular(1),
          ),
          paint,
        );
      } else {
        canvas.drawCircle(Offset.zero, p.size * 0.4, paint);
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.progress != progress;
}
