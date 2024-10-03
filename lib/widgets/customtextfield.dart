import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Customtextfield extends StatelessWidget {
  final String? title;
  final Function(String)? onchanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? hinttext;
  final double? heigth;
  final double? width;
  final int? maxLines;
  const Customtextfield({super.key, this.title, this.onchanged, this.validator, this.controller, this.inputType, this.hinttext, this.heigth, this.width, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14,vertical: 14),
      height: heigth,
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
      child:TextFormField(
        onChanged: onchanged,
        controller: controller,
        maxLines: maxLines ?? 1,
        keyboardType: inputType,
        style: const TextStyle(
          color: Colors.black54,
        ),
        validator: validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 5.w, bottom: 16.h),
          hintText: hinttext,
          hintStyle: GoogleFonts.quicksand(color: Colors.grey, fontSize: 12.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4).r,
            borderSide: BorderSide(
              //color: Colors.transparent,
              width: 1.0.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4).r,
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1.0.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4).r,
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 2.0.w, // Slightly thicker border when focused
            ),
          ),
          filled: true, // Enables the background color
          fillColor:  Color(0xffF8F8F8),
        ),
      ),
    );
  }
}
