import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'connect.dart';
import 'home.dart';
import 'main.dart';
final bo = Hive.box('boxName');
class Alogin extends StatefulWidget {
  const Alogin({Key? key}) : super(key: key);

  @override
  State<Alogin> createState() => _AloginState();
}

class _AloginState extends State<Alogin> {
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
                'Welcome Back Admin !',
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
                      hintText: 'Enter Email'),
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
                      hintText: 'Enter Password'),
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
                    String vv=await obj.zz(email.text,pass.text);
                    if(vv=="success")
                    {
                      bo.put("utype","teacher");

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage1(),
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
                    child: TextButton(
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage1(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text('Are you student',
                                style: GoogleFonts.poppins(fontSize: 15, color: Colors.white)),
                            TextButton(onPressed:(){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const MyHomePage(),
                                ),
                              );
                            },
                              child: Text('Login here',
                                style: GoogleFonts.poppins(fontSize: 17, color: Colors.lightBlueAccent),),
                            ),
                          ],
                        )
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
