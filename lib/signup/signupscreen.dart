


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebasenew/customtextfield.dart';
import 'package:firebasenew/home.dart';
import 'package:firebasenew/model/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
   SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final cloudstore=FirebaseFirestore.instance;
  FirebaseDatabase db = FirebaseDatabase.instance;
  TextEditingController emailcontroller=TextEditingController();

  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController namecontroller=TextEditingController();

  TextEditingController phonenumbercontroller=TextEditingController();

  Future<UserModel?>getUserDetails(String email)async{
    final snapshot=await cloudstore.collection("users").where("email",isEqualTo: email).get();
    final userData=snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }
  Future<List<UserModel>>alluser()async{
    final snapshot=await cloudstore.collection("users").get();
    final userData=snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }



createUser(UserModel user)async{
 await cloudstore.collection("Users").
 doc(_auth.currentUser!.uid).set({
   'name': user.name,
   'email':user.email,
   'phoneno':user.phoneno,
   'password':user.password,
 });
 // set(user.toJson()).whenComplete(() => print("account has been created"));
}

  Future<void>sighnUp()async{

    try  {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );

      if (userCredential != null) {
        await createUser(UserModel(name: namecontroller.text,
          password: passwordcontroller.text,
          email: emailcontroller.text,
          phoneno: phonenumbercontroller.text,
        ));
        // _auth.currentUser.uid
        print("User Created Succesfully");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );

      }
      print("object is : $userCredential");

    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            texttype: TextInputType.name,
            controller: namecontroller,
            hint: 'name',
          ),
          CustomTextField(
            texttype: TextInputType.phone,
            controller: phonenumbercontroller,
            hint: 'number',
          ),
          CustomTextField(
            texttype: TextInputType.emailAddress,
            controller: emailcontroller,
            hint: 'email',
          ),
          SizedBox(height: 20),
          CustomTextField(
            controller: passwordcontroller,
            hint: 'password',
          ),

          SizedBox(height: 30,),
          ElevatedButton(
              onPressed: ()async{
                await sighnUp();



                // await FirebaseFirestore.instance
                //     .collection('data')
                //     .add({'text': 'data added through app'});
              },
              child: Text("Signup"))
        ],
      ),
    );
  }
}
