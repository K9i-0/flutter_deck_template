import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class InteractiveCounterSlide extends FlutterDeckSlideWidget {
  const InteractiveCounterSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/interactive-counter',
            title: 'Interactive Counter',
            header: FlutterDeckHeaderConfiguration(
              title: 'インタラクティブデモ',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const Center(
        child: _CounterWidget(),
      ),
    );
  }
}

class _CounterWidget extends StatefulWidget {
  const _CounterWidget();

  @override
  State<_CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<_CounterWidget> {
  int _counter = 0;

  static const _primaryColor = Color(0xFF6366f1);

  void _increment() => setState(() => _counter++);
  void _decrement() => setState(() => _counter--);
  void _reset() => setState(() => _counter = 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'カウンター',
          style: FlutterDeckTheme.of(context).textTheme.header,
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6366f1), Color(0xFF8b5cf6)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            '$_counter',
            style: const TextStyle(
              fontSize: 120,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 48),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              onPressed: _decrement,
              icon: Icons.remove,
              label: '-1',
            ),
            const SizedBox(width: 24),
            _buildButton(
              onPressed: _reset,
              icon: Icons.refresh,
              label: 'リセット',
            ),
            const SizedBox(width: 24),
            _buildButton(
              onPressed: _increment,
              icon: Icons.add,
              label: '+1',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
