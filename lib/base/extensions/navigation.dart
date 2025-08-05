import 'package:flutter/material.dart';

extension NavigationExtensions on BuildContext {
  /// ---------- PUSH ----------
  /// Push a widget (MaterialPageRoute)
  Future<T?> pushPage<T extends Object?>(Widget page) {
    return Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  /// Push and replace current page
  Future<T?> pushReplacementPage<T extends Object?, TO extends Object?>(
    Widget page,
  ) {
    return Navigator.of(
      this,
    ).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  /// Push a named route with optional arguments
  Future<T?> pushNamedRoute<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  /// Replace with named route
  Future<T?> pushReplacementNamedRoute<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(
      this,
    ).pushReplacementNamed<T, TO>(routeName, arguments: arguments);
  }

  /// Push and clear all previous routes (like going to Home after login)
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Widget page, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      predicate ?? (route) => false,
    );
  }

  /// Named version of pushAndRemoveUntil
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil<T>(
      routeName,
      arguments: arguments,
      predicate ?? (route) => false,
    );
  }

  /// ---------- POP ----------
  /// Simple pop
  void pop<T extends Object?>([T? result]) {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop(result);
    }
  }

  /// Pop until a certain condition
  void popUntil(bool Function(Route<dynamic>) predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  /// Pop to first route (clears everything above)
  void popToRoot() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }
}
