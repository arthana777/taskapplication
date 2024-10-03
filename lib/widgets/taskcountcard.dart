import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskcountCard extends StatefulWidget {
  final String? title;
  final String? count;

  TaskcountCard({this.title, this.count});

  @override
  _TaskcountCardState createState() => _TaskcountCardState();
}

class _TaskcountCardState extends State<TaskcountCard> {
  String totalTaskCountString = "0";
  String completedTaskCountString = "0";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 180.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        color: Colors.red,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title ?? "",
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              Text(widget.count ?? "",
                  style: GoogleFonts.poppins(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              Text("Tasks",
                  style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
