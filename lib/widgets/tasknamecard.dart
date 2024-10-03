import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tasknamecard extends StatelessWidget {
  final String? title;
  const Tasknamecard({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 14,vertical: 14),
      height: 40.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color:  Color(0xffF8F8F8),
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(title??""),
    );
  }
}
