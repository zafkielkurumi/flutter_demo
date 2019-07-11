import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:pwdflutter/pages/note/add_note.dart';
import 'package:pwdflutter/pages/note/note_detail.dart';
import 'package:pwdflutter/pages/note/editNote/edit_account_name.dart';
import 'package:pwdflutter/pages/note/editNote/edit_password.dart';
import 'package:pwdflutter/pages/note/editNote/edit_phone.dart';
import 'package:pwdflutter/pages/note/editNote/edit_web_name.dart';

var  addNoteHandler = Handler(
  handlerFunc: ( BuildContext context, Map<String, List<String>> params) {
    print(params.toString());
    // String result = params["result"]?.first;
    return AddNotePage();
  });


// var noteDetailHandler = Handler(
//   handlerFunc: (BuildContext context, Map params) {
//     print(params.toString());
//     return NoteDetailPage();
//   }
// );

final List noteRoutes = [
  {'url': '/addNote', 'handler': addNoteHandler, 'transitionType': TransitionType.inFromRight},
];