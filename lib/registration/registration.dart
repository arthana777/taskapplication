import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebasenew/login/loginew.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../customtextfield.dart';
import '../home.dart';
import '../model/usermodel.dart';

class Registration extends StatefulWidget {
   Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _auth = FirebaseAuth.instance;

  final cloudstore=FirebaseFirestore.instance;

  FirebaseDatabase db = FirebaseDatabase.instance;

  TextEditingController emailcontroller=TextEditingController();

  TextEditingController passwordcontroller=TextEditingController();

  TextEditingController namecontroller=TextEditingController();

  TextEditingController phonenumbercontroller=TextEditingController();

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0xff364AFF),
        leading: InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginNew()),
            );
          },
            child: Icon(Icons.arrow_back)),
      ),
      backgroundColor: Color(0xff364AFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/img.png"))
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Text("Sen Remote",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
              ),
            ),
            Container(
              height: 755,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight:Radius.circular(30),topLeft: Radius.circular(30))
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40,right: 20,left: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5,bottom: 10),
                        child: Text("Name",style: GoogleFonts.poppins(textStyle:TextStyle(fontWeight: FontWeight.w400,fontSize: 12)),),
                      ),
                      CustomTextField(
                        controller: namecontroller,
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5,bottom: 10),
                        child: Text("Email",style: GoogleFonts.poppins(textStyle:TextStyle(fontWeight: FontWeight.w400,fontSize: 12)),),
                      ),
                      CustomTextField(controller: emailcontroller,),
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5,bottom: 10),
                        child: Text("Phone Number",style: GoogleFonts.poppins(textStyle:TextStyle(fontWeight: FontWeight.w400,fontSize: 12)),),
                      ),
                      CustomTextField(
                        controller: phonenumbercontroller,
                        texttype: TextInputType.phone,
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5,bottom: 10),
                        child: Text("password",style: GoogleFonts.poppins(textStyle:TextStyle(fontWeight: FontWeight.w400,fontSize: 12)),),
                      ),
                      CustomTextField(controller: passwordcontroller,),
                      SizedBox(height: 80,),
                      InkWell(
                        onTap: ()async{
                          await sighnUp();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 150),
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Color(0xff364AFF),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(child: Text("SignUp",style: GoogleFonts.poppins(
                                textStyle:TextStyle(color: Colors.white)),)),
                          ),
                        ),
                      ),





                    ],
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
