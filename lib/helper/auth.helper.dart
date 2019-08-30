import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

 Future<bool> checkBiometrics() async {
   var _didAuthenticate = false;
    LocalAuthentication localAuth = LocalAuthentication();
    AndroidAuthMessages androidAuthMessages = AndroidAuthMessages(
      fingerprintHint: '',
      fingerprintNotRecognized: '不能识别',
      fingerprintSuccess: '验证成功',
      cancelButton: '取消',
      signInTitle: '指纹验证',
      fingerprintRequiredTitle: '请设置指纹密码',
      goToSettingsButton: '设置指纹',
      goToSettingsDescription: '设置指纹密码验证',
    );
    const iosStrings = const IOSAuthMessages(
        cancelButton: '取消',
        goToSettingsButton: 'goToSettingsButton',
        goToSettingsDescription: 'goToSettingsDescription',
        lockOut: 'Please reenable your Touch ID');
    try {
      bool checkBiometrics = await localAuth.canCheckBiometrics;
      _didAuthenticate = await localAuth.authenticateWithBiometrics(
          localizedReason: '',
          useErrorDialogs: true,
          stickyAuth: false,
          iOSAuthStrings: iosStrings,
          androidAuthStrings: androidAuthMessages
          );
      return _didAuthenticate;
    } catch (e) {
      print(e);
      print('指纹出错');
      return _didAuthenticate;
    }
  }