import 'package:flutter/material.dart';
import 'package:vidstream/constants/colors.dart';

class InfoTile extends StatelessWidget {
  final String name;
  final String data;

  InfoTile({
    required this.name,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            color: CustomColors.muxGray,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          data,
          style: TextStyle(
            color: CustomColors.muxGray.withOpacity(0.6),
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}