import 'package:flutter/material.dart';

class RankItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('1'),
      ),
      title: Text('User Name'),
      trailing: Text('1000 XP'),
    );
  }
}
