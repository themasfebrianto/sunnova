import 'package:flutter/material.dart';

class AchievementItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.shield),
      title: Text('Achievement'),
      subtitle: Text('Unlocked on...'),
    );
  }
}
