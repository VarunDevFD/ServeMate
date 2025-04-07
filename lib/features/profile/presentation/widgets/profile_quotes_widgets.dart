import 'package:flutter/material.dart';

class ProfileQuotesWidgets extends StatelessWidget {
  final String? quote;
    ProfileQuotesWidgets({super.key, this.quote});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.format_quote),
      title:   Text(quote ??'Quotes'),
      onTap: () {
        
      },
    );
  }
}
