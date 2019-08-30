
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
import 'package:pwdflutter/pages/note/note_search.dart';



abstract class NoteRoutes {
  static String notesPage = '/notes';
  static String noteDetail = '/note_detail';
  static String addNote = '/add_note';
  static String noteHistory = '/note_history';
  static String editAccountName = '/edit_account_name';
  static String editPassword = '/edit_password';
  static String editPhone = '/edit_phone';
  static String editWebName = '/edit_web_name';
  static String editEmail = '/edit_email';
  static String noteSearch = '/note_search';
}

Map<String, Function> noteRoutes = {
NoteRoutes.notesPage : (BuildContext context , {arguments}) => NotesPage(),
NoteRoutes.noteDetail : (BuildContext context , {Object arguments}) => NoteDetailPage(arguments),
NoteRoutes.addNote : (BuildContext context , {Object arguments}) => AddNotePage(),
NoteRoutes.noteHistory : (BuildContext context , {Object arguments}) => PasswordHistory(arguments),
NoteRoutes.editAccountName : (BuildContext context , {Object arguments}) => EditAccountNamePage(arguments),
NoteRoutes.editPassword : (BuildContext context , {Object arguments}) => EditPasswordPage(arguments),
NoteRoutes.editPhone : (BuildContext context , {Object arguments}) => EditPhonePage(arguments),
NoteRoutes.editWebName : (BuildContext context , {Object arguments}) => EditWebNamePage(arguments),
NoteRoutes.editEmail : (BuildContext context , {Object arguments}) => EditEmailPage(arguments),
NoteRoutes.noteSearch : (BuildContext context , {Object arguments}) => NoteSearchPage(),
};
