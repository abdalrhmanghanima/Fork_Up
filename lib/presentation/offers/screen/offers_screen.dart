import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/presentation/offers/widget/offers_widget.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.04),
          child: GestureDetector(
            child: SvgPicture.asset(AppIcons.back),
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: const Text("Offers"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: OffersWidget(
              margin: EdgeInsets.only(bottom: 12),
              scrollDirection: Axis.vertical,
            ),
          ),
        ],
      ),
    );
  }
}
