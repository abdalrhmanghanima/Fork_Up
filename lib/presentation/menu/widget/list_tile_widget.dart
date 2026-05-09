import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fork_up/core/utils/app_icons.dart';

class ListTileWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const ListTileWidget({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      trailing: SvgPicture.asset(AppIcons.arrowRight),
      onTap: onTap,
    );
  }
}
