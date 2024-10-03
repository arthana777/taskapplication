import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskFilterBottomSheet extends StatefulWidget {
  final String selectedPriority;
  final Function(String) onPrioritySelected;

  TaskFilterBottomSheet({required this.selectedPriority, required this.onPrioritySelected});

  @override
  _TaskFilterBottomSheetState createState() => _TaskFilterBottomSheetState();
}

class _TaskFilterBottomSheetState extends State<TaskFilterBottomSheet> {
  String? _selectedPriority;

  @override
  void initState() {
    super.initState();
    _selectedPriority = widget.selectedPriority; // Initialize with the current selected priority
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.h,

      child: Column(
       // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
      Container(
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(28.r), topRight: Radius.circular(28.r)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Task Filter", style: GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                              IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, size: 20.sp, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
         // Text('Task Filter', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // ListTile(
          //   title: const Text('All'),
          //   leading: Radio<String>(
          //     value: 'all',
          //     groupValue: _selectedPriority,
          //     onChanged: (String? value) {
          //       setState(() {
          //         _selectedPriority = value;
          //       });
          //     },
          //   ),
          // ),

          SizedBox(height: 20.h,),
          ListTile(
            title: const Text('Low'),
            trailing: Radio<String>(
              value: 'Low',
              groupValue: _selectedPriority,
              onChanged: (String? value) {
                setState(() {
                  _selectedPriority = value;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: const Text('Medium'),
            trailing: Radio<String>(
              value: 'Medium',
              groupValue: _selectedPriority,
              onChanged: (String? value) {
                setState(() {
                  _selectedPriority = value;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: const Text('High'),
            trailing: Radio<String>(
              value: 'High',
              groupValue: _selectedPriority,
              onChanged: (String? value) {
                setState(() {

                  _selectedPriority = value;
                });
              },
            ),
          ),
          TextButton(onPressed: (){
            widget.onPrioritySelected(_selectedPriority!);
          }, child: Text('Apply Filter',style: GoogleFonts.poppins(color: Colors.red),)),

        ],
      ),
    );
  }
}
