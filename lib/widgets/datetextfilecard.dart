import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatetextfileCard extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? title;
  final ValueChanged<DateTime?> onDateSelected;

  const DatetextfileCard({super.key, this.controller, this.inputType, this.title, required this.onDateSelected});

  @override
  State<DatetextfileCard> createState() => _DatetextfileCardState();
}

class _DatetextfileCardState extends State<DatetextfileCard> {

  DateTime _dateTime=DateTime.now();
  String? formattedDate;

  void _showDatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2026),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
          formattedDate = DateFormat('dd MMM yyyy').format(_dateTime);
        });
        if (widget.onDateSelected != null) {
          widget.onDateSelected(_dateTime);
        }
      }
    });
  }
  // void _showDatepicker(){
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2026),
  //   ).then((value) =>
  //       setState(() {
  //         //_dateTime=value!;
  //         _selectedDate = value;
  //         formattedDate = DateFormat('dd MMM \n yyyy').format(_dateTime);
  //         print("formattedDate${formattedDate}");
  //
  //       }),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: _showDatepicker,
          child: Container(
            height: 50.h,
            width: 140.w,
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
            child: Center(child: Text(formattedDate??'Select date')),

          ),
        ),
        Positioned(
          top: -3,
          child: Container(
            height: 20.h,
            width: 35.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            ),
            child: Text(
              widget.title ?? '',
              style: GoogleFonts.poppins(color: Colors.black26, fontSize: 10.sp),
            ),
          ),
        ),
      ],
    );
  }
}
