import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class CodeHighlightSlide extends FlutterDeckSlideWidget {
  const CodeHighlightSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/code-highlight',
            title: 'Code Highlight',
            header: FlutterDeckHeaderConfiguration(
              title: 'コードハイライト',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(48),
        child: Center(
          child: FlutterDeckCodeHighlightTheme(
            data: FlutterDeckCodeHighlightTheme.of(context).copyWith(
              textStyle: FlutterDeckTheme.of(context).textTheme.bodySmall,
            ),
            child: const FlutterDeckCodeHighlight(
              code: '''
class _CounterWidget extends StatefulWidget {
  const _CounterWidget();

  @override
  State<_CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<_CounterWidget> {
  int _counter = 0;

  void _increment() => setState(() => _counter++);
  void _decrement() => setState(() => _counter--);
  void _reset() => setState(() => _counter = 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('\$_counter', style: TextStyle(fontSize: 72)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: _decrement, icon: Icon(Icons.remove)),
            IconButton(onPressed: _reset, icon: Icon(Icons.refresh)),
            IconButton(onPressed: _increment, icon: Icon(Icons.add)),
          ],
        ),
      ],
    );
  }
}''',
            fileName: 'counter_widget.dart',
            language: 'dart',
            ),
          ),
        ),
      ),
    );
  }
}
