import 'package:flutter/material.dart';

import '../../constants.dart';
import 'custom_curved_edges.dart';
import 'rounded_container.dart';

class CurvedEdgeWidget extends StatelessWidget {
  const CurvedEdgeWidget({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdges(),
      child: child ??
          const RoundedContainer(
            backgroundColor: OurColors.light,
            child: SizedBox(),
          ),
    );
  }
}
