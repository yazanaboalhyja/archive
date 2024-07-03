import 'package:flutter/material.dart';

import '../../../core/utils/color_constants.dart';
import '../../../core/utils/global_constants.dart';


class DashboardContainer extends StatelessWidget {
  final Color color;
  final String title;
  final String mainData;
  final String? topIcon;
  final IconData? icon;
  final Color topIconColor;
  final bool willContainRow;
  const DashboardContainer({
    Key? key,
    required this.color,
    required this.title,
    required this.mainData,
    required this.topIcon,
    this.icon,
    required this.topIconColor,
    this.willContainRow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //height: 400,
        // width: 250,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(heightValue30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: topIconColor,
                    ),
                    child: Center(
                      child:topIcon!=null? Image.asset(
                        topIcon!,
                        height: 20,
                        color: secondaryAppColor,
                      ):
                          title =="Total Videos"?

                          Icon(Icons.movie ,color: Colors.black,):
                     Icon(icon ,color: Colors.black,)
                      ,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: secondaryAppColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: topIconColor),
                    child: Center(
                      child:topIcon!=null? Image.asset(
                        topIcon!
                        ,
                        height: 20,
                        color: secondaryAppColor,
                      ):
                      title =="Total Videos"?

                      Icon(Icons.movie ,color: Colors.black,):
                      Icon(icon ,color: Colors.black,)
                    ),
                  ),
                ],
              ),
              willContainRow
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "₦ ",
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w800,
                            color: secondaryAppColor,
                          ),
                        ),
                        Text(
                          amountFormatter.format(int.parse(mainData)),
                          style: const TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w800,
                            color: secondaryAppColor,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      amountFormatter.format(int.parse(mainData)),
                      style: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w800,
                        color: secondaryAppColor,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
