import 'package:flutter/material.dart';

class EditCategoryDialog extends StatefulWidget {
  final Map<String, dynamic> initialData;

  const EditCategoryDialog({Key? key, required this.initialData})
      : super(key: key);

  @override
  _EditCategoryDialogState createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  late TextEditingController nameController;
  late TextEditingController detailsController;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.initialData['name'] ?? '');
    detailsController = TextEditingController(
        text: (widget.initialData['details'] as List<dynamic>?)?.join(', ') ??
            '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Category Name'),
          ),
          TextField(
            controller: detailsController,
            decoration:
                const InputDecoration(labelText: 'Details (comma-separated)'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.pop(context), // Close dialog without changes
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final updatedData = {
              'name': nameController.text,
              'details': detailsController.text
                  .split(',')
                  .map((e) => e.trim())
                  .toList(),
            };
            Navigator.pop(context, updatedData); // Return updated data
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
