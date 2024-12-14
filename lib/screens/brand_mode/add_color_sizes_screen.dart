import 'dart:io';
import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              child: Center(child: const Text("Save")),
            ),
          ],
        ),
      ),
    );
  }
}

class AddSizesScreen extends StatefulWidget {
  final Map<String, dynamic>? sizes;

  const AddSizesScreen({super.key, this.sizes});

  @override
  State<AddSizesScreen> createState() => _AddSizesScreenState();
}

class _AddSizesScreenState extends State<AddSizesScreen> {
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _chestController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _shoulderWidthController =
      TextEditingController();
  final TextEditingController _shapeController = TextEditingController();
  final TextEditingController _footLengthController = TextEditingController();

  File? _sizeImage;

  @override
  void initState() {
    super.initState();
    if (widget.sizes != null) {
      _waistController.text = widget.sizes?["waist"] ?? "";
      _heightController.text = widget.sizes?["height"] ?? "";
      _chestController.text = widget.sizes?["chest"] ?? "";
      _weightController.text = widget.sizes?["weight"] ?? "";
      _shoulderWidthController.text = widget.sizes?["shoulder_width"] ?? "";
      _shapeController.text = widget.sizes?["shape"] ?? "";
      _footLengthController.text = widget.sizes?["foot_length"] ?? "";
      _sizeImage = widget.sizes?["image"];
    }
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _sizeImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Sizes"),
        actions: [
          TextButton(
            onPressed: () {
              final sizes = {
                "waist": _waistController.text,
                "height": _heightController.text,
                "chest": _chestController.text,
                "weight": _weightController.text,
                "shoulder_width": _shoulderWidthController.text,
                "shape": _shapeController.text,
                "foot_length": _footLengthController.text,
                "image": _sizeImage,
              };
              Navigator.pop(context, sizes);
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _waistController,
                decoration: const InputDecoration(labelText: "Waist"),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: "Height"),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextField(
                controller: _chestController,
                decoration: const InputDecoration(labelText: "Chest"),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: "Weight"),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextField(
                controller: _shoulderWidthController,
                decoration: const InputDecoration(labelText: "Shoulder Width"),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextField(
                controller: _shapeController,
                decoration: const InputDecoration(labelText: "Shape"),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextField(
                controller: _footLengthController,
                decoration: const InputDecoration(labelText: "Foot Length"),
              ),
              SizedBox(
                height: 10.h,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _sizeImage != null
                      ? Image.file(_sizeImage!,
                          width: 80, height: 80, fit: BoxFit.cover)
                      : const Text("No image selected"),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: OurColors.containerBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _pickImage,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Upload Image",
                        style: TextStyle(color: OurColors.black),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              ElevatedButton(
                onPressed: () {
                  final sizes = {
                    "waist": _waistController.text,
                    "height": _heightController.text,
                    "chest": _chestController.text,
                    "weight": _weightController.text,
                    "shoulder_width": _shoulderWidthController.text,
                    "shape": _shapeController.text,
                    "foot_length": _footLengthController.text,
                    "image": _sizeImage,
                  };
                  Navigator.pop(context, sizes);
                },
                child: Center(child: const Text("Save")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
