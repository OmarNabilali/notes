import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/constant.dart';
import 'package:note_app/view/widgets/custom_button.dart';
import 'package:note_app/view/widgets/custom_text_form.dart';

class UpdateNotePage extends StatefulWidget {
  const UpdateNotePage({super.key, required this.id, required this.title, required this.subtitle,  });

 final String id;
 final String title;
 final String subtitle;
  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  CollectionReference collection=FirebaseFirestore.instance.collection('notes');

  bool isLoading=false;
  TextEditingController titleCon=TextEditingController();
  TextEditingController subtitleCon=TextEditingController();
  @override
  void initState() {
    super.initState();
    titleCon.text=widget.title;
    subtitleCon.text=widget.subtitle;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('update Note',style: TextStyle(fontSize: 22),),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextForm(hintText: 'title',controller: titleCon,),
            SizedBox(height: 20,),

            CustomTextForm(hintText: 'subtitle',controller: subtitleCon,),
            SizedBox(height: 35,),

    CustomButton(

        color: Colors.orange,
        buttonName: Text('update Note'),

        onPressed: ()async{

  await FirebaseFirestore.instance.collection('notes').doc(widget.id).update({
     'title':titleCon.text,
     'subtitle':subtitleCon.text,
   });

   Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false,);

            }



            ),
          ],
        ),
      ),
    );
  }
}
