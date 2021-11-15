import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:onedosehealth/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../extension/size_extension.dart';
import '../../../generated/l10n.dart';
import '../../../helper/masked_text_controller.dart';
import '../../../helper/resources.dart';
import '../../../models/appointment_models/Appointment.dart';
import '../../../models/appointment_models/doctor.dart';
import '../../../widgets/utils.dart';
import 'credit_card_payment_view_model.dart';

class CreditCardPaymentPage extends StatefulWidget {
  @override
  _CreditCardPaymentPageState createState() => _CreditCardPaymentPageState();
}

class _CreditCardPaymentPageState extends State<CreditCardPaymentPage> {
  final TextEditingController _cardHolderNameController =
      new TextEditingController();
  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');
  Doctor doctor;
  Appointment appointment;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List<Object>;
    doctor = args[1] as Doctor;
    appointment = args[0] as Appointment;
    return Scaffold(
      appBar: CustomAppBar(
          preferredSize: Size.fromHeight(context.HEIGHT * .18),
          title: TitleAppBarWhite(title: LocaleProvider.current.payment),
          leading: InkWell(
              child: SvgPicture.asset(R.image.back_icon),
              onTap: () => Navigator.of(context).pop())),
      extendBodyBehindAppBar: true,
      body: ChangeNotifierProvider(
        create: (context) => CreditCardPaymentPageViewModel(
            context: context, appointment: appointment, doctor: doctor),
        child: Consumer<CreditCardPaymentPageViewModel>(
          builder: (context, value, child) {
            return Container(
              child: Container(
                margin: EdgeInsets.all(30),
                child: KeyboardAvoider(
                  autoScroll: true,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: context.HEIGHT * .18,
                      ),
                      Container(
                        child: TextFormField(
                          controller: _cardHolderNameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          style: inputTextStyle(),
                          decoration: inputImageDecoration(
                            hintText: LocaleProvider.current.credit_card_holder,
                            image: R.image.ic_user,
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 20, top: 40),
                        decoration: inputBoxDecoration(),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _cardNumberController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          style: inputTextStyle(),
                          decoration: inputImageDecoration(
                            hintText: LocaleProvider.current.credit_card_number,
                            image: R.image.credit_card_number,
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: inputBoxDecoration(),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _cvvCodeController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          style: inputTextStyle(),
                          decoration: inputImageDecoration(
                            hintText: LocaleProvider.current.credit_card_cvv,
                            image: R.image.ic_password,
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: inputBoxDecoration(),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _expiryDateController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          style: inputTextStyle(),
                          decoration: inputImageDecoration(
                            hintText:
                                LocaleProvider.current.credit_card_expired_date,
                            image: R.image.credit_calendar,
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: inputBoxDecoration(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      button(
                          text: LocaleProvider.current.payment,
                          onPressed: () {
                            value.setCreditCart(
                                cardHolder: _cardHolderNameController.text,
                                cardNumber: _cardNumberController.text,
                                cvv: _cvvCodeController.text,
                                expireDate: _expiryDateController.text);
                            value.checkRequiredFields();
                            if (!value.isCorrect) {
                              value.showInformationDialog(value.errorMessage);
                            } else {
                              value.doPayment();
                            }
                          })
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
