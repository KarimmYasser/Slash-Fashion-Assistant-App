import 'package:flutter/material.dart';

class PhotosSelectionPage extends StatefulWidget {
  final List<String> allPhotos; // List of photo URLs or paths
  final List<String> selectedPhotos; // Initially selected photos
  const PhotosSelectionPage(
      {super.key, required this.allPhotos, required this.selectedPhotos});

  @override
  State<PhotosSelectionPage> createState() => _PhotosSelectionPageState();
}

class _PhotosSelectionPageState extends State<PhotosSelectionPage> {
  late List<String> selectedPhotos;

  @override
  void initState() {
    super.initState();
    selectedPhotos = List<String>.from(widget.selectedPhotos);
  }

  void toggleSelection(String photo) {
    setState(() {
      if (selectedPhotos.contains(photo)) {
        selectedPhotos.remove(photo);
      } else {
        selectedPhotos.add(photo);
      }
    });
  }

  void navigateToConfirmation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationPage(
          selectedPhotos: selectedPhotos,
          onSubmit: () {
            // Once confirmed, disable navigation back to this page
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Photos"),
      ),
      body: ListView.builder(
        itemCount: (widget.allPhotos.length / 2).ceil(),
        itemBuilder: (context, index) {
          final start = index * 2;
          final end = start + 2 > widget.allPhotos.length
              ? widget.allPhotos.length
              : start + 2;
          final photos = widget.allPhotos.sublist(start, end);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: photos.map((photo) {
              final isSelected = selectedPhotos.contains(photo);
              return GestureDetector(
                onTap: () => toggleSelection(photo),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.network(
                      photo,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    if (isSelected)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24,
                      ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToConfirmation,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  final List<String> selectedPhotos;
  final VoidCallback onSubmit;

  const ConfirmationPage({
    Key? key,
    required this.selectedPhotos,
    required this.onSubmit,
  }) : super(key: key);

  void sendToBackend() {
    // Simulate sending data to the backend
    print("Sending to backend: $selectedPhotos");
    onSubmit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Selection"),
      ),
      body: ListView.builder(
        itemCount: selectedPhotos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              selectedPhotos[index],
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendToBackend,
        child: const Icon(Icons.check),
      ),
    );
  }
}
