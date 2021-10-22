import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import '../../../model/shared/user_account_info.dart';
import '../../../core/utils/user_info.dart';
import 'personal_information_vm.dart';

class PersonalInformationScreen extends StatefulWidget {
  UserAccount userAccount;

  PersonalInformationScreen({Key key}) : super(key: key);

  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.userAccount = getIt<UserInfo>().getUserAccount();

    return ChangeNotifierProvider<PersonalInformationScreenVm>(
      create: (context) => PersonalInformationScreenVm(context: context),
      child: Consumer<PersonalInformationScreenVm>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: MainAppBar(
              context: context,
              title: value.getTitleBar(context),
              leading: ButtonBackWhite(context),
            ),
            body: _builBody(context, value),
          );
        },
      ),
    );
  }

  Container _builBody(BuildContext context, PersonalInformationScreenVm value) {
    return Container(
      width: double.infinity,
      padding: MediaQuery.of(context).size.width < 800
          ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0)
          : EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.10),
      margin: EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.userAccount.nationality == "TC"
                            ? LocaleProvider.of(context).tc_identity_number
                            : LocaleProvider.of(context).passport_number,
                        style: TextStyle(color: R.color.grey, fontSize: 16),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          widget.userAccount.nationality == "TC"
                              ? widget.userAccount.identificationNumber
                              : widget.userAccount.passaportNumber,
                          style: TextStyle(color: R.color.black, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                LocaleProvider.of(context).name,
                                style: TextStyle(
                                    color: R.color.grey, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                widget.userAccount.name +
                                    " " +
                                    widget.userAccount.surname,
                                style: TextStyle(
                                    color: R.color.black, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                LocaleProvider.of(context).birth_date,
                                style: TextStyle(
                                    color: R.color.grey, fontSize: 16),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              LocaleProvider.of(context).phone_number,
                              style:
                                  TextStyle(color: R.color.grey, fontSize: 16),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                widget.userAccount.patients.length > 0
                                    ? value.getFormattedDate(widget
                                        .userAccount.patients.first.birthDate)
                                    : "-",
                                style: TextStyle(
                                    color: R.color.black, fontSize: 18),
                              ),
                            ),
                            Expanded(
                                child: Row(
                              children: [
                                Text(
                                  widget.userAccount.phoneNumber,
                                  style: TextStyle(
                                      color: R.color.black, fontSize: 18),
                                ),
                                /*SizedBox(width: 5),
                                IconButton(
                                  onPressed: () {
                                    value.showUpdatePhoneNumberDialog(
                                        phoneController);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: R.color.blue,
                                  ),
                                ),*/
                              ],
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                LocaleProvider.of(context).email_address,
                                style: TextStyle(
                                    color: R.color.grey, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    widget.userAccount.electronicMail
                                            .contains("@mailyok.com")
                                        ? "-"
                                        : widget.userAccount.electronicMail,
                                    style: TextStyle(
                                        color: R.color.black, fontSize: 18),
                                  ),
                                  /*SizedBox(width: 5),
                                  IconButton(
                                    onPressed: () {
                                      value.showUpdateEmailDialog(
                                          emailController);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: R.color.blue,
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
