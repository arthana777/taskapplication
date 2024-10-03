import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? name;
  final String? email;
  final String? phoneno;
  final String? password;

  UserModel({
    this.name,
    this.email,
    this.phoneno,
    this.password
});
  toJson(){
    return{
      "name":name,
      "email":email,
      "phoneno":phoneno,
      "password":password
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    return UserModel(
      name: document.data()?['name'],
      email: document.data()?['email'],
      phoneno: document.data()?['phoneno'],
        password: document.data()?['password'],
    );
  }

}