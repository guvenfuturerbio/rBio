import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../../../core/core.dart';
import '../../../../app/bluetooth_v2/bluetooth_v2.dart';
import '../../../take_appointment/do_mobile_payment/iyzico_response_sms_payment_page.dart';
import '../credit_card.dart';

class CreditCardScreen extends StatelessWidget {
  const CreditCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? paymentObjectCode;
    PaymentType? paymentType;
    String? packageName;
    String? price;

    try {
      paymentObjectCode =
          int.parse(Atom.queryParameters['paymentObjectCode'].toString());
      paymentType = int.parse(Atom.queryParameters['paymentType'].toString())
          .xGetPaymenType;
      packageName =
          Uri.decodeFull(Atom.queryParameters['packageName'].toString());
      price = Atom.queryParameters['price'].toString();
    } catch (_) {
      return const RbioRouteError();
    }

    return BlocProvider<CreditCardCubit>(
      create: (context) => CreditCardCubit(getIt(), getIt()),
      child: CreditCardView(
        paymentObjectCode: paymentObjectCode,
        paymentType: paymentType,
        packageName: packageName,
        price: price,
      ),
    );
  }
}

class CreditCardView extends StatefulWidget {
  int? paymentObjectCode;
  PaymentType? paymentType;
  String? packageName;
  String? price;

  CreditCardView({
    Key? key,
    this.paymentObjectCode,
    this.paymentType,
    this.packageName,
    this.price,
  }) : super(key: key);

  @override
  _CreditCardViewState createState() => _CreditCardViewState();
}

class _CreditCardViewState extends State<CreditCardView> {
  final AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _cardHolderNameController;
  late MaskedTextController _cardNumberController;
  late TextEditingController _expiryDateController;
  late TextEditingController _cvvCodeController;

  late FocusNode cardHolderNameFNode;
  late FocusNode cardNumberFNode;
  late FocusNode cardCcvFNode;
  late FocusNode cardExpirityDateFNode;

  @override
  void initState() {
    super.initState();
    _cardHolderNameController = TextEditingController();
    _cardNumberController = MaskedTextController(mask: '0000 0000 0000 0000');
    _expiryDateController = MaskedTextController(mask: '00/00');
    _cvvCodeController = MaskedTextController(mask: '0000');
    cardHolderNameFNode = FocusNode();
    cardNumberFNode = FocusNode();
    cardCcvFNode = FocusNode();
    cardExpirityDateFNode = FocusNode();
  }

  @override
  void dispose() {
    _cardHolderNameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvCodeController.dispose();
    cardHolderNameFNode.dispose();
    cardNumberFNode.dispose();
    cardCcvFNode.dispose();
    cardExpirityDateFNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: RbioScaffold(
        resizeToAvoidBottomInset: true,
        appbar: RbioAppBar(
          title: RbioAppBar.textTitle(
            context,
            LocaleProvider.current.payment,
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<CreditCardCubit, CreditCardState>(
      listener: (context, state) {
        if (state.status == CreditCardStatus.showDialog) {
          if (state.result.dialogTitle != null &&
              state.result.dialogMessage != null) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return WarningDialog(
                  state.result.dialogTitle ?? '',
                  state.result.dialogMessage ?? '',
                  hasScrollable: true,
                );
              },
            );
          }
        } else if (state.status == CreditCardStatus.done &&
            state.result.htmlContent != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IyzicoResponseSmsPaymentScreen(
                html: state.result.htmlContent ?? '',
              ),
              settings: const RouteSettings(
                name: PagePaths.iyzicoResponseSmsPayment,
              ),
            ),
          );
        } else if (state.status == CreditCardStatus.failure) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return WarningDialog(
                LocaleProvider.of(context).warning,
                LocaleProvider.of(context).something_went_wrong,
                hasScrollable: true,
              );
            },
          );
        }
      },
      builder: (context, state) {
        return KeyboardAvoider(
          autoScroll: true,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //
                Container(
                  child: RbioTextFormField(
                    autovalidateMode: _autovalidateMode,
                    validator: (value) {
                      if (value?.isNotEmpty ?? false) {
                        return null;
                      } else {
                        return LocaleProvider.current.validation;
                      }
                    },
                    controller: _cardHolderNameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: Utils.instance
                        .inputImageDecoration(
                          suffixIconClicked: () {},
                          hintText: LocaleProvider.current.credit_card_holder,
                          image: R.image.user,
                        )
                        .copyWith(
                            fillColor: getIt<IAppConfig>().theme.white,
                            filled: true),
                    focusNode: cardHolderNameFNode,
                    inputFormatters: <TextInputFormatter>[
                      TabToNextFieldTextInputFormatter(
                        context,
                        cardHolderNameFNode,
                        cardNumberFNode,
                      ),
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager().fieldFocusChange(
                        context,
                        cardHolderNameFNode,
                        cardNumberFNode,
                      );
                    },
                  ),
                  margin: const EdgeInsets.only(bottom: 20, top: 40),
                ),

                //
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: RbioTextFormField(
                    autovalidateMode: _autovalidateMode,
                    validator: (value) {
                      if (value?.isNotEmpty ?? false) {
                        return null;
                      } else {
                        return LocaleProvider.current.validation;
                      }
                    },
                    controller: _cardNumberController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: Utils.instance
                        .inputImageDecoration(
                          suffixIconClicked: () {},
                          hintText: LocaleProvider.current.credit_card_number,
                          image: R.image.creditCardNumber,
                        )
                        .copyWith(
                          fillColor: getIt<IAppConfig>().theme.white,
                          filled: true,
                        ),
                    focusNode: cardNumberFNode,
                    inputFormatters: <TextInputFormatter>[
                      TabToNextFieldTextInputFormatter(
                        context,
                        cardNumberFNode,
                        cardCcvFNode,
                      ),
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager().fieldFocusChange(
                        context,
                        cardNumberFNode,
                        cardCcvFNode,
                      );
                    },
                  ),
                ),

                //
                Container(
                  child: RbioTextFormField(
                    autovalidateMode: _autovalidateMode,
                    validator: (value) {
                      if (value?.isNotEmpty ?? false) {
                        return null;
                      } else {
                        return LocaleProvider.current.validation;
                      }
                    },
                    controller: _cvvCodeController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: Utils.instance
                        .inputImageDecoration(
                          suffixIconClicked: () {},
                          hintText: LocaleProvider.current.credit_card_cvv,
                          image: R.image.password,
                        )
                        .copyWith(
                          fillColor: getIt<IAppConfig>().theme.white,
                          filled: true,
                        ),
                    focusNode: cardCcvFNode,
                    inputFormatters: <TextInputFormatter>[
                      TabToNextFieldTextInputFormatter(
                        context,
                        cardCcvFNode,
                        cardExpirityDateFNode,
                      ),
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager().fieldFocusChange(
                        context,
                        cardCcvFNode,
                        cardExpirityDateFNode,
                      );
                    },
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                ),

                //
                Container(
                  child: RbioTextFormField(
                    autovalidateMode: _autovalidateMode,
                    validator: (value) {
                      if (value?.isNotEmpty ?? false) {
                        return null;
                      } else {
                        return LocaleProvider.current.validation;
                      }
                    },
                    controller: _expiryDateController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    decoration: Utils.instance
                        .inputImageDecoration(
                          suffixIconClicked: () {},
                          hintText:
                              LocaleProvider.current.credit_card_expired_date,
                          image: R.image.creditCalendar,
                        )
                        .copyWith(
                          fillColor: getIt<IAppConfig>().theme.white,
                          filled: true,
                        ),
                    focusNode: cardExpirityDateFNode,
                    inputFormatters: <TextInputFormatter>[
                      TabToNextFieldTextInputFormatter(
                        context,
                        cardExpirityDateFNode,
                        null,
                      ),
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager().fieldFocusChange(
                        context,
                        cardExpirityDateFNode,
                        null,
                      );
                    },
                  ),
                  margin: const EdgeInsets.only(bottom: 5),
                ),

                //
                Row(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Checkbox(
                        value: state.result.isDistanceContractSelected,
                        onChanged: (newValue) {
                          context
                              .read<CreditCardCubit>()
                              .toggleDistanceContract();
                        },
                        activeColor: getIt<IAppConfig>().theme.mainColor,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          context
                              .read<CreditCardCubit>()
                              .showDistanceSaleContract(
                                price: widget.price!,
                                packageName: widget.packageName!,
                              );
                        },
                        child: Text(
                          LocaleProvider.current.accept_distance_sales_contract,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: context.xHeadline3.copyWith(
                            color: getIt<IAppConfig>().theme.textColorSecondary,
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
                        value: state.result.isInformationFormAccepted,
                        onChanged: (newValue) {
                          context
                              .read<CreditCardCubit>()
                              .toggleInformationForm();
                        },
                        activeColor: getIt<IAppConfig>().theme.mainColor,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          context
                              .read<CreditCardCubit>()
                              .showCancellationAndRefund(
                                packageName: widget.packageName!,
                                price: widget.price!,
                              );
                        },
                        child: Text(
                          LocaleProvider.current.information_form,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: context.xHeadline3.copyWith(
                            color: getIt<IAppConfig>().theme.textColorSecondary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                //
                Container(
                  child: state.status == CreditCardStatus.loadingInProgress
                      ? const RbioLoading()
                      : Utils.instance.button(
                          text: LocaleProvider.current.confirm.toUpperCase(),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (context
                                  .read<CreditCardCubit>()
                                  .checkRequiredFields(
                                      cardNumber: _cardNumberController.text,
                                      date: _expiryDateController.text,
                                      cvv: _cvvCodeController.text,
                                      cardHolder:
                                          _cardHolderNameController.text)) {
                                context
                                    .read<CreditCardCubit>()
                                    .doPackagePayment(
                                      PackagePaymentRequest(
                                        cc: PaymentCCRequest(
                                          cvv: _cvvCodeController.text,
                                          cardNumber: _cardNumberController.text
                                              .replaceAll(" ", ""),
                                          cardHolder:
                                              _cardHolderNameController.text,
                                          expirationMonth: _expiryDateController
                                              .text
                                              .substring(0, 2),
                                          expirationYear: "20" +
                                              _expiryDateController.text
                                                  .substring(3, 5),
                                        ),
                                        subPackageItemId:
                                            widget.paymentObjectCode.toString(),
                                      ),
                                    );
                              }
                            } else {
                              LocaleProvider.current.validation;
                            }
                          },
                        ),
                  margin: const EdgeInsets.only(top: 5, bottom: 20),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
