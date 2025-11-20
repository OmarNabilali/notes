import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/constant.dart';
import 'package:note_app/view/widgets/custom_button.dart';
import 'package:note_app/view/widgets/custom_text_form.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key,   });

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  CollectionReference collection=FirebaseFirestore.instance.collection('notes');
GlobalKey<FormState>formState=GlobalKey();
  bool isLoading=false;
  TextEditingController titleCon=TextEditingController();
  TextEditingController subtitleCon=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Note',style: TextStyle(fontSize: 22),),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Form(
          key: formState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextForm(
                onSaved: (value){
                  titleCon.text!=value;
                },
                hintText: 'title',controller: titleCon,),
              SizedBox(height: 20,),

              CustomTextForm(
                onSaved: (value){
                  subtitleCon.text!=value;
                },
                hintText: 'subtitle',controller:subtitleCon,),
              SizedBox(height: 35,),

            isLoading?Center(child: CircularProgressIndicator()) :CustomButton(buttonName: Text( 'Add Note'),

                color: Colors.orange,
                onPressed: (){

                 if(formState.currentState!.validate()){
                   formState.currentState!.save();
                   isLoading=true;
                   collection.add({
                     'title':titleCon.text,
                     'subtitle':subtitleCon.text,
                     'date':DateTime.now().toString(),
                   });
                   isLoading=false;
                   setState(() {

                   });

                   Navigator.pop(context);

                 }
                }



              ),
            ],
          ),
        ),
      ),
    );
  }
}
