import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskdetailScreen extends StatelessWidget {
  final String taskName;
  final String description;
  final String priority;
  final String startDate;
  final String endDate;
  const TaskdetailScreen(
      {super.key,
      required this.taskName,
      required this.description,
      required this.priority,
      required this.startDate,
      required this.endDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: const Color(0xffF6F6F6),
        titleSpacing: 0.5,
        title: Container(
          height: 40.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffF6F6F6),
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              Text(
                taskName,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Task name and details",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, fontSize: 12.sp),
            ),
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffF8F8F8),
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  description,
                  style: GoogleFonts.poppins(
                      color: const Color(0xff858585), fontSize: 10.sp),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffF8F8F8),
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(priority),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffF8F8F8),
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Text("Start date:"),
                  Text(startDate),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffF8F8F8),
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Text("End date:"),
                  Text(endDate),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
