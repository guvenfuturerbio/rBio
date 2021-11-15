import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../../notifiers/user_notifier.dart';
import 'email_login_page_vm.dart';

class EmailLoginPage extends StatefulWidget {
  @override
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  final passwordController = TextEditingController();
  final userIdController = TextEditingController();

  final passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmailLoginPageVm(context: context),
      child: Consumer<EmailLoginPageVm>(
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: Color.fromRGBO(240, 240, 240, 1),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Form(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Consumer<UserNotifier>(
                        builder: (context, valueFromNotifier, child) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              //    crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  //         height: 200,
                                  child: Stack(
                                    children: [
                                      SvgPicture.asset(
                                        R.image.top_bg_blue,
                                        fit: BoxFit.cover,
                                        //      height: 300,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1.1,
                                      ),
                                      Hero(
                                        tag: 'logo',
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              30,
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.2,
                                              0,
                                              0),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: SvgPicture.asset(
                                              R.image.guven_logo,
                                              //      height: 150,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    width: 300,
                                    child: Theme(
                                      data: ThemeData(
                                          primaryColor: R.btnLightBlue),
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        controller: userIdController,
                                        autofocus: true,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onEditingComplete: () =>
                                            passwordFocusNode.requestFocus(),
                                        decoration: _inputDeco(context,
                                            hintText:
                                                LocaleProvider.current.email,
                                            icon: Icons.email_outlined),
                                      ),
                                    )),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    width: 300,
                                    child: Theme(
                                      data: ThemeData(
                                          primaryColor: R.btnLightBlue),
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        focusNode: passwordFocusNode,
                                        onEditingComplete: () => value.signIn(
                                            userIdController.text,
                                            passwordController.text),
                                        controller: passwordController,
                                        decoration: _inputDeco(context,
                                            hintText:
                                                LocaleProvider.current.password,
                                            icon: Icons.lock_outlined),
                                      ),
                                    )),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft,
                                        colors: <Color>[
                                          R.btnLightBlue,
                                          R.btnDarkBlue
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.transparent,
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: Text(
                                          LocaleProvider.current.sign_in,
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () async {
                                        value.signIn(userIdController.text,
                                            passwordController.text);
                                        //_signIn(context);
                                      },
                                    ),
                                    //color: R.darkGreen,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.SIGN_UP_PAGE);
                                    },
                                    child: Text(LocaleProvider.current.sign_up,
                                        style: TextStyle(
                                            color: R.color.border_color))),
                              ]);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.width / 7,
                    left: MediaQuery.of(context).size.width / 20,
                    child: InkWell(
                        child: SvgPicture.asset(R.image.back_icon,
                            width: MediaQuery.of(context).size.width * 0.08),
                        onTap: () => Navigator.of(context).pop()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDeco(BuildContext context,
      {IconData icon, String hintText}) {
    return InputDecoration(
      hoverColor: R.color.main_color,
      focusColor: R.color.main_color,
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(icon, color: R.color.border_color),
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 12),
      labelText: hintText,
      border: OutlineInputBorder(
          borderSide: BorderSide(color: R.color.main_color),
          borderRadius: BorderRadius.circular(30)),
    );
  }
}
