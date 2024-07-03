import 'package:flutter/material.dart';

import '../../../core/utils/color_constants.dart';
import '../../../core/utils/global_constants.dart';


class ActivityDetailsContainer extends StatelessWidget {
  final String label;
  final String content;
  final Color amountColor;
  final bool isRow;
  final bool isAmount;
  const ActivityDetailsContainer({
    Key? key,
    required this.label,
    required this.content,
    this.amountColor = primaryAppColor,
    this.isRow = false,
    this.isAmount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: screenWidth,

        //height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(heightValue10),
          color: greyScale850,
        ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20,),
                isRow
                    ? Row(
                        children: [
                          Image.asset(
                            "assets/images/dialog_success_image.png",
                            height: 25,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            content,
                            style: const TextStyle(
                              fontSize: 24,
                              color: primaryAppColor,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        content,
                        style: TextStyle(
                          fontSize: 24,
                          color: primaryAppColor,
                          fontWeight:
                              isAmount ? FontWeight.bold : FontWeight.normal,
                        ),
                      )
              ],
            ),
          ),
        ),
    );
  }
}
