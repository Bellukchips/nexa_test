import 'package:flutter/material.dart';

import 'package:nexa_test/models/tab_bar_schedule/model_tab_bar_schedule.dart';

class ItemTabBarSchedule extends StatefulWidget {
  final Function onTap;
  final ModelTabBarSchedule model;
  final double fontSize;
  final bool isSelected;
  const ItemTabBarSchedule({
    super.key,
    this.isSelected = false,
    required this.onTap,
    required this.model,
    required this.fontSize,
  });

  @override
  State<ItemTabBarSchedule> createState() => _ItemTabBarScheduleState();
}

class _ItemTabBarScheduleState extends State<ItemTabBarSchedule> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
        height: 50,
        width: 180,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            color: widget.isSelected
                ? const Color(0xff63B4FF).withOpacity(0.1)
                : const Color(0xffFAFAFA),
            borderRadius: BorderRadius.circular(100)),
        child: Text(
          widget.model.title,
          style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: widget.fontSize),
        ),
      ),
    );
  }
}
