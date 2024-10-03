import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
         this.label,
         this.hint,
        this.customicon,
        this.reusableicon,
        this.controller,  this.function});
  final hint;
  final label;
  final customicon;
  final reusableicon;
  final TextEditingController? controller;
  final Function(String)? function ;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Color(0xffDFDFDF),

          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                //spreadRadius: 2,
                blurRadius: 2)
          ]),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null;
        },

        onChanged: widget.function,

        focusNode: FocusNode(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          //disabledBorder: InputBorder.none,
         // suffixIcon: widget.reusableicon,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),

          ),
          hintText: widget.hint,
          // hintStyle: TextStyle(fontWeight: FontWeight.w100,color: Colors.grey),
          hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(color: Colors.black54, fontSize: 15)),
          labelText: widget.label,
          labelStyle: GoogleFonts.poppins(
              textStyle: TextStyle(color: Colors.black, fontSize: 15)),
        ),
        controller: widget.controller ,
      ),
    );
  }
}
