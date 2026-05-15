import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fork_up/core/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.textInputType,
    required this.hintText,
    this.vertical,
    this.horizontal,
    required this.isPassword,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? textInputType;
  final String hintText;
  final double? vertical;
  final double? horizontal;
  final bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          validator: (value) {
            if(value==null||value.isEmpty){
              return "please fill ${widget.label}";
            }
            return null;
          },
          obscureText: _obscureText,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          cursorColor: Colors.black,
          cursorHeight: 28,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: AppColors.lightGray,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: widget.horizontal ?? 16,
              vertical: widget.vertical ?? 22,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightGray),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightGray, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () => _togglePassword(),
                    child: Icon(
                      _obscureText
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
