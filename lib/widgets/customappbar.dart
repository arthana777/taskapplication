import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        toolbarHeight: 140.h,
        title: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.h),
          child: Column(
            children: [
              Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 50.h,
                      minWidth: 50.h,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.r)),
                        image: DecorationImage(
                          image: AssetImage("assets/Ellipse 1.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 8.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello",style: GoogleFonts.poppins(fontSize: 12.sp,fontWeight: FontWeight.w400),),
                      Text("Aswin",style: GoogleFonts.poppins(fontSize: 16.sp,fontWeight: FontWeight.w600),),
                    ],
                  ),
                  SizedBox(width: 200.w,),
                  Container(
                      height: 25.h,
                      width: 25.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.r)),
                        border: Border.all(color: Colors.black26),
                      ),
                      child: Icon(Icons.menu,color: Colors.black54,)),
                  // IconButton(
                  //     onPressed: (){},
                  //     icon: Icon(Icons.money_outlined,size: 30.sp,))
                ],
              ),

              SizedBox(height: 10.h,),
              InkWell(
                onTap: (){

                },
                child: Container(
                  height: 40.h,
                  width: 400.w,
                  decoration: BoxDecoration(
                      color: Color(0xffF6F6F6
                      )),
                  child: Row(
                    children: [
                      SizedBox(width: 10.w,),
                      Icon(Icons.search_rounded),
                      SizedBox(width: 10.w,),
                      Text("find your task here..",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 12.sp,
                          color: Color(0xffDADADA
                          )),)
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
