import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key, this.thickness});
  final double? thickness;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.sp),
      child: Divider(
        thickness: thickness,
        color: Colors.black,
      ),
    );
  }
}
