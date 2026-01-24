import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

/// Global slide navigation callbacks.
///
/// These callbacks are set from within the FlutterDeck context
/// and can be called from outside (e.g., from PresentationTimer).
class SlideNavigation {
  SlideNavigation._();

  static VoidCallback? _goNext;
  static VoidCallback? _goPrevious;

  /// Navigate to the next slide.
  static void next() => _goNext?.call();

  /// Navigate to the previous slide.
  static void previous() => _goPrevious?.call();

  /// Register navigation callbacks from FlutterDeck context.
  static void register(BuildContext context) {
    final flutterDeck = FlutterDeck.of(context);
    _goNext = () => flutterDeck.next();
    _goPrevious = () => flutterDeck.previous();
  }

  /// Check if navigation is available.
  static bool get isAvailable => _goNext != null && _goPrevious != null;
}

/// A widget that registers slide navigation callbacks.
///
/// Place this widget inside the FlutterDeck widget tree to enable
/// external navigation control.
class SlideNavigationRegistrar extends StatefulWidget {
  const SlideNavigationRegistrar({required this.child, super.key});

  final Widget child;

  @override
  State<SlideNavigationRegistrar> createState() =>
      _SlideNavigationRegistrarState();
}

class _SlideNavigationRegistrarState extends State<SlideNavigationRegistrar> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SlideNavigation.register(context);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
