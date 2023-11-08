import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'main.dart';
import 'markspage.dart';




final bo = Hive.box('boxName');
class New extends StatelessWidget {
  final String card;
  List<dynamic> nn;
   New({Key? key,required this.card,required this.nn}) : super(key: key);

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
                    child: Center(child: Text("My Exams for ${card.toLowerCase()}",style: GoogleFonts.aclonica(textStyle: TextStyle(color: Color.fromARGB(255, 7, 19, 95 ),fontWeight: FontWeight.w900)),)),
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

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recent exams",style: GoogleFonts.aclonica(textStyle: TextStyle(fontSize: 25, color: Color.fromARGB(255, 7, 19, 95 ),fontWeight: FontWeight.w900)),)
                ],
              ),
            ),

            SizedBox(height: 10,),


            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("21CSE").doc(bo.get("pass")).collection(card.toString()).snapshots(),


                builder: (context, AsyncSnapshot snapshot) {
                  if(snapshot.hasError)
                  {
                    return Text("${snapshot.error}");
                  }
                  else
                  {
                    if(snapshot.hasData) {
                      List<DocumentSnapshot> vv=snapshot.data.docs;


                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: vv.length,
                          itemBuilder: (BuildContext context, index) {
                            return TextButton(
                              onPressed: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>  Neww(card:vv[index].id,card2: card,nn:nn),
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
                                                  "${vv[index].id} MARKS",
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
    );
  }
}

