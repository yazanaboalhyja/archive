import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:palestine_archive/auth/provider.dart';
import 'package:provider/provider.dart';




class ProfileMenuWidget extends StatefulWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor  = const Color(0xFF00416b),
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor ;

  @override
  State<ProfileMenuWidget> createState() => _ProfileMenuWidgetState();
}

class _ProfileMenuWidgetState extends State<ProfileMenuWidget> {
  late   final _controller;

  bool _themeDark = false;
  late bool _initialValue = false;

  @override
  void initState() {
    super.initState();
     _controller = ValueNotifier<bool>(Provider.of<AppProvider>(context , listen: false).darkTheme);

     _initialValue = Provider.of<AppProvider>(context , listen: false).darkTheme;
    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          _themeDark = true;
          Provider.of<AppProvider>(context , listen: false).switchthemedark();
        } else {
          _themeDark = false;
          Provider.of<AppProvider>(context , listen: false).switchthemelight();

        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {


    return ListTile(
      onTap: widget.onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Icon(widget.icon, color: Colors.grey),
      ),
      title: Text(widget.title, style: Theme.of(context).textTheme.bodyText1?.apply(color: widget.textColor)),
      trailing: widget.endIcon || widget.title== "log_out".tr() || widget.title== 'Exit Visitor View' ? Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: const Icon(LineAwesomeIcons.angle_right, size: 18.0, color: Colors.grey)) :
      AdvancedSwitch(
        controller: _controller,
        activeColor: Colors.grey,
        inactiveColor: Colors.grey,
        activeImage: const NetworkImage('https://i.pinimg.com/564x/1c/22/43/1c22433b8d3aec799fd8187ca3030193.jpg'),
        inactiveImage: const NetworkImage('https://www.iconexperience.com/_img/v_collection_png/256x256/shadow/sun.png'),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        width: 70.0,
        height: 33.0,
        initialValue: _initialValue,
        onChanged: (value) {
          setState(() {
            _initialValue = !_initialValue;
          });
        },
        disabledOpacity: 0.5,
      )
    );
  }
}