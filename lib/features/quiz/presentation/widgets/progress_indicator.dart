import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final int current;
  final int total;

  const CustomProgressIndicator({
    Key? key,
    required this.current,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: current / total,
    );
  }
}
