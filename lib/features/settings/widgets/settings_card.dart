import 'package:flutter/material.dart';

import '../../../core/utils/color_constants.dart';
import '../../../core/utils/global_constants.dart';



class SettingsCard extends StatelessWidget {
  final IconData icon;
  final String settingsOperation;
  final String settingsOperationDescription;
  final VoidCallback onPressed;
  const SettingsCard({
    Key? key,
    required this.icon,
    required this.settingsOperation,
    required this.settingsOperationDescription,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 80,
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: greyScale850,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: heightValue55,
                    width: heightValue55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: secondaryAppColor,
                    ),
                    child: Center(
                        child: Icon(
                      icon,
                      color: primaryAppColor,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            settingsOperation,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            settingsOperationDescription,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }
}
