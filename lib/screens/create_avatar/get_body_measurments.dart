import 'package:fashion_assistant/screens/total_screen.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyMeasurementsScreen extends StatefulWidget {
  const BodyMeasurementsScreen({super.key});

  @override
  _BodyMeasurementsScreenState createState() => _BodyMeasurementsScreenState();
}

class _BodyMeasurementsScreenState extends State<BodyMeasurementsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _chestController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _shoulderWidthController =
      TextEditingController();
  final TextEditingController _footLengthController = TextEditingController();
  final TextEditingController _shapeController = TextEditingController();

  bool _isLoading = false;

  Future<void> _saveMeasurements() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final body = {
      "waist": int.parse(_waistController.text),
      "height": int.parse(_heightController.text),
      "chest": int.parse(_chestController.text),
      "weight": int.parse(_weightController.text),
      "shoulder_width": int.parse(_shoulderWidthController.text),
      "shape": _shapeController.text.trim(),
      "foot_length": double.parse(_footLengthController.text),
    };

    try {
      final response = await HttpHelper.post(
        'api/user/body-measurements',
        body,
      );

      // On success, navigate to TotalScreens
      Get.offAll(() => const TotalScreens());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Body Measurements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _waistController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Waist (cm)'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null) {
                      return 'Please enter a valid waist measurement';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Height (cm)'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null) {
                      return 'Please enter a valid height';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _chestController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Chest (cm)'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null) {
                      return 'Please enter a valid chest measurement';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Weight (kg)'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null) {
                      return 'Please enter a valid weight';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _shoulderWidthController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Shoulder Width (cm)'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null) {
                      return 'Please enter a valid shoulder width';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _footLengthController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Foot Length (cm)'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null) {
                      return 'Please enter a valid foot length';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _shapeController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'Body Shape'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid body shape';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _saveMeasurements,
                        child: const Text('Save Measurements'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
