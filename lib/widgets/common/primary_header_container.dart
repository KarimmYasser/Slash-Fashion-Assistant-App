import 'package:flutter/material.dart';

import '../../constants.dart';
import 'curved_edge.dart';
import 'rounded_container.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        color: OurColors.primaryColor,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -100,
              right: -125,
              child: RoundedContainer(
                backgroundColor: OurColors.white.withOpacity(0.1),
                radius: 200,
              ),
            ),
            Positioned(
              top: 50,
              right: -150,
              child: RoundedContainer(
                backgroundColor: OurColors.white.withOpacity(0.1),
                radius: 200,
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
