import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Timetextfield extends StatefulWidget {
  const Timetextfield({super.key});

  @override
  State<Timetextfield> createState() => _TimetextfieldState();
}

class _TimetextfieldState extends State<Timetextfield> {
  TimeOfDay _timeOfDay = TimeOfDay.now();

  String formatedTime='';
  void _showTimepicker(){
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()).then((value) =>
        setState(() {
          _timeOfDay=value!;
          formatedTime=TimeOfDay.now().format(context);
          //formatedTime=TimeOfDay(hour: 8, minute: 30).format(context);
        }),
    );

  }
  DateTime _convertToDateTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }


  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: _showTimepicker,
      child: Container(
        height: 50.h,
        width: 170.w,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(_timeOfDay.format(context).toString()),
            SizedBox(
              width: 10.w,
            ),
            VerticalDivider(
              thickness: 2,
              color: Colors.black12,
            ),
            Icon(Icons.watch_later_outlined,size: 25.sp,color: Colors.black26,),
          ],
        ),

      ),
    );
  }
}
