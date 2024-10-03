import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCard extends StatelessWidget {
  final String priority;
  final String documentId;
  final String taskName;
  final String description;
  final String startDate;
  final String endDate;
  const TaskCard({super.key, required this.priority, required this.taskName, required this.description, required this.startDate, required this.endDate, required this.documentId});


  Future<void> updateDocument(String documentId, Map<String, dynamic> newData) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to the document
    DocumentReference docRef = firestore.collection('tasks').doc(documentId);

    // Update the document with new data
    try {
      await docRef.update(newData);
      print('Document updated successfully');
    } catch (e) {
      print('Error updating document: $e');
    }
  }


  // Future<void> deleteDocument(String collectionPath, String documentId) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   DocumentReference documentRef = firestore.collection(collectionPath).doc(documentId);
  //
  //   try {
  //     await documentRef.delete();
  //     print('Document deleted successfully');
  //   } catch (e) {
  //     print('Error deleting document: $e');
  //   }
  // }
  void onDeleteDocument(String documentId) {
    String collectionPath = 'your_collection'; // Replace with your collection name

    // Call the deleteDocument function with the specified collection and document ID
    deleteDocument(collectionPath, documentId);
  }

  Future<void> deleteDocument(String collectionPath, String documentId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collection = firestore.collection(collectionPath);

      // Delete the specified document
      await collection.doc(documentId).delete();

      print('Document with ID: $documentId deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 170.h,
        width: 400.w,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
        ),
        child: Padding(
          padding:  EdgeInsets.all(20.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 22.h,
                    width: 80.w,
                    decoration:BoxDecoration(
                      color: priority == 'High' ? Colors.red : (priority == 'Medium' ? Colors.orange : Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                    ),
                    child: Center(child: Text(priority,style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 12.sp,color: Colors.white),)),
                  ),
                  SizedBox(height: 8.h,),
                  Text(taskName,style: GoogleFonts.poppins(fontSize: 16.sp,fontWeight: FontWeight.w500),),
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 10.sp),
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_sharp),
                      Text(startDate),
                      SizedBox(width: 30.w,),
                      Icon(Icons.flag_outlined),
                      Text(endDate)
                    ],
                  )
                ],
              ),
SizedBox(width: 5.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      height: 25.h,
                      width: 25.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.r)),
                        border: Border.all(color: Colors.black26),
                      ),
                      child: Icon(Icons.more_horiz)),
                  SizedBox(height: 8.h,),
                  Container(
                    height: 60.h,
                    width: 65.w,
                    decoration: BoxDecoration(
                        color: Color(0xffF5F5F5),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),bottomLeft: Radius.circular(10.r,),bottomRight: Radius.circular(10.r))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap:(){
                                updateDocument('documentID', {
                                  'task_name': 'Updated Task Name',
                                  'priority': 'High',
                                });

                              },
                      child: Text("Edit",style: GoogleFonts.poppins(color: Color(0xffCCCCCC),fontSize: 12.sp),)),
                          Divider(),
                          InkWell(
                            onTap: (){
                              onDeleteDocument(documentId);
                            },
                              child: Text("Delete",style: GoogleFonts.poppins(color: Color(0xffCCCCCC),fontSize: 12.sp),)),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
