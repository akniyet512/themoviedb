import 'package:flutter/material.dart';

class NotifierProvider<Model extends ChangeNotifier> extends InheritedNotifier {
  final Model model;

  const NotifierProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
          notifier: model,
        );

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NotifierProvider<Model>>()
        ?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final Widget? widget = context
        .getElementForInheritedWidgetOfExactType<NotifierProvider<Model>>()
        ?.widget;
    return widget is NotifierProvider<Model> ? widget.model : null;
  }

  @override
  bool updateShouldNotify(covariant NotifierProvider oldWidget) {
    return true;
  }
}


class Provider<Model> extends InheritedWidget {
  final Model model;

  const Provider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
        );

  static Model? watch<Model>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider<Model>>()
        ?.model;
  }

  static Model? read<Model>(BuildContext context) {
    final Widget? widget = context
        .getElementForInheritedWidgetOfExactType<Provider<Model>>()
        ?.widget;
    return widget is Provider<Model> ? widget.model : null;
  }

  @override
  bool updateShouldNotify(covariant Provider oldWidget) {
    return model != oldWidget;
  }
}
