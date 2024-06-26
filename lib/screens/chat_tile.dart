import 'package:ecommerce_app/screens/message.dart';

import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final VoidCallback onTap;
  final UserProfile user;

  const ChatTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: false,
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.photoURL ?? ''),
      ),
      title: Text(user.displayName ?? ''),
    );
  }
}
