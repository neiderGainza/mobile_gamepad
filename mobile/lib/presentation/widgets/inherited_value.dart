import 'package:flutter/material.dart';

class InheritedValue<T> extends InheritedWidget{
  final T value;

  const InheritedValue({
    super.key,
    required this.value,
    required super.child
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static T of<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<InheritedValue<T>>();
    assert(provider != null, 'No se encontró un InheritedValue<$T> en el BuildContext');
    return provider!.value;
  }
}