import 'package:flutter/material.dart';

class BadgeGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return Card(
          child: Center(
            child: Text('Badge'),
          ),
        );
      },
    );
  }
}
