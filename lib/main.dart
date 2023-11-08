import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mark/adminlogin.dart';
import 'package:mark/student.dart';
import 'firebase_options.dart';
import 'package:mark/connect.dart';
import 'home.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';

final user = FirebaseAuth.instance.currentUser;
final bo = Hive.box('boxName');
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  await Hive.initFlutter();
  await Hive.openBox('boxName');
  final boo = Hive.box('boxName');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'fgc',
      theme: ThemeData.dark(),
      home: (boo.get("utype")=="teacher")?MyHomePage1():(boo.get("utype")=="student")?Student():MyHomePage(),

    ),
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final boo = Hive.box('boxName');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: (boo.get("utype")=="teacher")?const MyHomePage1():(boo.get("utype")=="student")?Student():MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static const String routeName = "/";




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  MongoDatabasee obj=new MongoDatabasee();

  @override
  Widget build(BuildContext context) {
    TextEditingController email=new TextEditingController();
    TextEditingController pass=new TextEditingController();
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Icon(
                Icons.swipe_down,
                size: 100,
                color: Colors.blueAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Hello Again!',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Welcome Back you have been missed !',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 23),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter PhoneNo'),
                )),
            Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  controller: pass,
                  decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter RollNo'),
                )),

            Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    padding: MaterialStateProperty.all(EdgeInsets.only(
                        top: 15, bottom: 15, right: 130, left: 130)),
                    backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async{
                     final String vv = await FirebaseFirestore.instance.collection("21CSE")
                        .doc(pass.text.toUpperCase())
                        .get().then((result)=>result.get("phoneno"));


                    if(vv.toString()==email.text.toString())
                    {
                      bo.put("utype","student");
                      bo.put("email",email.text.toString());
                      bo.put("pass",pass.text.toUpperCase().toString());
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Student(),
                        ),
                      );
                    }

                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Center(

                  child: Padding(

                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                      Text('Are you admin',
                      style: GoogleFonts.poppins(fontSize: 15, color: Colors.white)),
                        TextButton(onPressed:(){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Alogin(),
                            ),
                          );
                        },
                          child: Text('Login here',
                            style: GoogleFonts.poppins(fontSize: 17, color: Colors.lightBlueAccent),),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),

          ]),
        ),
      ),
    );
  }
}










