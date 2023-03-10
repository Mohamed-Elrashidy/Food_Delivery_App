import 'dart:convert';
import 'package:app/base/snack_bar_message.dart';
import 'package:app/utils/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseClient extends GetConnect implements GetxService {
  FirebaseClient()
  {
    timeout=Duration(seconds: 30);
  }
  saveUserData(String data) {}
  getUserInfo() {}
  Future<String> signUp(String email, String password, dynamic data) async {

   try{ UserCredential cerdintial = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print("sign up token is " + cerdintial.toString());

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      addToCloud(AppConstants.FIREBASE_USER_DATA, data);
      return user.uid;
    } else {
      return "";
    }}
       catch(e)
    {
      showSnackBar(e.toString());
      return "";
    }
  }

  void addToCloud(String uri, dynamic data) {
    CollectionReference target = FirebaseFirestore.instance.collection(uri);

    target
        .add(data)
        .then((value) => print("data Added"))
        .catchError((error) => print("Failed to add data: $error"));
    ;
  }

  Future<String> signIn(String email, String password) async {
  try{  UserCredential cerdintial = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    print(cerdintial.toString());
    final user = FirebaseAuth.instance.currentUser;
    String val;
    if (user != null) {
      val = await getFromCloud(AppConstants.FIREBASE_USER_DATA, "email", email);
      return user.uid.toString();
    }
  }
  catch(e)
{
  showSnackBar(e.toString());
}    return "";
  }

  Future<dynamic> getFromCloud(
      String uri, String parameter, String value) async {
    dynamic val = "";
try {
  await FirebaseFirestore.instance
      .collection(uri)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      if (doc[parameter] == value) {
        val = jsonEncode(doc.data());
      }
    });
  });
}catch(e){
    showSnackBar(e.toString());
    }

return val;
  }

  Future<List> getListFromCloud(String uri) async
  {
    List<dynamic> recivedData=[];
    print(FirebaseAuth.instance.currentUser);


      await FirebaseFirestore.instance
          .collection(uri)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {

            recivedData.add(doc.data());

        });
      });

    return recivedData;
  }
  signOut()
  {
    FirebaseAuth.instance.signOut();
  }
}
