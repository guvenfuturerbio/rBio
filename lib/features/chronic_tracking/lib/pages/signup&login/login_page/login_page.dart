import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../extension/size_extension.dart';
import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import 'login_page_vm.dart';

part '../widgets/login_option_button.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider(
      create: (context) => LoginPageVm(context: context),
      child: Consumer<LoginPageVm>(
        builder: (context, value, child) {
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: SvgPicture.asset(R.image.login_screen_bg,
                          fit: BoxFit.fill),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
                SafeArea(
                  child: SizedBox(
                    height: context.HEIGHT,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Hero(
                          tag: "logo",
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 80, 0, 0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: SvgPicture.asset(
                                R.image.guven_logo,
                                width: MediaQuery.of(context).size.width * .25,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: getLoginButton(context, value),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DropdownButton<Locale>(
                              hint: Text(
                                LocaleProvider.current.select_language +
                                    ": " +
                                    Intl.getCurrentLocale().toUpperCase(),
                                style: TextStyle(color: R.color.blue),
                              ),
                              items: LocaleProvider.delegate.supportedLocales
                                  .map((Locale value) {
                                return new DropdownMenuItem<Locale>(
                                  value: value,
                                  child: new Text(
                                      value.languageCode.toUpperCase()),
                                );
                              }).toList(),
                              onChanged: (val) {
                                print(
                                    'SELECTED COUNTRY CODE: ${val.toString()}');
                                value.changeCountryCode(val.toString());
                              },
                            ),

                            /// MGD2
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor: R.color.blue),
                                    child: Checkbox(
                                      value: value.clickedGeneralForm,
                                      onChanged: (newValue) {
                                        value.showApplicationContestForm();
                                      },
                                      activeColor: R
                                          .regularBlue, //// <-- leading Checkbox
                                      // ,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 6,
                                    child: InkWell(
                                      onTap: () {
                                        value.showApplicationContestForm();
                                      },
                                      child: Text(
                                          LocaleProvider.current
                                              .accept_application_consent_form,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: R.color.blue,
                                            decoration:
                                                TextDecoration.underline,
                                          )),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Column getLoginButton(BuildContext context, LoginPageVm value) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _loginOptionButton(
            context,
            icon: R.image.google_icon,
            title: LocaleProvider.current.sign_with_google,
            onPress: () => value.signInWithGoogle(),
          ),
          _loginOptionButton(
            context,
            icon: R.image.facebook_logo,
            title: LocaleProvider.current.sign_with_facebook,
            onPress: () => value.signInWithFacebook(),
          ),
    /*      _loginOptionButton(
            context,
            icon: R.image.apple_logo,
            title: LocaleProvider.current.sign_with_apple,
            onPress: () => value.signInWithApple(),
            isVisible: value.visibilityAppleSignIn,
          ),*/
          _loginOptionButton(
            context,
            icon: R.image.mail_icon,
            title: LocaleProvider.current.sign_with_email,
            onPress: () => value.signInWithEmail(),
          ),
        ]);
  }
}
