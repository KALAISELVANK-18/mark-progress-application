import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:mark/Newpage.dart';
import 'package:mark/connect.dart';
import 'package:flutter/foundation.dart';
import 'main.dart';


final bo = Hive.box('boxName');
class Student extends StatefulWidget {

  const Student({Key? key}) : super(key: key);

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
 MongoDatabasee obj=new MongoDatabasee();




  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(60),
      ),),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(150),
            child:StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('21CSE').doc(bo.get("pass")).snapshots(),
              builder: (context, snapshot) {
                return Container(
                  height: 150,
                  decoration:BoxDecoration(
                    color: Color.fromARGB(255, 7, 19, 95 ),
                    borderRadius: BorderRadius.only(

                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(50.0),
                    ),
                  ) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(

                        child: Container(

                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                Text("${bo.get("pass")} ",style: GoogleFonts.aclonica(textStyle: TextStyle(color: Color.fromARGB(255, 7, 19, 95 ),fontSize:16,fontWeight: FontWeight.bold)),),
                                Text("results",style: GoogleFonts.aclonica(textStyle: TextStyle(color: Color.fromARGB(255, 7, 19, 95 ),fontWeight: FontWeight.w900)),)
                              ],
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                );
              }
            ) ,
          ),
          backgroundColor: Color.fromARGB(255, 7, 19, 95 ),
          centerTitle: true,

          leading: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.person,size: 25,color: Colors.white,)
              ),
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 27,
                ),
                onPressed: () {
                    bo.put("utype","");
                  bo.put("email","");
                  bo.put("pass","");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(),
                      ),
                    );
                })
          ],
        ),

        body: SingleChildScrollView(

          child: Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Current Semester",style: GoogleFonts.aclonica(textStyle: TextStyle(fontSize: 25, color: Color.fromARGB(255, 7, 19, 95 ),fontWeight: FontWeight.w900)),)
                  ],
                ),
              ),

              SizedBox(height: 10,),
            TextButton(
              onPressed: ()async{
                int x=0;
                var y=<dynamic>[];
                int prev;



                await FirebaseFirestore.instance.collection("Details")
                    .doc("21Semdetails")
                    .get().then((result){x=result.get("currentsem");
                      y=result.get("${x}sub");});

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  New(card:"SEM${x}",nn:y),
                  ),
                );

              },
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 200,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance.collection("Details").doc("21Semdetails").snapshots(),


                                  builder: (context, AsyncSnapshot snapshot) {
                                    if(snapshot.hasError)
                                    {
                                      return Text("${snapshot.error}");
                                    }
                                    else
                                    {
                                      if(snapshot.hasData) {
                                        Map<String,dynamic> vv=snapshot.data.data();


                                        return  Text(
                                          "SEM ${vv["currentsem"]}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20
                                          ),
                                        );
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            Text(
                              "View exams",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  fontSize: 20

                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Past Semester",style: GoogleFonts.aclonica(textStyle: TextStyle(fontSize: 25, color: Color.fromARGB(255, 7, 19, 95 ),fontWeight: FontWeight.w900)),)
                ],
              ),
            ),


              Container(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection("Details").doc("21Semdetails").snapshots(),


                  builder: (context, AsyncSnapshot snapshot) {
                    if(snapshot.hasError)
                    {
                      return Text("${snapshot.error}");
                    }
                    else
                    {
                      if(snapshot.hasData) {
                        Map<String,dynamic> vv=snapshot.data.data();


                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: vv["currentsem"]-4,
                            itemBuilder: (BuildContext context, index) {
                                return TextButton(
                                  onPressed: () async {
                                    int x=0;
                                    List<dynamic> y=<dynamic>[];
                                    await FirebaseFirestore.instance.collection("Details")
                                        .doc("21Semdetails")
                                        .get().then((result){x=result.get("currentsem");y=result.get("${x-index-1}sub");});

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>  New(card:"SEM${x-index-1}",nn:y),
                                      ),
                                    );

                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 15,),
                                      Container(
                                      padding: EdgeInsets.all(20),
                                      height: 200,
                                      width: 350,
                                      decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "SEM ${vv["currentsem"]-1-index}",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "View marks",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                    color: Colors.white,
                                                    fontSize: 20

                                                  ),
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                              ),
                                    ],
                                  ),
                                );
                            },
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
