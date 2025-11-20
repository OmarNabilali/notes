import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/view/screens/home_screen.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FirebaseAuth.instance.currentUser!.emailVerified?Text('verify'):
              MaterialButton(
                color: Colors.red,
                onPressed: ()async{

                    await FirebaseAuth.instance.currentUser!.reload();



                    await FirebaseAuth.instance.currentUser!.sendEmailVerification();






              },child: Text('verified'),),
        ],
      ),
    );
  }
}
