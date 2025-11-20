import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:note_app/view/screens/add_note_page.dart';
import 'package:note_app/view/screens/update_page.dart';

import '../widgets/custom_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: notes.orderBy('date').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('${snapshot.error}');
          return Text('Error : ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('View Notes', style: TextStyle(fontSize: 22)),

            actions: [
              IconButton(onPressed: ()async{
             GoogleSignIn googleSignIn=GoogleSignIn();
            await googleSignIn.disconnect();
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, 'login');

              }, icon: Icon(Icons.output_outlined))
            ],
            ),

            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var his=snapshot.data!.docs[index]['date'];
              late  DateTime date;
                final formatDate=his is Timestamp?date=his.toDate():date=DateTime.parse(his.toString());
                final format=DateFormat('dd,MM,yyyy').format(date);




                return GestureDetector(
                  onLongPress: () {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'Dialog Note',
                        btnOkText:'delete',
                        btnCancelText:'update' ,
                        btnCancelOnPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UpdateNotePage(
                                  title: snapshot.data!
                                      .docs[index]['title'],
                                  subtitle: snapshot.data!
                                      .docs[index]['subtitle'],
                                  id: snapshot.data!.docs[index].id,
                                );
                              },
                            ),
                          );

                        },

                    btnOkOnPress: () async{
                    await  FirebaseFirestore.instance
                          .collection('notes')
                          .doc(snapshot.data!.docs[index].id)
                          .delete();
                    },
                    ).show();




                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                snapshot.data!.docs[index]['title'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data!.docs[index]['subtitle'],
                              style: TextStyle(fontSize: 18),
                            ),



                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30,
                                bottom: 10,
                              ),
                              child: Text(format),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNotePage(

                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
            ),
          );
        } else {
          return Text('Error');
        }
      },
    );
  }
}
