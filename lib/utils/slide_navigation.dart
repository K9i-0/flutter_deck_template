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
  static void Function(int)? _goToSlide;
  static int Function()? _slideCount;
  static int Function()? _currentSlide;

  /// Navigate to the next slide.
  static void next() => _goNext?.call();

  /// Navigate to the previous slide.
  static void previous() => _goPrevious?.call();

  /// Navigate to a specific slide by number (1-based).
  static void goToSlide(int slideNumber) => _goToSlide?.call(slideNumber);

  /// Returns the total number of slides.
  static int get slideCount => _slideCount?.call() ?? 0;

  /// Returns the current slide number (1-based).
  static int get currentSlide => _currentSlide?.call() ?? 0;

  /// Register navigation callbacks from FlutterDeck context.
  static void register(BuildContext context) {
    final flutterDeck = FlutterDeck.of(context);
    _goNext = () => flutterDeck.next();
    _goPrevious = () => flutterDeck.previous();
    _goToSlide = (n) => flutterDeck.goToSlide(n);
    _slideCount = () => flutterDeck.router.slides.length;
    _currentSlide = () => flutterDeck.slideNumber;
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
