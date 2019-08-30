
import 'package:flutter/material.dart';
import 'package:pwdflutter/pages/tests/design_mode/Inherited/Inherited.page.dart';
import 'package:pwdflutter/pages/tests/design_mode/provider/provider.page.dart';
import 'package:pwdflutter/pages/tests/form/form.page.dart';
import 'package:pwdflutter/pages/tests/provider/provider_google.page.dart';


abstract class TestRoutes {
  static String testInherited = '/test_inherited';
  static String testProvider = '/test_provider';
  static String testProviderMe = '/test_provider_me';
  static String testForm = '/test_form';
  static String testProviderGoogle = '/testProviderGoogle';
}

Map<String, Function> testRoutes = {
TestRoutes.testInherited: (BuildContext context , {Map arguments}) => InheritedPage(),
TestRoutes.testProviderMe: (BuildContext context , {Map arguments}) => ProviderPage(),
TestRoutes.testForm: (BuildContext context , {Map arguments}) => FormPage(),
TestRoutes.testProviderGoogle: (BuildContext context , {Map arguments}) => ProviderGooglePage(),
};
