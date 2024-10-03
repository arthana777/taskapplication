import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasenew/screens/taskdetail_screen.dart';
import 'package:firebasenew/screens/taskfilterclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/customappbar.dart';
import '../widgets/taskcard.dart';
import '../widgets/taskcountcard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedPriority = "all";
  String totalTaskCountString = "0";
  String completedTaskCountString = "0";
  void fetchTaskCounts() async {
    QuerySnapshot totalTasksSnapshot =
        await FirebaseFirestore.instance.collection('your_collection').get();
    int totalTaskCount = totalTasksSnapshot.size;

    setState(() {
      totalTaskCountString = totalTaskCount.toString();
    });
  }

  void _showTaskFilter(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return TaskFilterBottomSheet(
          selectedPriority: selectedPriority,
          onPrioritySelected: (String priority) {
            setState(() {
              selectedPriority = priority;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTaskCounts();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _getTaskStream(String priority) {
    if (priority == "all") {
      return FirebaseFirestore.instance
          .collection('your_collection')
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('your_collection')
          .where('priority', isEqualTo: priority)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h), child: const CustomAppbar()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TaskcountCard(title: "Total Task", count: totalTaskCountString),
              SizedBox(
                width: 5.w,
              ),
              TaskcountCard(
                title: "Completed Task",
                count: completedTaskCountString,
              )
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "Your Task",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 16.sp),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 35.h,
                width: 330.w,
                padding: EdgeInsets.only(left: 20.w, top: 8.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    color: Colors.red),
                child: Text(
                  "Filter Task",
                  style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      _showTaskFilter(context);
                    },
                    child: Icon(
                      Icons.filter_center_focus,
                      size: 22.sp,
                      color: Colors.red,
                    )),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _getTaskStream(selectedPriority),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              var tasks = snapshot.data!.docs;

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  var task = tasks[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskdetailScreen(
                                    taskName:
                                        task['task_name'],
                                    description: task[
                                        'description'],
                                    priority:
                                        task['priority'],
                                    startDate:
                                        task.data().containsKey('start_date') ==
                                                true
                                            ? task['start_date']
                                            : 'No start date',
                                    endDate:
                                        task.data().containsKey('end_date') ==
                                                true
                                            ? task['end_date']
                                            : 'No end date',
                                  )));
                    },
                    child: TaskCard(
                      priority: task['priority'],
                      taskName: task['task_name'],
                      description: task['description'],
                      startDate: task.data().containsKey('start_date')
                          ? task['start_date']
                          : 'No start date',
                      endDate: task.data().containsKey('end_date')
                          ? task['end_date']
                          : 'No end date',
                      documentId: task.id,
                    ),
                  );
                },
              );
            },
          )
        ])),
      ),
    );
  }
}
