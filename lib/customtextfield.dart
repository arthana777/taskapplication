import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
        this.label,
        this.hint,
        this.customicon,
        this.reusableicon,
        this.controller,  this.function, this.errortext, this.validator, this.texttype});
  final hint;
  final label;
  final customicon;
  final reusableicon;
  final errortext;
  final texttype;
  final TextEditingController? controller;
  final Function(String)? function ;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                //spreadRadius: 2,
                blurRadius: 4)
          ]),
      child: TextFormField(
        validator:validator,
        onChanged: function,
        keyboardType: texttype,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          //disabledBorder: InputBorder.none,
          // suffixIcon: widget.reusableicon,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: hint,
          // hintStyle: TextStyle(fontWeight: FontWeight.w100,color: Colors.grey),
          hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(color: Colors.black, fontSize: 15)),
          labelText: label,
          labelStyle: GoogleFonts.poppins(
              textStyle: TextStyle(color: Colors.black, fontSize: 15)),
          errorText: errortext,
        ),
        controller: controller ,
      ),
    );
  }
}
