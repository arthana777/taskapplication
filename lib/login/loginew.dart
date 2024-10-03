import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasenew/profile/customTextfield.dart';
import 'package:firebasenew/signup/signupscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home.dart';
import '../registration/registration.dart';
import '../screens/dashboard.dart';

class LoginNew extends StatefulWidget {
   LoginNew({super.key});

  @override
  State<LoginNew> createState() => _LoginNewState();
}

class _LoginNewState extends State<LoginNew> {
  final _auth = FirebaseAuth.instance;

  TextEditingController emailcontroller=TextEditingController();

  TextEditingController passwordcontroller=TextEditingController();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,

    );
    print("here is....$credential");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  Future<void>login()async{

    try  {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      print("object is : $userCredential");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );

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
      backgroundColor: Color(0xff364AFF),
      body: SingleChildScrollView(
        child: Column(
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
                        child: Text("E mail",style: GoogleFonts.poppins(textStyle:TextStyle(fontWeight: FontWeight.w400,fontSize: 12)),),
                      ),
                      CustomTextField(
                      controller: emailcontroller,
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
                          await login();
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
                            child: Center(child: Text("Login",style: GoogleFonts.poppins(
                                textStyle:TextStyle(color: Colors.white)),)),
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      //spreadRadius: 2,
                                      blurRadius: 2)
                                ],
        
                                borderRadius: BorderRadius.circular(20),
        
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
        
                                      image: DecorationImage(image: AssetImage("assets/fb.png"),fit: BoxFit.cover)
                                  ),
                                ),
                                Text("facebook",style: GoogleFonts.poppins(
                                    textStyle:TextStyle(color: Colors.black)),),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: ()async{
                              await signInWithGoogle();
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Color(0xffFFFFFF),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      //spreadRadius: 2,
                                      blurRadius: 2)
                                ],

                                borderRadius: BorderRadius.circular(20),

                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage("assets/google.png"),fit: BoxFit.cover)
                                    ),
                                  ),

                                  Text("google",style: GoogleFonts.poppins(
                                      textStyle:TextStyle(color: Colors.black)),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 80,),
        
                      Center(child: Text("Dont have an accaount?",style: GoogleFonts.poppins(textStyle:TextStyle(fontWeight: FontWeight.w400,
                          fontSize: 14)),)),
                      SizedBox(height: 5,),
                      Center(child: InkWell(
                        onTap: (){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Registration()),
                          );

                        },
                          child: Text("SignUp",style: GoogleFonts.poppins(textStyle:TextStyle(color: Color(0xff364AFF),fontSize: 16,fontWeight: FontWeight.w600)),))),
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
