import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.info),
      title: const Text('Info'),
      onTap: () {
        context.go('/temp');
      },
    );
  }
}
