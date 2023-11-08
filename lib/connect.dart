

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';




class MongoDatabasee{

  zz(String email,String pass)async{


    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      // if success
      return "success";

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "User not found";
      } else if (e.code == 'wrong-password') {
        return "Wrong password";
      }
    }

    return "gfd";
  }
  zzz(String email,String pass)async{
    try {

      var m=pass.toUpperCase().substring(0,4).toString();



     if(await FirebaseFirestore.instance.collection("21CSE").where("phoneno",isEqualTo: email).snapshots().length==1)
     {



     }


    } on Exception catch (e) {
      // if (e.code == 'user-not-found') {
      //   return "User not found";
      // } else if (e.code == 'wrong-password') {
      //   return "Wrong password";
      // }

    }



  }

  xx() async {
    final int x=await FirebaseFirestore.instance.collection("Details")
        .doc("21Semdetails")
        .get().then((result)=>result.get("currentsem"));
    return x;
  }

}