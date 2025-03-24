import 'package:flutter/material.dart';
import 'package:loadin_guide_scann/src/core/theme/app_pallete.dart';

Widget overlayBuilder(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 250,
      height: 250,
      // This container defines the scan area.
      child: Stack(
        children: [
          // Top-left corner (horizontal)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: AppPallete.blueInfo,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
              ),
            ),
          ),
          // Top-left corner (vertical)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 5,
              height: 45,
              decoration: BoxDecoration(
                color: AppPallete.blueInfo,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
              ),
            ),
          ),
          // Top-right corner (horizontal)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: AppPallete.blueInfo,
                borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
              ),
            ),
          ),
          // Top-right corner (vertical)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 5,
              height: 45,
              decoration: BoxDecoration(
                color: AppPallete.blueInfo,
                borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
              ),
            ),
          ),
          // Bottom-left corner (horizontal)
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: AppPallete.blueInfo,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
              ),
            ),
          ),
          // Bottom-left corner (vertical)
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 5,
              height: 45,
              decoration: BoxDecoration(
                color: AppPallete.blueInfo,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
              ),
            ),
          ),
          // Bottom-right corner (horizontal)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: AppPallete.blueInfo,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(8)),
              ),
            ),
          ),
          // Bottom-right corner (vertical)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 5,
              height: 45,
              decoration: BoxDecoration(
                color: AppPallete.blueInfo,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
