import 'package:flutter/material.dart';

class ContentViewer extends StatelessWidget {
  final String content;

  const ContentViewer({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Text(content));
  }
}
