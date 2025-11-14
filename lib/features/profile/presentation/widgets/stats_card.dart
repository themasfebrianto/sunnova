import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Stats'),
      ),
    );
  }
}
