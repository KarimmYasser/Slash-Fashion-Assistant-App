import 'package:fashion_assistant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Description extends StatefulWidget {
  const Description({super.key, required this.description});
  final String description;
  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: OurColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18.h, left: 16.w),
            child: const Text(
              'Description',
              style: TextStyle(
                  fontSize: Sizes.fontSizeLg,
                  color: OurColors.textColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // TextPainter to measure text layout and handle truncation
                final textPainter = TextPainter(
                  text: TextSpan(
                    text: widget.description,
                    style: const TextStyle(
                      fontSize: Sizes.fontSizeMd,
                      color: OurColors.textColor,
                    ),
                  ),
                  maxLines: 2,
                  textDirection: TextDirection.ltr,
                );
                textPainter.layout(maxWidth: constraints.maxWidth);

                // Determine if the text exceeds 2 lines
                final isTextOverflowing =
                    textPainter.didExceedMaxLines && !isExpanded;

                return Text.rich(
                  TextSpan(
                    text: isExpanded
                        ? widget.description
                        : isTextOverflowing
                            ? "${widget.description.substring(0, textPainter.getPositionForOffset(Offset(constraints.maxWidth, 0)).offset)}..."
                            : widget.description,
                    style: const TextStyle(
                      fontSize: Sizes.fontSizeMd,
                      color: OurColors.textColor,
                    ),
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Text(
                            isExpanded ? ' Show less' : ' Show more',
                            style: const TextStyle(
                                fontSize: Sizes.fontSizeMd,
                                color: OurColors.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  maxLines: isExpanded ? null : 2,
                  overflow:
                      isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                );
              },
            ),
          ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }
}
