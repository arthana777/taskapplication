import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../widgets/customtextfield.dart';
import '../widgets/datetextfilecard.dart';
import '../widgets/tasknamecard.dart';
import '../widgets/timetextfield.dart';

class TaskcreationScreen extends StatefulWidget {
  const TaskcreationScreen({super.key});

  @override
  State<TaskcreationScreen> createState() => _TaskcreationScreenState();
}

class _TaskcreationScreenState extends State<TaskcreationScreen> {
  String totalTaskCountString = "0";
  DateTime? _startDate;
  DateTime? _endDate;
  String selectedPriority = 'High';
  final List<String> priorities = ['Low', 'Medium', 'High'];
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('your_collection');
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void createTask() async {
    if (_taskNameController.text.isEmpty || _descriptionController.text.isEmpty|| selectedPriority == null ||
    _startDate == null ||       // Check if start date is selected
    _endDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      // Format dates to 'dd MMM yyyy'
      String? formattedStartDate = _startDate != null
          ? DateFormat('dd MMM yyyy').format(_startDate!)
          : null;
      String? formattedEndDate = _endDate != null
          ? DateFormat('dd MMM yyyy').format(_endDate!)
          : null;

      await _collectionRef.add({
        'task_name': _taskNameController.text,
        'description': _descriptionController.text,
        'priority': selectedPriority,
        'start_date': formattedStartDate,  // Save formatted start date
        'end_date': formattedEndDate,
        // Save formatted end date
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Task created successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );

      _taskNameController.clear();
      _descriptionController.clear();
      _priorityController.clear();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Error creating task: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
    fetchTaskCounts();
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void fetchTaskCounts() async {
    QuerySnapshot totalTasksSnapshot = await FirebaseFirestore.instance.collection('your_collection').get();
    int totalTaskCount = totalTasksSnapshot.size;


    setState(() {
      totalTaskCountString = totalTaskCount.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Color(0xffF6F6F6),
        titleSpacing: 0.5,
        title: Container(
          height: 40.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffF6F6F6),
          ),
          child: Row(
            children: [
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),
              Text("Create new task",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 16.sp),),
            ],
          ),
        ),
      ),
      body:Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h,),
                Text("Task name",style: GoogleFonts.poppins(fontSize: 12.sp,fontWeight: FontWeight.w400),),
                Customtextfield(hinttext: "Enter task name",heigth: 42.h, controller: _taskNameController, validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task';
                  }
                  return null;
                },),
                SizedBox(height: 20.h,),
                Text("Description",style: GoogleFonts.poppins(fontSize: 12.sp,fontWeight: FontWeight.w400,),),
                Customtextfield(hinttext: "Enter description",heigth: 200.h, controller: _descriptionController,maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },),
                SizedBox(height: 20.h,),
                Text("Your Task",style: GoogleFonts.poppins(fontSize: 12.sp,fontWeight: FontWeight.w400),),
                SizedBox(
                  height: 60.h,
                  width: 500.w,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 3,
                      itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              selectedPriority = priorities[index];  // Update selected priority
                            });
                          },
                          child: Container(
                            height: 50.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: selectedPriority == priorities[index] ? Colors.red : Colors.white,
                              border: Border.all(color: selectedPriority == priorities[index] ? Colors.red : Colors.black26),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(child: Text(priorities[index],style: GoogleFonts.poppins( color: selectedPriority == priorities[index] ? Colors.white : Color(0xff9A9A9A),)),
                          ),
                        ),
                        )
                      );
                      }),
                ),

                SizedBox(height: 20.h,),
                Text("Date",style: GoogleFonts.poppins(fontSize: 12.sp,fontWeight: FontWeight.w400),),

                Row(
                  children: [
                    DatetextfileCard(title: "*From", onDateSelected: (DateTime? value) {
                      setState(() {
                        _startDate = value;
                      });
                    },) ,
            SizedBox(width: 10.w,),
                    DatetextfileCard(title: "*To", onDateSelected: (DateTime? value) {
                      setState(() {
                        _endDate = value;
                      });
                    },) ,
                    SizedBox(width: 16.w,),
                    Container(
                      height: 45.h,
                      width: 45.h,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(30.r))
                      ),
                      child: Icon(Icons.calendar_today_sharp,color: Colors.white,size: 20.sp,),
                    ),



                  ],
                ),
                SizedBox(height: 20.h,),
                Row(
                  children: [
                    Timetextfield(),
                    SizedBox(width: 10.w,),
                    Timetextfield(),
                  ],
                ),
            SizedBox(height: 5.h,),
            Text("Create all mandatory fields above"),
                SizedBox(height: 60.h,),
                InkWell(
                  onTap: (){
                    createTask();
                  },
                  child: Container(
                    height: 40.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    child: Center(child: Text("Create new task",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 16.sp,color: Colors.white),)),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
