import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final double? radius;
  final double? shadowAlpha;
  const AppCard({
    super.key,
    required this.child,
    this.radius,
    this.shadowAlpha,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            color: Colors.black.withValues(alpha: (shadowAlpha ?? 0.03)),
          ),
        ],
        borderRadius: BorderRadius.circular((radius ?? 8).r),
      ),
      child: child,
    );
  }
}
