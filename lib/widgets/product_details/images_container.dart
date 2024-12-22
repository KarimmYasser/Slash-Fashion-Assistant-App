import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagesContainer extends StatefulWidget {
  final List<String> imageUrls;
  const ImagesContainer({super.key, required this.imageUrls});

  @override
  _ImagesContainerState createState() => _ImagesContainerState();
}

class _ImagesContainerState extends State<ImagesContainer> {
  late String mainImageUrl;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    mainImageUrl = widget.imageUrls.isNotEmpty ? widget.imageUrls[0] : '';
  }

  void _onThumbnailTap(int index) {
    setState(() {
      mainImageUrl = widget.imageUrls[index];
      selectedIndex = index;
    });
  }

  void _onViewAllTap() {
    // Navigate to a new screen where all photos are shown
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullGalleryPage(imageUrls: widget.imageUrls),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // Main Product Image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r)),
              child: Image.network(
                mainImageUrl,
                width: double.infinity,
                height: 350.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Background container for thumbnails
          Positioned(
            right: 14, // Adjust positioning as needed
            top: 100.h, // Adjust top offset as needed
            child: Container(
              height: 205.h,
              width: 47.w,
              decoration: BoxDecoration(
                color: OurColors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          // Thumbnail Images in a vertical column
          Positioned(
            right: 12, // Adjust positioning as needed
            top: 100.h, // Adjust top offset as needed
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < widget.imageUrls.length && i < 4; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        if (i < 3) {
                          _onThumbnailTap(i);
                        } else {
                          _onViewAllTap();
                        }
                      },
                      child: Container(
                        width: i == selectedIndex ? 50.w : 40.w,
                        height: i == selectedIndex ? 50.h : 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: OurColors.white.withOpacity(0.8),
                            width: 2,
                          ),
                          image: i < widget.imageUrls.length - 1
                              ? DecorationImage(
                                  image: NetworkImage(widget.imageUrls[i]),
                                  fit: BoxFit.cover,
                                  opacity: i >= widget.imageUrls.length - 2
                                      ? 0.6
                                      : 1)
                              : null,
                        ),
                        child: i >= widget.imageUrls.length - 2
                            ? Center(
                                child: Text(
                                  '+${widget.imageUrls.length - 3}',
                                  style: TextStyle(
                                    color: OurColors.textColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder for FullGalleryPage (to be implemented)
class FullGalleryPage extends StatelessWidget {
  final List<String> imageUrls;

  const FullGalleryPage({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gallery")),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) => Image.network(imageUrls[index]),
      ),
    );
  }
}
