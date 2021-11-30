import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import 'do_mobile_payment_vm.dart';

class DoMobilePaymentScreen extends StatefulWidget {
  final AppointmentRequest appointment;
  final int appointmentId;
  final String price;

  DoMobilePaymentScreen({
    Key key,
    this.appointment,
    this.appointmentId,
    this.price,
  }) : super(key: key);

  @override
  _DoMobilePaymentScreenState createState() => _DoMobilePaymentScreenState();
}

class _DoMobilePaymentScreenState extends State<DoMobilePaymentScreen> {
  final focus = FocusNode();
  final cardHolderNameFNode = FocusNode();
  final cardNumberFNode = FocusNode();
  final cardCcvFNode = FocusNode();
  final cardExpirityDateFNode = FocusNode();

  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DoMobilePaymentScreenVm>(
      create: (context) => DoMobilePaymentScreenVm(
        appointmentRequest: widget.appointment,
        context: context,
      ),
      child: Consumer<DoMobilePaymentScreenVm>(
        builder: (
          BuildContext context,
          DoMobilePaymentScreenVm value,
          Widget child,
        ) {
          return _buildScreen(value, context);
        },
      ),
    );
  }

  Widget _buildScreen(DoMobilePaymentScreenVm value, BuildContext context) {
    return RbioLoadingOverlay(
      opacity: 0,
      isLoading: value.showOverlay,
      progressIndicator: RbioLoading(),
      child: DefaultTabController(
        length: 2,
        child: RbioScaffold(
          resizeToAvoidBottomInset: true,
          appbar: RbioAppBar(
            title: RbioAppBar.textTitle(
              context,
              LocaleProvider.of(context).payment,
            ),
          ),
          body: _buildBody(context, value),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, DoMobilePaymentScreenVm value) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: KeyboardAvoider(
        autoScroll: true,
        child: Column(
          children: <Widget>[
            //
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 40),
              child: TextFormField(
                controller: _cardHolderNameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                style: inputTextStyle(),
                decoration: inputImageDecoration(
                  hintText: LocaleProvider.of(context).credit_card_holder,
                  image: R.image.ic_user,
                ),
                focusNode: cardHolderNameFNode,
                inputFormatters: <TextInputFormatter>[
                  TabToNextFieldTextInputFormatter(
                      context, cardHolderNameFNode, cardNumberFNode)
                ],
                onFieldSubmitted: (term) {
                  UtilityManager().fieldFocusChange(
                      context, cardHolderNameFNode, cardNumberFNode);
                },
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: _cardNumberController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                style: inputTextStyle(),
                decoration: inputImageDecoration(
                  hintText: LocaleProvider.of(context).credit_card_number,
                  image: R.image.credit_card_number,
                ),
                focusNode: cardNumberFNode,
                inputFormatters: <TextInputFormatter>[
                  TabToNextFieldTextInputFormatter(
                      context, cardNumberFNode, cardCcvFNode)
                ],
                onFieldSubmitted: (term) {
                  UtilityManager()
                      .fieldFocusChange(context, cardNumberFNode, cardCcvFNode);
                },
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: _cvvCodeController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                style: inputTextStyle(),
                decoration: inputImageDecoration(
                  hintText: LocaleProvider.of(context).credit_card_cvv,
                  image: R.image.ic_password,
                ),
                focusNode: cardCcvFNode,
                inputFormatters: <TextInputFormatter>[
                  TabToNextFieldTextInputFormatter(
                      context, cardCcvFNode, cardExpirityDateFNode)
                ],
                onFieldSubmitted: (term) {
                  UtilityManager().fieldFocusChange(
                      context, cardCcvFNode, cardExpirityDateFNode);
                },
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: TextFormField(
                controller: _expiryDateController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                style: inputTextStyle(),
                decoration: inputImageDecoration(
                  hintText: LocaleProvider.of(context).credit_card_expired_date,
                  image: R.image.credit_calendar,
                ),
                focusNode: cardExpirityDateFNode,
                inputFormatters: <TextInputFormatter>[
                  TabToNextFieldTextInputFormatter(
                      context, cardExpirityDateFNode, null)
                ],
                onFieldSubmitted: (term) {
                  UtilityManager()
                      .fieldFocusChange(context, cardExpirityDateFNode, null);
                },
              ),
            ),

            //
            Row(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Checkbox(
                    value: value.isSalesContractConfirmed,
                    onChanged: (newValue) {
                      value.toggleSalesContract();
                    },
                    activeColor: R.color.blue, //  <-- leading Checkbox
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      value.showDistanceSaleContract(
                          packageName: LocaleProvider.current.online_appo,
                          price: widget?.price ?? 0.toString());
                    },
                    child: Text(
                      LocaleProvider.of(context).accept_distance_sales_contract,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: R.color.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //
            Row(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Checkbox(
                    value: value.cancellationFormConfirmed,
                    onChanged: (newValue) {
                      value.toggleCancellationForm();
                    },
                    activeColor: R.color.blue, //  <-- leading Checkbox
                  ),
                ),
                Expanded(
                  child: InkWell(
                      onTap: () => {
                            value.showCancellationAndRefund(
                                packageName: LocaleProvider.current.online_appo,
                                price: widget.price)
                          },
                      child: Text(
                          LocaleProvider.of(context)
                              .cancellation_refund_conditions,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: R.color.black,
                            decoration: TextDecoration.underline,
                          ))),
                )
              ],
            ),
            Container(
              child: button(
                  text: LocaleProvider.of(context).confirm.toUpperCase(),
                  onPressed: () {
                    if (value.isSalesContractConfirmed) {
                      if (value.cancellationFormConfirmed) {
                        value.doMobilePayment(
                          ERandevuCCResponse(
                              cardNumber: _cardNumberController.text
                                  .replaceAll(" ", ""),
                              cvv: _cvvCodeController.text,
                              cardHolder: _cardHolderNameController.text,
                              expirationMonth: _expiryDateController.text,
                              expirationYear: _expiryDateController.text),
                          widget.appointmentId,
                        );
                      } else {
                        value.showGradientDialog(LocaleProvider.current.warning,
                            LocaleProvider.current.check_cancellation_refund);
                      }
                    } else {
                      value.showGradientDialog(LocaleProvider.current.warning,
                          LocaleProvider.current.check_distance_sales_contract);
                    }
                  }),
              margin: EdgeInsets.only(top: 5, bottom: 20),
            ),
          ],
        ),
      ),
    );
  }
}
