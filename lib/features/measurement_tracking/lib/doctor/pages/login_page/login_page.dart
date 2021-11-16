import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/pages/login_page/login_page_view_model.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/resources/resources.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/utils/widgets.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final passwordController = TextEditingController();
  final userIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<LoginPageViewModel>(
        create: (context) => LoginPageViewModel(context: context),
        child: Consumer<LoginPageViewModel>(
          builder: (context, value, child) {
            passwordController.text = value.passwordText;
            passwordController.selection = TextSelection.collapsed(
                offset: value?.passwordText?.length ?? 0);
            userIdController.text = value.userIdText;
            userIdController.selection =
                TextSelection.collapsed(offset: value?.userIdText?.length ?? 0);
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            R.image.largeGreenBar,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 80, 0, 0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: SvgPicture.asset(
                                R.image.oneDoseLogo,
                                width: MediaQuery.of(context).size.width * .4,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        children: [
                          Container(
                            child: TextFormField(
                              controller: userIdController,
                              cursorColor: R.color.mainColor,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              onChanged: (valueText) {
                                value.setUserIdText(valueText);
                              },
                              style: inputTextStyle(),
                              decoration: inputImageDecoration(
                                hintText: LocaleProvider.current.user_id,
                                image: R.image.search,
                              ),
                            ),
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: inputBoxDecoration(),
                          ),
                          Container(
                            child: TextFormField(
                              controller: passwordController,
                              cursorColor: R.color.mainColor,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: inputTextStyle(),
                              onChanged: (valueText) {
                                value.setPasswordText(valueText);
                              },
                              decoration: inputImageDecoration(
                                hintText: LocaleProvider.current.password,
                                image: R.image.search,
                              ),
                            ),
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: inputBoxDecoration(),
                          ),
                        ],
                      ),
                    ),
                    button(
                        text: LocaleProvider.current.sign_in,
                        onPressed: () {
                          value.login();
                        })
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
