import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/shared/user_account_info.dart';
import '../../../../core/utils/user_info.dart';
import '../viewmodel/personal_information_vm.dart';

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
          return RbioScaffold(
            appbar: RbioAppBar(
              title: value.getTitleBar(context),
            ),
            body: _builBody(context, value),
          );
        },
      ),
    );
  }

  Widget _builBody(BuildContext context, PersonalInformationScreenVm value) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
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
                      style: context.xHeadline3
                          .copyWith(color: getIt<ITheme>().mainColor),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.userAccount.nationality == "TC"
                                  ? widget.userAccount.identificationNumber
                                  : widget.userAccount.passaportNumber,
                              style:
                                  TextStyle(color: R.color.black, fontSize: 18),
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
                              LocaleProvider.of(context).name,
                              style: context.xHeadline3
                                  .copyWith(color: getIt<ITheme>().mainColor),
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
                              style:
                                  TextStyle(color: R.color.black, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              LocaleProvider.of(context).birth_date,
                              style: context.xHeadline3
                                  .copyWith(color: getIt<ITheme>().mainColor),
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
                              widget.userAccount.patients.length > 0
                                  ? value.getFormattedDate(widget
                                      .userAccount.patients.first.birthDate)
                                  : "-",
                              style:
                                  TextStyle(color: R.color.black, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            LocaleProvider.of(context).phone_number,
                            style: context.xHeadline3
                                .copyWith(color: getIt<ITheme>().mainColor),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            widget.userAccount.phoneNumber,
                            style:
                                TextStyle(color: R.color.black, fontSize: 18),
                          )),
                        ],
                      ),
                    ),
                    //
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              LocaleProvider.of(context).email_address,
                              style: context.xHeadline3
                                  .copyWith(color: getIt<ITheme>().mainColor),
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 3,
                    child: RbioElevatedButton(
                      title: LocaleProvider.current.update_information,
                      onTap: () {
                        print("Do something!");
                      },
                    ),
                  ),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
