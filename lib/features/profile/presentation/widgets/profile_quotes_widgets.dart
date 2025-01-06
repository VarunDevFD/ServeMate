import 'package:flutter/material.dart';

class ProfileQuotesWidgets extends StatelessWidget {
  const ProfileQuotesWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.format_quote),
      title: const Text('Quotes'),
      onTap: () {
        
      },
    );
  }
}
