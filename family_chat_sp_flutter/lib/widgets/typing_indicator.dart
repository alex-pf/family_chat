import 'package:flutter/material.dart';

/// Анимированный индикатор "пользователь печатает" — пузырь с тремя пульсирующими точками.
class TypingIndicator extends StatefulWidget {
  final String? userName;

  const TypingIndicator({super.key, this.userName});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  static const int _dotCount = 3;
  static const Duration _dotDuration = Duration(milliseconds: 400);
  static const Duration _dotDelay = Duration(milliseconds: 150);

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _dotCount,
      (i) => AnimationController(vsync: this, duration: _dotDuration),
    );
    _animations = _controllers
        .map(
          (c) => Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: c, curve: Curves.easeInOut),
          ),
        )
        .toList();

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    while (mounted) {
      for (int i = 0; i < _dotCount; i++) {
        if (!mounted) return;
        _controllers[i].forward(from: 0);
        await Future.delayed(_dotDelay);
      }
      await Future.delayed(const Duration(milliseconds: 600));
      for (final c in _controllers) {
        if (!mounted) return;
        c.reverse();
      }
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_dotCount, (i) {
                return AnimatedBuilder(
                  animation: _animations[i],
                  builder: (context, child) {
                    return Container(
                      width: 7,
                      height: 7,
                      margin: EdgeInsets.only(
                        right: i < _dotCount - 1 ? 4 : 0,
                        bottom: _animations[i].value * 5,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.onSurfaceVariant
                            .withAlpha(
                              (100 + (_animations[i].value * 155).round()),
                            ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
          if (widget.userName != null) ...[
            const SizedBox(width: 6),
            Text(
              '${widget.userName} печатает...',
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
