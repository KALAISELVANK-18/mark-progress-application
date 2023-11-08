import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'main.dart';





class Neww extends StatelessWidget {
  final String card;
  final String card2;
  List<dynamic> nn;
   Neww({Key? key,required this.card,required this.card2,required this.nn}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(60),
          ),),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child:Container(
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
                    child: Center(child: Text("My Report for ${card.toLowerCase()}",style: GoogleFonts.aclonica(textStyle: TextStyle(color: Color.fromARGB(255, 7, 19, 95 ),fontWeight: FontWeight.w900)),)),
                  ),
                ),
              ],
            ),
          ) ,
        ),
        backgroundColor: Color.fromARGB(255, 7, 19, 95 ),
        centerTitle: true,

        leading: Column(
          children: [
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 27,
                ),
                onPressed: () {

                  Navigator.of(context).pop();

                })

          ],
        ),
        actions: [

        ],
      ),

      body:


      (card.toString()!="SEM")?
      SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 10,),

            Container(
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("21CSE").doc(bo.get("pass")).collection(card2.toString()).doc(card.toString()).snapshots(),


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
                          itemCount: vv.length,
                          itemBuilder: (BuildContext context, index){
                            return Column(
                              children: [
                                SizedBox(height: 8,),
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.all(20),

                                    width: 350,
                                    decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width:300,
                                                    child: Center(
                                                      child: Text(

                                                        "${nn[index]}",

                                                        style:GoogleFonts.poppins(textStyle:TextStyle(
                                                            color: Colors.white,fontWeight: FontWeight.w600,
                                                            fontSize: 18
                                                        ) ) ,
                                                        maxLines: 3,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 17,),

                                                Row(
                                                  children: [
                                                    Container(
                                                      width:150,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: (isNumeric(vv[nn[index]]))?Text(
                                                          "Mark - ${vv[nn[index]]}/100",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w700
                                                          ),
                                                        ):Text(
                                                          "Absent",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w700
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                    ),
                                                    SizedBox(width: 17,),

                                                    (isNumeric(vv[nn[index]]))?Container(
                                                      width:120,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: (isNumeric(vv[nn[index]]))?Text(
                                                          "Status  - ${(double.parse(vv[nn[index]])>=50)?"Pass":"Fail"}",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w700
                                                          ),
                                                        ):SizedBox(),
                                                      ),
                                                    ):SizedBox(),
                                                  ],
                                                ),



                                              ],
                                            ),


                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
      ):
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),


            Container(
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("21CSE").doc(bo.get("pass")).collection(card2.toString()).doc(card.toString()).snapshots(),


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
                        child:
                        Column(


                          children: [
                        Column(
                        children: [
                        SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.all(20),
                          height: 140,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[900],
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
                                        "${"GPA"}",
                                        style:GoogleFonts.poppins(textStyle:TextStyle(
                                            color: Colors.white,
                                            fontSize: 24
                                        ) ) ,
                                      ),
                                      SizedBox(height: 17,),
                                      Text(
                                        "Score   ${vv["GPA"]}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ],
                                  ),


                                ],
                              ),

                            ],
                          ),
                        ),
                        ],
                      ),
                            Column(
                              children: [
                                SizedBox(height: 8,),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  height: 140,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple[900],
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
                                                "${"CGPA"}",
                                                style:GoogleFonts.poppins(textStyle:TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24
                                                ) ) ,
                                              ),
                                              SizedBox(height: 17,),
                                              Text(
                                                "Score   ${vv["CGPA"]}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),

                                            ],
                                          ),


                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: nn.length,
                              itemBuilder: (BuildContext context, index){

                                return Column(
                                  children: [
                                    SizedBox(height: 8,),
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.all(20),

                                        width: 350,
                                        decoration: BoxDecoration(
                                          color: Colors.indigo,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        width:300,
                                                        child: Center(
                                                          child: Text(

                                                            "${nn[index]}",

                                                            style:GoogleFonts.poppins(textStyle:TextStyle(
                                                                color: Colors.white,fontWeight: FontWeight.w600,
                                                                fontSize: 18
                                                            ) ) ,
                                                            maxLines: 3,
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                SizedBox(height: 17,),

                                                Row(
                                                  children: [
                                                    Container(
                                                      width:100,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "Grade -  ${vv[nn[index]]}",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w700
                                                          ),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(10)
                                                      ),
                                                    ),
                                                    SizedBox(width: 17,),

                                                    Container(
                                                      width:120,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "Status -  ${(vv[nn[index]]!='U')?"Pass":"Fail"}",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w700
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),



                                                  ],
                                                ),


                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );


                              },
                            ),
                          ],
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
      )
    );
  }

  bool isNumeric(String s) {
    if(s.isEmpty) {
      return false;
    }
    try{ double.parse(s);
    return true;
    }catch(e){
      return false;
    }
  }
}

