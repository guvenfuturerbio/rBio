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
  FocusNode cardHolderNameFNode;
  FocusNode cardNumberFNode;
  FocusNode cardCcvFNode;
  FocusNode cardExpirityDateFNode;

  TextEditingController _cardHolderNameController;
  MaskedTextController _cardNumberController;
  TextEditingController _expiryDateController;
  TextEditingController _cvvCodeController;

  @override
  void initState() {
    cardHolderNameFNode = FocusNode();
    cardNumberFNode = FocusNode();
    cardCcvFNode = FocusNode();
    cardExpirityDateFNode = FocusNode();

    _cardHolderNameController = TextEditingController();
    _cardNumberController = MaskedTextController(mask: '0000 0000 0000 0000');
    _expiryDateController = MaskedTextController(mask: '00/00');
    _cvvCodeController = MaskedTextController(mask: '0000');

    super.initState();
  }

  @override
  void dispose() {
    cardHolderNameFNode.dispose();
    cardNumberFNode.dispose();
    cardCcvFNode.dispose();
    cardExpirityDateFNode.dispose();

    _cardHolderNameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvCodeController.dispose();

    super.dispose();
  }

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
          return _buildScreen(value);
        },
      ),
    );
  }

  Widget _buildScreen(DoMobilePaymentScreenVm value) {
    return RbioLoadingOverlay(
      opacity: 0,
      isLoading: value.showOverlay,
      progressIndicator: RbioLoading(),
      child: DefaultTabController(
        length: 2,
        child: RbioScaffold(
          resizeToAvoidBottomInset: true,
          appbar: RbioAppBar(
            leading: RbioAppBar.defaultLeading(
              context,
              () {
                Navigator.pop(context);
              },
            ),
            title: RbioAppBar.textTitle(
              context,
              LocaleProvider.of(context).payment,
            ),
          ),
          body: _buildBody(value),
        ),
      ),
    );
  }

  Widget _buildBody(DoMobilePaymentScreenVm value) {
    return KeyboardAvoider(
      autoScroll: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              right: 25,
              left: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RbioTextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  focusNode: cardHolderNameFNode,
                  controller: _cardHolderNameController,
                  textInputAction: TextInputAction.next,
                  hintText: LocaleProvider.of(context).credit_card_holder,
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

                //
                _buildVerticalGap(),

                //
                RbioTextFormField(
                  focusNode: cardNumberFNode,
                  controller: _cardNumberController,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                  hintText: LocaleProvider.of(context).credit_card_number,
                  inputFormatters: <TextInputFormatter>[
                    TabToNextFieldTextInputFormatter(
                      context,
                      cardNumberFNode,
                      cardCcvFNode,
                    )
                  ],
                  onFieldSubmitted: (term) {
                    UtilityManager().fieldFocusChange(
                      context,
                      cardNumberFNode,
                      cardCcvFNode,
                    );
                  },
                ),

                //
                _buildVerticalGap(),

                //
                RbioTextFormField(
                  focusNode: cardCcvFNode,
                  controller: _cvvCodeController,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  hintText: LocaleProvider.of(context).credit_card_cvv,
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

                //
                _buildVerticalGap(),

                //
                RbioTextFormField(
                  focusNode: cardExpirityDateFNode,
                  controller: _expiryDateController,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  hintText: LocaleProvider.of(context).credit_card_expired_date,
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
              ],
            ),
          ),

          //
          Padding(
            padding: EdgeInsets.only(
              top: 50,
              right: 50,
              left: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Checkbox(
                        value: value.isSalesContractConfirmed,
                        onChanged: (newValue) {
                          value.toggleSalesContract();
                        },
                        activeColor: getIt<ITheme>().mainColor,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          value.showDistanceSaleContract(
                            packageName: LocaleProvider.current.online_appo,
                            price: widget?.price ?? 0.toString(),
                          );
                        },
                        child: Text(
                          LocaleProvider.of(context)
                              .accept_distance_sales_contract,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: context.xHeadline5.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Checkbox(
                        value: value.cancellationFormConfirmed,
                        onChanged: (newValue) {
                          value.toggleCancellationForm();
                        },
                        activeColor: getIt<ITheme>().mainColor,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => {
                          value.showCancellationAndRefund(
                            packageName: LocaleProvider.current.online_appo,
                            price: widget.price,
                          ),
                        },
                        child: Text(
                          LocaleProvider.of(context)
                              .cancellation_refund_conditions,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: context.xHeadline5.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                //
                RbioElevatedButton(
                  title: LocaleProvider.of(context).confirm.toUpperCase(),
                  onTap: () {
                    if (value.isSalesContractConfirmed) {
                      if (value.cancellationFormConfirmed) {
                        value.doMobilePayment(
                          ERandevuCCResponse(
                            cardNumber:
                                _cardNumberController.text.replaceAll(" ", ""),
                            cvv: _cvvCodeController.text,
                            cardHolder: _cardHolderNameController.text,
                            expirationMonth: _expiryDateController.text,
                            expirationYear: _expiryDateController.text,
                          ),
                          widget.appointmentId,
                        );
                      } else {
                        value.showGradientDialog(
                          LocaleProvider.current.warning,
                          LocaleProvider.current.check_cancellation_refund,
                        );
                      }
                    } else {
                      value.showGradientDialog(
                        LocaleProvider.current.warning,
                        LocaleProvider.current.check_distance_sales_contract,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalGap() => SizedBox(height: 8);
}
