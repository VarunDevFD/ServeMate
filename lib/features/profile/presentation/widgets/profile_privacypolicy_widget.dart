import 'package:flutter/material.dart';

class ProfilePrivacypolicyWidget extends StatelessWidget {
  const ProfilePrivacypolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.privacy_tip),
      title: const Text('Privacy Policy'),
      onTap: () {
        // Handle Privacy Policy
      },
    );
  }
}
