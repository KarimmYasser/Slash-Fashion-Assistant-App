import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddColorsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> colors;

  const AddColorsScreen({super.key, required this.colors});

  @override
  State<AddColorsScreen> createState() => _AddColorsScreenState();
}

class _AddColorsScreenState extends State<AddColorsScreen> {
  final TextEditingController _colorNameController = TextEditingController();
  final List<Map<String, dynamic>> _colors = [];

  @override
  void initState() {
    super.initState();
    _colors.addAll(widget.colors);
  }

  void _addColor() async {
    if (_colorNameController.text.isNotEmpty) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _colors.add({
            'name': _colorNameController.text,
            'image': File(pickedFile.path),
          });
          _colorNameController.clear();
        });
      }
    }
  }

  void _removeColor(int index) {
    setState(() {
      _colors.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Colors"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, _colors),
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _colorNameController,
              decoration: InputDecoration(
                labelText: "Color Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _colors.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: _colors[index]['image'] != null
                        ? Image.file(_colors[index]['image'],
                            width: 40, height: 40, fit: BoxFit.cover)
                        : null,
                    title: Text(_colors[index]['name']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeColor(index),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, _colors),
              child: const Center(child: Text("Save")),
            ),
          ],
        ),
      ),
    );
  }
}
