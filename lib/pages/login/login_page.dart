import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/models/login_model.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/service/user_service.dart';
import 'package:sail_app/utils/navigator_util.dart';
import 'package:sail_app/constant/app_strings.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  UserModel _userModel;
  LoginModel _loginModel;

  static final FormFieldValidator<String> _emailValidator = (value) {
    if (value.isEmpty ||
        !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
      return 'Enter Correct';
    }
    return null;
  };

  static final FormFieldValidator<String> _passwordValidator = (value) {
    if (value.isEmpty) {
      return 'Enter Correct password';
    }
    if (value.length < 6) {
      return 'Enter Correct password';
    }
    return null;
  };


  Future<String> _login(LoginData data) async {
    String result;

    try {
      await _loginModel.login(data.name, data.password);
    } catch (err) {
      result = 'Plz Login';
    }

    return result;
  }

  Future<String> _register(LoginData data) async {
    String result;

    try {
      await UserService()
          .register({'email': data.name, 'password': data.password});

      await _loginModel.login(data.name, data.password);
    } catch (err) {
      result = 'Error';
    }

    return result;
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    _userModel = Provider.of<UserModel>(context);
    _loginModel = LoginModel(_userModel);

    return FlutterLogin(
      title: AppStrings.APP_NAME,
      onLogin: _login,
      onSignup: _register,
      messages: LoginMessages(
          usernameHint: 'name ',
          passwordHint: 'Password',
          confirmPasswordHint: 'Conform Password',
          confirmPasswordError: 'Conform Password',
          forgotPasswordButton: 'Forget Password',
          loginButton: 'Login',
          signupButton: 'SignIn',
          recoverPasswordIntro: 'Recover',
          recoverPasswordButton: 'RecverPassword',
          recoverPasswordDescription: 'recoverPasswordDescription',
          recoverPasswordSuccess: 'Password Sucess',
          goBackButton: 'Back Button'),
      onSubmitAnimationCompleted: () {
        NavigatorUtil.goHomePage(context);
      },
      onRecoverPassword: _recoverPassword,
      emailValidator: _emailValidator,
      passwordValidator: _passwordValidator,
    );
  }
}
