import 'package:pwdflutter/helper/auth.helper.dart';

class FingerModel {
  bool _didAuthenticate = false;

  bool get didAuthenticate => _didAuthenticate;
  
  Future<bool> checkFingerAuth() async {
    print('3');
    if (_didAuthenticate) {
      return _didAuthenticate;
    }
    _didAuthenticate = await checkBiometrics();
    return _didAuthenticate;
  }

  void dispose() {
    _didAuthenticate = false;
  }

}