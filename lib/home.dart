import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasenew/login/loginew.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/usermodel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cloudstore = FirebaseFirestore.instance;



  Future<List<UserModel>>alluser()async{
    final snapshot=await cloudstore.collection("users").get();
    final userData=snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Color(0xff364AFF),
        centerTitle: true,
        title: Text("All Users",style: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.white)),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: ()async{
                  await FirebaseAuth.instance.signOut();
                  // Handle post-sign-out actions here, like navigating to a login screen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginNew()),
                  );
                // await FirebaseAuth.instance.signOut();
                //  FirebaseAuth.instance.currentUser;
              },
                child: Icon(Icons.logout,size: 30,color: Colors.white,)),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        //stream:cloudstore.collection('Users').where('uid', isEqualTo: uid).snapshots(),
       stream: cloudstore.collection('Users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users found'));
          }
          return Padding(
            padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    height: 100,
                    width: 400,
                    child: ListTile(
                      leading: Container(height: 50,
                      width: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      title: Text("Name:  ${documentSnapshot['name']}",style: GoogleFonts.poppins(textStyle:TextStyle(
                          fontWeight: FontWeight.w600,fontSize: 14)),),
                      subtitle:  Text("Email:${documentSnapshot['email']}",
                          style: GoogleFonts.poppins(textStyle:TextStyle(
                              fontWeight: FontWeight.w400,fontSize: 12))
                      ),

                     trailing: Text("Number: ${documentSnapshot['phoneno']}"),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
