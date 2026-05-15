import 'package:flutter/material.dart';
import 'package:fork_up/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double? vertical;
  final double? horizontal;
  final VoidCallback? onPressed;
  const CustomButton({super.key, required this.text, this.vertical, this.horizontal, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.symmetric(
          vertical:vertical?? 15,
          horizontal:horizontal?? 145,
        ),
      ),
      onPressed: onPressed,
      label: Text(text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
