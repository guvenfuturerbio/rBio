import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../helper/masked_text_controller.dart';
import '../../helper/resources.dart';
import '../../models/appointment_models/Appointment.dart';
import '../../models/appointment_models/doctor.dart';
import '../../widgets/utils.dart';
import 'additional_info_view_model.dart';

class AdditionalInfo extends StatefulWidget {
  @override
  _AdditionalInfoState createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  final MaskedTextController _passportController =
      MaskedTextController(mask: '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

  final TextEditingController _phoneNumberController =
      MaskedTextController(mask: '000000000000000');
  Doctor doctor;
  Appointment appointment;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final args = ModalRoute.of(context).settings.arguments as List<Object>;
    doctor = args[1] as Doctor;
    appointment = args[0] as Appointment;
    return ChangeNotifierProvider(
      create: (context) => AdditionalInfoViewModel(
          context: context, doctor: doctor, appointment: appointment),
      child: Consumer<AdditionalInfoViewModel>(
        builder: (context, value, child) {
          return Scaffold(
              appBar: MainAppBar(
                  context: context,
                  title: TitleAppBarWhite(
                      title: LocaleProvider.current.additional_info),
                  leading: InkWell(
                      child: SvgPicture.asset(R.image.back_icon),
                      onTap: () => Navigator.of(context).pop())),
              body: Container(
                child: Container(
                  margin: EdgeInsets.all(30),
                  child: KeyboardAvoider(
                    autoScroll: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                            controller: _passportController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            style: inputTextStyle(),
                            decoration: inputImageDecoration(
                              hintText: LocaleProvider
                                  .current.identification_passport_number,
                              image: R.image.ic_user,
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: inputBoxDecoration(),
                        ),
                        Row(
                          children: [
                            Container(
                              child: CountryCodePicker(
                                onChanged: (valueTxt) {
                                  value.setPhoneCountryCode(valueTxt.dialCode);
                                },
                                favorite: ['+90', 'TR'],
                                showCountryOnly: false,
                                initialSelection: 'TR',
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                              ),
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: inputBoxDecoration(),
                            ),
                            Expanded(
                              child: Container(
                                child: TextFormField(
                                  controller: _phoneNumberController,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  style: inputTextStyle(),
                                  decoration: inputImageDecoration(
                                    hintText:
                                        LocaleProvider.current.phone_number,
                                    image: R.image.ic_phone_call_grey,
                                  ),
                                ),
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: inputBoxDecoration(),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          LocaleProvider.current.nationality,
                          style: hintStyle(),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: double.infinity,
                          child: CountryCodePicker(
                            onChanged: (valueTxt) {
                              value.setNationalityCode(valueTxt.code);
                            },
                            favorite: ['+90', 'TR'],
                            showCountryOnly: true,
                            initialSelection: 'TR',
                            showOnlyCountryWhenClosed: true,
                            alignLeft: true,
                          ),
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: inputBoxDecoration(),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        button(
                            text: LocaleProvider.current.next,
                            onPressed: () {
                              value.addAdditionalInformation(
                                  _passportController.text,
                                  _phoneNumberController.text);
                            })
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
