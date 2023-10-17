import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/commonBtn.dart';
import 'package:flutter_application_1/Components/commonInput.dart';
import 'package:flutter_application_1/Components/customDropDown.dart';
import 'package:flutter_application_1/const.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as error_code;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'dart:io';
import 'dart:developer';

const List<Widget> fruits = <Widget>[
  Text('Login'),
  Text('Sign-Up'),
];

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

//Credentails:  "email": "eve.holt@reqres.in",  "password": "pistol"

class _LoginState extends State<Login> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<BiometricType>? availableBiometrics;
  final List<bool> _selectedFruits = <bool>[true, false];
  bool isDeviceSupport = false;
  final textFieldFocusNode = FocusNode();
  LocalAuthentication? auth;
  bool _obscured = false;
  bool vertical = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    deviceCapability();
  }

  _onclicked(value) {
    print('Clicked...' + value.toString());
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void deviceCapability() async {
    final bool isCapable = await auth!.canCheckBiometrics;
    isDeviceSupport = isCapable || await auth!.isDeviceSupported();
  }

  void _getAvailableBiometrics() async {
    try {
      availableBiometrics = await auth?.getAvailableBiometrics();
      print("bioMetric: $availableBiometrics");

      if (availableBiometrics!.contains(BiometricType.strong) ||
          availableBiometrics!.contains(BiometricType.fingerprint)) {
        final bool didAuthenticate = await auth!.authenticate(
            localizedReason:
                'Unlock your screen with PIN, pattern, password, face, or fingerprint',
            options: const AuthenticationOptions(
                biometricOnly: true, stickyAuth: true),
            authMessages: const <AuthMessages>[
              AndroidAuthMessages(
                signInTitle: 'Unlock Ideal Group',
                cancelButton: 'No thanks',
              ),
              IOSAuthMessages(
                cancelButton: 'No thanks',
              ),
            ]);
        if (!didAuthenticate) {
          exit(0);
        }
      } else if (availableBiometrics!.contains(BiometricType.weak) ||
          availableBiometrics!.contains(BiometricType.face)) {
        final bool didAuthenticate = await auth!.authenticate(
            localizedReason:
                'Unlock your screen with PIN, pattern, password, face, or fingerprint',
            options: const AuthenticationOptions(stickyAuth: true),
            authMessages: const <AuthMessages>[
              AndroidAuthMessages(
                signInTitle: 'Unlock Ideal Group',
                cancelButton: 'No thanks',
              ),
              IOSAuthMessages(
                cancelButton: 'No thanks',
              ),
            ]);
        if (!didAuthenticate) {
          exit(0);
        }
      }
    } on PlatformException catch (e) {
      // availableBiometrics = <BiometricType>[];
      if (e.code == error_code.passcodeNotSet) {
        exit(0);
      }
      print("error: $e");
    }
  }

  void onLogin(userNameController, passwordController) async {
    print('login');
    if (formKey.currentState!.validate()) {
      print('ok');
    } else {
      // try {
      //   Response response = await post(
      //       Uri.parse('https://reqres.in/api/register'),
      //       body: {'email': username, 'password': password});
      //   if (response.statusCode == 200) {
      //     print('Account created successfully');
      //   } else {
      //     print('failed');
      //   }
      // } catch (e) {
      //   print(e.toString());
      // }
    }
  }

  void onSignUP(
      firstNameController,
      lastNameController,
      phoneNumberController,
      licenseController,
      passwordController,
      confirmPasswordController,
      emailController) async {
    print('ok');
    if (formKey.currentState!.validate()) {
      print('ok');
    } else {
      // try {
      //   Response response = await post(
      //       Uri.parse('https://reqres.in/api/register'),
      //       body: {'email': email, 'password': password});
      //   if (response.statusCode == 200) {
      //     print('Account created successfully');
      //   } else {
      //     print('failed');
      //   }
      // } catch (e) {
      //   print(e.toString());
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: size.height * 0.999,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 236, 239, 237),
          ),
          child: SingleChildScrollView(
            child: OverflowBar(
              overflowAlignment: OverflowBarAlignment.center,
              children: <Widget>[
                Container(
                  height: size.height * 0.35,
                  width: size.width * 0.990,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(155, 45),
                      bottomLeft: Radius.elliptical(155, 45),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 90),
                      SizedBox(
                          width: 250,
                          child: Image.asset('assets/logo_dent_scribe.png')),
                      const SizedBox(height: 20),
                      const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Welcome to Dentscribe!",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )),
                      const SizedBox(height: 20),
                      ToggleButtons(
                        direction: vertical ? Axis.vertical : Axis.horizontal,
                        onPressed: (int index) {
                          setState(() {
                            //_selectedFruits[index] = true;

                            for (int i = 0; i < _selectedFruits.length; i++) {
                              if (i == index) {
                                _selectedFruits[i] = true;
                              } else {
                                _selectedFruits[i] = false;
                              }
                            }
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        selectedColor: Colors.black,
                        fillColor: const Color.fromARGB(255, 42, 221, 123),
                        color: const Color.fromARGB(255, 142, 141, 141),
                        constraints: const BoxConstraints(
                          minHeight: 50.0,
                          minWidth: 100.0,
                        ),
                        isSelected: _selectedFruits,
                        children: fruits,
                      ),
                    ],
                  ),
                ),
                if (_selectedFruits[0])
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        height: 500,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 251, 251, 251),
                          border: Border.all(
                            color: const Color.fromARGB(255, 233, 233, 233),
                            width: 0.9,
                          ),
                        ),
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Sign in with your username and password or use biometrics/multifactor authentication for enhanced security ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 115, 129, 120)),
                                  )),
                              const SizedBox(height: 20),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.person_2_outlined,
                                    color: Color.fromARGB(255, 42, 221, 123),
                                    size: 17,
                                  ),
                                  SizedBox(width: 5),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Username",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 142, 141, 141)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              CommonInput(
                                  ctrl: userNameController,
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: 'Required !'),
                                    EmailValidator(errorText: "Invalid email"),
                                  ]),
                                  hintText: 'username',
                                  keyboardType: TextInputType.name,
                                  autoFocus: true,
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false),
                              const SizedBox(height: 20),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.verified_user_outlined,
                                    color: Color.fromARGB(255, 42, 221, 123),
                                    size: 17,
                                  ),
                                  SizedBox(width: 5),
                                  Align(
                                    child: Text(
                                      "Password",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 142, 141, 141)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              CommonInput(
                                  hintText: 'password',
                                  ctrl: passwordController,
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: 'Required !'),
                                    MinLengthValidator(6,
                                        errorText: 'Password length must be 6'),
                                  ]),
                                  keyboardType: TextInputType.phone,
                                  autoFocus: true,
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 1),
                                    child: GestureDetector(
                                      onTap: _getAvailableBiometrics,
                                      child: const Icon(
                                        Icons.fingerprint,
                                        color: Color.fromARGB(255, 39, 170, 98),
                                        size: 17,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 45),
                                    child: Align(
                                      child: Text("Set up biometrics",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.black,
                                          )),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Forgot Password ?",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 42, 221, 123),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 82),
                              CommonButton(
                                onPressed: () {
                                  onLogin(
                                      userNameController, passwordController);
                                },
                              ),
                            ],
                          ),
                        )),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        height: size.height * 1.2,
                        width: size.width * 0.99,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 251, 251, 251),
                          border: Border.all(
                            color: const Color.fromARGB(255, 233, 233, 233),
                            width: 0.9,
                          ),
                        ),
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Set up your new account. You can also add payment information next if you choose to subscribe to our service.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 115, 129, 120),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person_2_outlined,
                                              color: Color.fromARGB(
                                                  255, 42, 221, 123),
                                              size: 17,
                                            ),
                                            SizedBox(width: 5),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "First Name",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 11,
                                                    color: Color.fromARGB(
                                                        255, 142, 141, 141)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            width: 141,
                                            child: CommonInput(
                                                hintText: 'First Name',
                                                ctrl: firstNameController,
                                                validator: MultiValidator([
                                                  RequiredValidator(
                                                      errorText: 'Required !'),
                                                ]),
                                                keyboardType:
                                                    TextInputType.phone,
                                                autoFocus: true,
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                obscureText: false)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person_2_outlined,
                                              color: Color.fromARGB(
                                                  255, 42, 221, 123),
                                              size: 17,
                                            ),
                                            SizedBox(width: 5),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Last Name",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 11,
                                                    color: Color.fromARGB(
                                                        255, 142, 141, 141)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            width: 142,
                                            child: CommonInput(
                                                hintText: 'Last Name',
                                                ctrl: lastNameController,
                                                validator: MultiValidator([
                                                  RequiredValidator(
                                                      errorText: 'Required !'),
                                                ]),
                                                keyboardType:
                                                    TextInputType.phone,
                                                autoFocus: true,
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                obscureText: false)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          color:
                                              Color.fromARGB(255, 42, 221, 123),
                                          size: 17,
                                        ),
                                        SizedBox(width: 5),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "E-mail",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                                color: Color.fromARGB(
                                                    255, 142, 141, 141)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CommonInput(
                                        hintText: 'E-mail',
                                        ctrl: emailController,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: 'Required !'),
                                          EmailValidator(
                                              errorText: "Invalid email"),
                                        ]),
                                        keyboardType: TextInputType.phone,
                                        autoFocus: true,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText: false),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          color:
                                              Color.fromARGB(255, 42, 221, 123),
                                          size: 17,
                                        ),
                                        SizedBox(width: 5),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Phone Number",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                                color: Color.fromARGB(
                                                    255, 142, 141, 141)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CommonInput(
                                        hintText: 'e.g. 1234567898',
                                        ctrl: phoneNumberController,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: 'Required !'),
                                          MinLengthValidator(10,
                                              errorText:
                                                  'Phone length must be 10 digit')
                                        ]),
                                        keyboardType: TextInputType.phone,
                                        autoFocus: true,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText: false),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          color:
                                              Color.fromARGB(255, 42, 221, 123),
                                          size: 17,
                                        ),
                                        SizedBox(width: 5),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Your Role",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                                color: Color.fromARGB(
                                                    255, 142, 141, 141)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CustomDropdown(),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          color:
                                              Color.fromARGB(255, 42, 221, 123),
                                          size: 17,
                                        ),
                                        SizedBox(width: 5),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "License Number",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                                color: Color.fromARGB(
                                                    255, 142, 141, 141)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CommonInput(
                                      hintText: "License Number",
                                      ctrl: licenseController,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: 'Required !'),
                                      ]),
                                      keyboardType: TextInputType.phone,
                                      autoFocus: true,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      obscureText: true,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          color:
                                              Color.fromARGB(255, 42, 221, 123),
                                          size: 17,
                                        ),
                                        SizedBox(width: 5),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Password",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                                color: Color.fromARGB(
                                                    255, 142, 141, 141)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CommonInput(
                                        hintText: "Password",
                                        ctrl: passwordController,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: 'Required !'),
                                          MinLengthValidator(6,
                                              errorText:
                                                  'Password length must be 6')
                                        ]),
                                        keyboardType: TextInputType.phone,
                                        autoFocus: true,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText: false),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          color:
                                              Color.fromARGB(255, 42, 221, 123),
                                          size: 17,
                                        ),
                                        SizedBox(width: 5),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Confirm Password",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                                color: Color.fromARGB(
                                                    255, 142, 141, 141)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CommonInput(
                                        hintText: "Confirm Password",
                                        ctrl: confirmPasswordController,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: 'Required !'),
                                          MinLengthValidator(6,
                                              errorText:
                                                  'Password length must be 6')
                                        ]),
                                        keyboardType: TextInputType.phone,
                                        autoFocus: true,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText: false),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Column(
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          color:
                                              Color.fromARGB(255, 42, 221, 123),
                                          size: 17,
                                        ),
                                        SizedBox(width: 5),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Select Your Practice Management Software",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                                color: Color.fromARGB(
                                                    255, 142, 141, 141)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const CustomDropdown(),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 50, 10, 10),
                                    child: CommonButton(
                                      onPressed: () {
                                        onSignUP(
                                            firstNameController,
                                            lastNameController,
                                            phoneNumberController,
                                            licenseController,
                                            passwordController,
                                            confirmPasswordController,
                                            emailController);
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ]),
                          ),
                        )),
                  ),
              ],
            ),
          )),
    );
  }
}
