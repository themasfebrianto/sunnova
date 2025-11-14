import 'package:flutter/material.dart';

class ContentViewer extends StatelessWidget {
  final String content;

  const ContentViewer({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Text(content));
  }
}
