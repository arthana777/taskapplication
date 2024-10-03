
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasenew/home.dart';
import 'package:firebasenew/otpscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'customtextfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final _auth = FirebaseAuth.instance;
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  Future<void>login()async{

    try  {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      print("object is : $userCredential");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
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


   Future<void> signinwithPhoneNum() async {
     await _auth.verifyPhoneNumber(
       phoneNumber: emailcontroller.text,
       verificationCompleted: (PhoneAuthCredential credential) async {
         // ANDROID ONLY!

         // Sign the user in (or link) with the auto-generated credential
         //await _auth.signInWithCredential(credential);
         try {
           await _auth.signInWithCredential(credential);
           print('Phone number automatically verified and user signed in.');
         } catch (e) {
           print('Error during automatic sign-in: $e');
         }
       },
       verificationFailed: (FirebaseAuthException error) {
         log(error.toString() as num);

       },
       codeSent: (String verificationId, int? forceResendingToken) {
         print("code sent to the phone number/n${emailcontroller.text}");
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(builder: (context) => OtpScreen(verificationId: verificationId)),
         );
       },
       codeAutoRetrievalTimeout: (String verificationId) {
print("Auto retrieval timeout" );
       },
     );

   }






  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: emailcontroller,
                hint: 'email',
              ),
              SizedBox(height: 20,),
              CustomTextField(
                controller: passwordcontroller,
                hint: 'password',
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: ()async{
                await login();
                print("logineddddd");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>  HomeScreen()),
                // );
              },
                child: Text("login"),),
              ElevatedButton(
                  onPressed: ()async{
                    await signInWithGoogle();

                  },
                  child: Text("Login with google")),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: ()async{
                    await signinwithPhoneNum();

                  },
                  child: Text("Login with number")),
            ],
          ),
        ),
      ),


    );
  }


}
