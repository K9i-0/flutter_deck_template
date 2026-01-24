import 'dart:async';

import 'package:flutter/material.dart';

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
        GestureDetector(
          onTap: _toggleMenu,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  _formatDuration(_stopwatch.elapsed),
                  style: TextStyle(
                    color: _isRunning ? Colors.white : Colors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  _showMenu ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white54,
                  size: 14,
                ),
              ],
            ),
          ),
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
