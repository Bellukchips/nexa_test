import 'package:flutter/material.dart';

class CustomElevationButton extends StatelessWidget {
  const CustomElevationButton({
    super.key,
    required this.height,
    this.color,
    this.style,
    this.text,
    this.onTap,
    this.width,
  });
  final double? height;
  final Color? color;
  final TextStyle? style;
  final String? text;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(height! / 2)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color!.withOpacity(0.2),
              blurRadius: height! / 5,
              offset: Offset(0, height! / 5),
            ),
          ],
        ),
        child: TextButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  color,
                ),
                shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))))),
            onPressed: onTap,
            child: Text(
              text!,
              style: style,
            )));
  }
}
