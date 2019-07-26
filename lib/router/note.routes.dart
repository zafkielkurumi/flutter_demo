
import 'package:flutter/material.dart';
import 'package:pwdflutter/pages/note/add_note.dart';
import 'package:pwdflutter/pages/note/note_detail.dart';
import 'package:pwdflutter/pages/note/editNote/edit_account_name.dart';
import 'package:pwdflutter/pages/note/editNote/edit_password.dart';
import 'package:pwdflutter/pages/note/editNote/edit_phone.dart';
import 'package:pwdflutter/pages/note/editNote/edit_web_name.dart';
import 'package:pwdflutter/pages/note/notes.dart';
import 'package:pwdflutter/pages/note/editNote/edit_email.dart';
import 'package:pwdflutter/pages/note/password_history.dart';


Map<String, Function> noteRoutes = {
'/notes' : (BuildContext context , {arguments}) => NotesPage(),
'/note_detail' : (BuildContext context , {Object arguments}) => NoteDetailPage(arguments),
'/add_note' : (BuildContext context , {Object arguments}) => AddNotePage(),
'/note_history' : (BuildContext context , {Object arguments}) => PasswordHistory(arguments),
'/edit_account_name' : (BuildContext context , {Object arguments}) => EditAccountNamePage(arguments),
'/edit_password' : (BuildContext context , {Object arguments}) => EditPasswordPage(arguments),
'/edit_phone' : (BuildContext context , {Object arguments}) => EditPhonePage(arguments),
'/edit_web_name' : (BuildContext context , {Object arguments}) => EditWebNamePage(arguments),
'/edit_email' : (BuildContext context , {Object arguments}) => EditEmailPage(arguments)
};
