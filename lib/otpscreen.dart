import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
   OtpScreen({super.key,required this.verificationId});
   String verificationId;
   final _auth = FirebaseAuth.instance;
final otpcontroller=TextEditingController();
   Future<void> verifyOTPCode() async {


     PhoneAuthCredential credential = PhoneAuthProvider.credential(
       verificationId: verificationId,
       smsCode: otpcontroller.text,
     );
     await _auth
         .signInWithCredential(credential)
         .then((value) => print('User Login In Successful'));
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("we have sent an otp"),
        TextField(
          controller: otpcontroller,
        keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'enter otp',
          ),
        ),
        ElevatedButton(
            onPressed: ()async{
           try{
             // PhoneAuthCredential credential = PhoneAuthProvider.credential(
             //     verificationId: verificationId,
             //     smsCode: otpcontroller.text);
             await verifyOTPCode();

           }catch(e){
        print("error");
           }
            },
            child: Text("otp"),),
          ],

        ),
      ),
    );
  }
}
