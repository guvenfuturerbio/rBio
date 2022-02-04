import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import 'credit_card_vm.dart';

class CreditCardScreen extends StatefulWidget {
  int paymentObjectCode;
  PaymentType paymentType;
  String packageName;
  String price;

  CreditCardScreen({
    Key? key,
    required this.paymentObjectCode,
    required this.paymentType,
    required this.price,
    required this.packageName,
  }) : super(key: key);

  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  LoadingDialog loadingDialog;
  bool checkedValueForPayment = false;
  bool checkValueForInformedConsent = false;
  final focus = FocusNode();

  final cardHolderNameFNode = FocusNode();
  final cardNumberFNode = FocusNode();
  final cardCcvFNode = FocusNode();
  final cardExpirityDateFNode = FocusNode();

  final TextEditingController _cardHolderNameController =
      new TextEditingController();
  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');

  @override
  Widget build(BuildContext context) {
    try {
      widget.paymentObjectCode =
          int.parse(Atom.queryParameters['paymentObjectCode'].toString());
      widget.paymentType =
          int.parse(Atom.queryParameters['paymentType']).xGetPaymenType;
      widget.packageName = Uri.decodeFull(Atom.queryParameters['packageName']);
      widget.price = Atom.queryParameters['price'];
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<CreditCardScreenVm>(
      create: (context) => CreditCardScreenVm(
        context: context,
        paymentType: widget.paymentType,
      ),
      child: Consumer<CreditCardScreenVm>(
        builder: (context, value, child) {
          return DefaultTabController(
              length: 2,
              child: RbioScaffold(
                resizeToAvoidBottomInset: true,
                appbar: RbioAppBar(
                  title: getTitleBar(context),
                ),
                body: _buildBody(context, value),
              ));
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, CreditCardScreenVm value) {
    return KeyboardAvoider(
      autoScroll: true,
      child: Column(
        children: <Widget>[
          Container(
            child: TextFormField(
              controller: _cardHolderNameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              style: Utils.instance.inputTextStyle(),
              decoration: Utils.instance
                  .inputImageDecoration(
                    hintText: LocaleProvider.current.credit_card_holder,
                    image: R.image.ic_user,
                  )
                  .copyWith(fillColor: R.color.white, filled: true),
              focusNode: cardHolderNameFNode,
              inputFormatters: <TextInputFormatter>[
                new TabToNextFieldTextInputFormatter(
                    context, cardHolderNameFNode, cardNumberFNode)
              ],
              onFieldSubmitted: (term) {
                UtilityManager().fieldFocusChange(
                    context, cardHolderNameFNode, cardNumberFNode);
              },
            ),
            margin: EdgeInsets.only(bottom: 20, top: 40),
          ),
          Container(
            child: TextFormField(
              controller: _cardNumberController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              style: Utils.instance.inputTextStyle(),
              decoration: Utils.instance
                  .inputImageDecoration(
                    hintText: LocaleProvider.current.credit_card_number,
                    image: R.image.credit_card_number,
                  )
                  .copyWith(fillColor: R.color.white, filled: true),
              focusNode: cardNumberFNode,
              inputFormatters: <TextInputFormatter>[
                new TabToNextFieldTextInputFormatter(
                    context, cardNumberFNode, cardCcvFNode)
              ],
              onFieldSubmitted: (term) {
                UtilityManager()
                    .fieldFocusChange(context, cardNumberFNode, cardCcvFNode);
              },
            ),
            margin: EdgeInsets.only(bottom: 20),
          ),
          Container(
            child: TextFormField(
              controller: _cvvCodeController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              style: Utils.instance.inputTextStyle(),
              decoration: Utils.instance
                  .inputImageDecoration(
                    hintText: LocaleProvider.current.credit_card_cvv,
                    image: R.image.ic_password,
                  )
                  .copyWith(fillColor: R.color.white, filled: true),
              focusNode: cardCcvFNode,
              inputFormatters: <TextInputFormatter>[
                new TabToNextFieldTextInputFormatter(
                    context, cardCcvFNode, cardExpirityDateFNode)
              ],
              onFieldSubmitted: (term) {
                UtilityManager().fieldFocusChange(
                    context, cardCcvFNode, cardExpirityDateFNode);
              },
            ),
            margin: EdgeInsets.only(bottom: 20),
          ),
          Container(
            child: TextFormField(
              controller: _expiryDateController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              style: Utils.instance.inputTextStyle(),
              decoration: Utils.instance
                  .inputImageDecoration(
                    hintText: LocaleProvider.current.credit_card_expired_date,
                    image: R.image.credit_calendar,
                  )
                  .copyWith(fillColor: R.color.white, filled: true),
              focusNode: cardExpirityDateFNode,
              inputFormatters: <TextInputFormatter>[
                new TabToNextFieldTextInputFormatter(
                    context, cardExpirityDateFNode, null)
              ],
              onFieldSubmitted: (term) {
                UtilityManager()
                    .fieldFocusChange(context, cardExpirityDateFNode, null);
              },
            ),
            margin: EdgeInsets.only(bottom: 5),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                child: Checkbox(
                  value: value.isDistanceContractSelected,
                  onChanged: (newValue) {
                    setState(() {
                      value.toggleDistanceContract();
                    });
                  },
                  activeColor:
                      getIt<ITheme>().mainColor, //  <-- leading Checkbox
                ),
              ),
              Expanded(
                  child: InkWell(
                onTap: () => {
                  value.showDistanceSaleContract(
                      price: widget?.price ?? "0",
                      packageName: widget?.packageName ?? "-")
                },
                child:
                    Text(LocaleProvider.current.accept_distance_sales_contract,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: context.xHeadline3.copyWith(
                          color: getIt<ITheme>().textColorSecondary,
                          decoration: TextDecoration.underline,
                        )),
              )),
            ],
          ),
          Row(children: [
            Container(
              alignment: Alignment.bottomLeft,
              child: Checkbox(
                value: value.isInformationFormAccepted,
                onChanged: (newValue) {
                  setState(() {
                    value.toggleInformationForm();
                  });
                },
                activeColor: getIt<ITheme>().mainColor,
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  value.showCancellationAndRefund(
                      packageName: widget.packageName, price: widget.price);
                },
                child: Text(
                  LocaleProvider.current.information_form,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline3.copyWith(
                    color: getIt<ITheme>().textColorSecondary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          ]),
          Container(
            child: value.progress == LoadingProgress.LOADING
                ? RbioLoading()
                : Utils.instance.button(
                    text: LocaleProvider.current.confirm.toUpperCase(),
                    onPressed: () {
                      if (value.checkRequiredFields(
                          cardNumber: _cardNumberController.text,
                          date: _expiryDateController.text,
                          cvv: _cvvCodeController.text,
                          cardHolder: _cardHolderNameController.text)) {
                        value.doPackagePayment(
                          PackagePaymentRequest(
                            cc: PaymentCCRequest(
                              cvv: _cvvCodeController.text,
                              cardNumber: _cardNumberController.text
                                  .replaceAll(" ", ""),
                              cardHolder: _cardHolderNameController.text,
                              expirationMonth:
                                  _expiryDateController.text.substring(0, 2),
                              expirationYear: "20" +
                                  _expiryDateController.text.substring(3, 5),
                            ),
                            subPackageItemId:
                                widget.paymentObjectCode.toString(),
                          ),
                        );
                      }
                    }),
            margin: EdgeInsets.only(top: 5, bottom: 20),
          )
        ],
      ),
    );
  }

  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(title: LocaleProvider.current.payment);
  }

  void showLoadingDialog(BuildContext context) async {
    await new Future.delayed(new Duration(milliseconds: 30));
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
    //builder: (BuildContext context) => WillPopScope(child:loadingDialog = LoadingDialog() , onWillPop:  () async => false,));
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }
}
