/// THIS FILE IS GENERATED BY r_resources. DO NOT MODIFY MANUALLY.

// ignore_for_file: avoid_classes_with_only_static_members,always_specify_types,lines_longer_than_80_chars,non_constant_identifier_names,prefer_double_quotes,unnecessary_raw_strings,use_raw_strings

import 'package:flutter/material.dart';

class R {
  static const images = _ImageResources();
  static const svg = _SvgResources();
  static const fonts = _FontResources();
  static _Strings stringsOf(BuildContext context) => _Strings.of(context);
}

class _ImageResources {
  const _ImageResources();

  /// ![](C:\flutterProject\nbudget_v1.0\assets/images/logo.png)
  final logo = r'assets/images/logo.png';
}

class _SvgResources {
  const _SvgResources();
}

class _FontResources {
  const _FontResources();
}

class _Strings {
  const _Strings(this.locale);

  static const _fallbackLocale = Locale('en');
  final Locale locale;

  static _Strings of(BuildContext context) {
    return Localizations.of<_Strings>(context, _Strings);
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'signInButtonAuth': 'Sign in',
      'signUpButtonAuth': 'Sign up',
      'loginHintAuth': 'Login',
      'passwordHintAuth': 'Password',
      'labelsignInAuth': 'Sign in',
      'labelsignUpAuth': 'Sign up',
      'labelBottomSignUpAuth': 'Not registered? Sign up!',
      'labelBottomSignInAuth': 'Already registered? Log in!',
      'emptyTextFieldAuth': 'Login or password fields cannot be empty',
      'emptyUserAuth': 'Wrong email or password entered',
      'incorrectEmailAuth': 'Incorrect email input',
      'incorrectPasswordAuth': 'Incorrect password entry. The string must contain at least one number, one special character, a Latin letter in upper and lower case, the string consists of at least 6 characters',
      'successfulSignUpAuth': 'You have successfully registered',
    },
    'ru': {
      'signInButtonAuth': 'Войти',
      'signUpButtonAuth': 'Зарегистрироваться',
      'loginHintAuth': 'Логин',
      'passwordHintAuth': 'Пароль',
      'labelsignInAuth': 'Авторизация',
      'labelsignUpAuth': 'Регистрация',
      'labelBottomSignUpAuth': 'Не зарегистрирован? Зарегистрируйся!',
      'labelBottomSignInAuth': 'Уже зарегистрирован? Авторизируйся!',
      'emptyTextFieldAuth': 'Поля логина или пароля не могут быть пустыми',
      'emptyUserAuth': 'Неправильно введён логин или пароль',
      'incorrectEmailAuth': 'Некорректный ввод email',
      'incorrectPasswordAuth': 'Некорректный ввод пароля. Строка должна содержать хотя бы одно число, один спецсимвол, латинскую букву в верхнем и нижнем регистре, строка состоит не менее, чем из 6 символов',
      'successfulSignUpAuth': 'Вы успешно зарегистрированы',
    },
  };

  String _getString(String code) {
    return _localizedValues[locale.toString()][code] ??
        _localizedValues[_fallbackLocale.toString()][code] ??
        code;
  }

  /// 'Sign in'
  String get signInButtonAuth => _getString('signInButtonAuth');

  /// 'Sign up'
  String get signUpButtonAuth => _getString('signUpButtonAuth');

  /// 'Login'
  String get loginHintAuth => _getString('loginHintAuth');

  /// 'Password'
  String get passwordHintAuth => _getString('passwordHintAuth');

  /// 'Sign in'
  String get labelsignInAuth => _getString('labelsignInAuth');

  /// 'Sign up'
  String get labelsignUpAuth => _getString('labelsignUpAuth');

  /// 'Not registered? Sign up!'
  String get labelBottomSignUpAuth => _getString('labelBottomSignUpAuth');

  /// 'Already registered? Log in!'
  String get labelBottomSignInAuth => _getString('labelBottomSignInAuth');

  /// 'Login or password fields cannot be empty'
  String get emptyTextFieldAuth => _getString('emptyTextFieldAuth');

  /// 'Wrong email or password entered'
  String get emptyUserAuth => _getString('emptyUserAuth');

  /// 'Incorrect email input'
  String get incorrectEmailAuth => _getString('incorrectEmailAuth');

  /// 'Incorrect password entry. The string must contain at least one number, one special character, a Latin letter in upper and lower case, the string consists of at least 6 characters'
  String get incorrectPasswordAuth => _getString('incorrectPasswordAuth');

  /// 'You have successfully registered'
  String get successfulSignUpAuth => _getString('successfulSignUpAuth');
}

class RStringsDelegate extends LocalizationsDelegate<_Strings> {
  const RStringsDelegate();

  static const supportedLocales = [
    Locale('en'),
    Locale('ru'),
  ];

  static const fallbackLocale = Locale('en');

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  Future<_Strings> load(Locale locale) async {
    return _Strings(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<_Strings> old) => false;
}
