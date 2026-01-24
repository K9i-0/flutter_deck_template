import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/slide_navigation.dart';

enum TimerSize {
  small(
    label: 'S',
    fontSize: 14,
    iconSize: 16,
    expandIconSize: 14,
    paddingH: 12,
    paddingV: 6,
    spacing: 6,
  ),
  medium(
    label: 'M',
    fontSize: 24,
    iconSize: 26,
    expandIconSize: 20,
    paddingH: 16,
    paddingV: 10,
    spacing: 8,
  ),
  large(
    label: 'L',
    fontSize: 36,
    iconSize: 38,
    expandIconSize: 28,
    paddingH: 20,
    paddingV: 14,
    spacing: 10,
  );

  const TimerSize({
    required this.label,
    required this.fontSize,
    required this.iconSize,
    required this.expandIconSize,
    required this.paddingH,
    required this.paddingV,
    required this.spacing,
  });

  final String label;
  final double fontSize;
  final double iconSize;
  final double expandIconSize;
  final double paddingH;
  final double paddingV;
  final double spacing;

  TimerSize get next => TimerSize.values[(index + 1) % TimerSize.values.length];
}

class PresentationTimer extends StatefulWidget {
  const PresentationTimer({super.key});

  @override
  State<PresentationTimer> createState() => _PresentationTimerState();
}

class _PresentationTimerState extends State<PresentationTimer> {
  late final Stopwatch _stopwatch;
  late final Timer _timer;
  bool _isVisible = true;
  bool _showMenu = false;
  TimerSize _size = TimerSize.small;

  bool get _isRunning => _stopwatch.isRunning;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    setState(() {
      if (_isRunning) {
        _stopwatch.stop();
      } else {
        _stopwatch.start();
      }
      _showMenu = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _stopwatch.reset();
      _stopwatch.start();
      _showMenu = false;
    });
  }

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
      _showMenu = false;
    });
  }

  void _toggleMenu() {
    setState(() {
      _showMenu = !_showMenu;
    });
  }

  void _cycleSize() {
    setState(() {
      _size = _size.next;
      _showMenu = false;
    });
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return GestureDetector(
        onTap: _toggleVisibility,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.timer_outlined,
            color: Colors.white54,
            size: 16,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Timer
            GestureDetector(
              onTap: _toggleMenu,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _size.paddingH,
                  vertical: _size.paddingV,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isRunning ? Icons.timer_outlined : Icons.pause_rounded,
                      color: _isRunning ? Colors.white : Colors.orange,
                      size: _size.iconSize,
                    ),
                    SizedBox(width: _size.spacing),
                    Text(
                      _formatDuration(_stopwatch.elapsed),
                      style: TextStyle(
                        color: _isRunning ? Colors.white : Colors.orange,
                        fontSize: _size.fontSize,
                        fontWeight: FontWeight.w500,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    SizedBox(width: _size.spacing * 0.6),
                    Icon(
                      _showMenu ? Icons.expand_less : Icons.expand_more,
                      color: Colors.white54,
                      size: _size.expandIconSize,
                    ),
                  ],
                ),
              ),
            ),
            // Navigation buttons (debug mode only)
            if (kDebugMode) ...[
              const SizedBox(width: 8),
              _NavigationButtons(size: _size),
            ],
          ],
        ),
        if (_showMenu) ...[
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _MenuButton(
                  icon: _isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  label: _isRunning ? '一時停止' : '再開',
                  onTap: _toggleTimer,
                ),
                _MenuButton(
                  icon: Icons.refresh_rounded,
                  label: 'リセット',
                  onTap: _resetTimer,
                ),
                _MenuButton(
                  icon: Icons.text_fields_rounded,
                  label: 'サイズ: ${_size.label} → ${_size.next.label}',
                  onTap: _cycleSize,
                ),
                const Divider(height: 1, color: Colors.white24),
                _MenuButton(
                  icon: Icons.visibility_off_rounded,
                  label: '非表示',
                  onTap: _toggleVisibility,
                  color: Colors.white54,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = Colors.white,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationButtons extends StatelessWidget {
  const _NavigationButtons({required this.size});

  final TimerSize size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.paddingH * 0.5,
        vertical: size.paddingV,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            key: const ValueKey('nav_previous'),
            onTap: SlideNavigation.previous,
            child: Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: size.iconSize,
            ),
          ),
          SizedBox(width: size.spacing * 0.5),
          GestureDetector(
            key: const ValueKey('nav_next'),
            onTap: SlideNavigation.next,
            child: Icon(
              Icons.chevron_right_rounded,
              color: Colors.white,
              size: size.iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
