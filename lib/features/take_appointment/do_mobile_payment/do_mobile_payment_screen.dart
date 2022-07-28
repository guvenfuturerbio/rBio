import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'appointment_request.dart';
import 'do_mobile_payment_vm.dart';
import 'e_randevu_cc_response.dart';

class DoMobilePaymentScreen extends StatefulWidget {
  final AppointmentRequest appointment;
  final int appointmentId;
  final String? price;
  final String? voucherCode;

  const DoMobilePaymentScreen({
    Key? key,
    required this.appointment,
    required this.appointmentId,
    this.price,
    this.voucherCode,
  }) : super(key: key);

  @override
  _DoMobilePaymentScreenState createState() => _DoMobilePaymentScreenState();
}

class _DoMobilePaymentScreenState extends State<DoMobilePaymentScreen> {
  late TextEditingController _cardHolderNameController;
  late MaskedTextController _cardNumberController;
  late TextEditingController _expiryDateController;
  late TextEditingController _cvvCodeController;

  late FocusNode _cardHolderNameFNode;
  late FocusNode _cardNumberFNode;
  late FocusNode _cardCcvFNode;
  late FocusNode _cardExpirityDateFNode;

  @override
  void initState() {
    _cardHolderNameController = TextEditingController();
    _cardNumberController = MaskedTextController(mask: '0000 0000 0000 0000');
    _expiryDateController = MaskedTextController(mask: '00/00');
    _cvvCodeController = MaskedTextController(mask: '0000');

    _cardHolderNameFNode = FocusNode();
    _cardNumberFNode = FocusNode();
    _cardCcvFNode = FocusNode();
    _cardExpirityDateFNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _cardHolderNameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvCodeController.dispose();

    _cardHolderNameFNode.dispose();
    _cardNumberFNode.dispose();
    _cardCcvFNode.dispose();
    _cardExpirityDateFNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DoMobilePaymentScreenVm>(
      create: (context) => DoMobilePaymentScreenVm(
        appointmentRequest: widget.appointment,
        mContext: context,
        voucherCode: widget.voucherCode ?? "",
      ),
      child: Consumer<DoMobilePaymentScreenVm>(
        builder: (
          BuildContext context,
          DoMobilePaymentScreenVm value,
          Widget? child,
        ) {
          return _buildScreen(value);
        },
      ),
    );
  }

  Widget _buildScreen(DoMobilePaymentScreenVm value) {
    return KeyboardDismissOnTap(
      child: RbioLoadingOverlay(
        opacity: 0,
        isLoading: value.showOverlay,
        progressIndicator: const RbioLoading(),
        child: DefaultTabController(
          length: 2,
          child: RbioScaffold(
            resizeToAvoidBottomInset: true,
            appbar: RbioAppBar(
              context: context,
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
      ),
    );
  }

  Widget _buildBody(DoMobilePaymentScreenVm value) {
    return RbioKeyboardActions(
      focusList: [
        _cardHolderNameFNode,
        _cardNumberFNode,
        _cardCcvFNode,
        _cardExpirityDateFNode,
      ],
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Form(
                key: value.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RbioTextFormField(
                      autovalidateMode: value.autovalidateMode,
                      validator: (value) {
                        if (value?.isNotEmpty ?? false) {
                          return null;
                        } else {
                          return LocaleProvider.current.validation;
                        }
                      },
                      decoration: Utils.instance
                          .inputImageDecoration(
                            context: context,
                            suffixIconClicked: () {},
                            hintText: LocaleProvider.current.credit_card_holder,
                            image: R.image.user,
                          )
                          .copyWith(
                            fillColor: context.xCardColor,
                            filled: true,
                          ),
                      autocorrect: false,
                      enableSuggestions: false,
                      focusNode: _cardHolderNameFNode,
                      controller: _cardHolderNameController,
                      textInputAction: TextInputAction.next,
                      inputFormatters: <TextInputFormatter>[
                        TabToNextFieldTextInputFormatter(
                          context,
                          _cardHolderNameFNode,
                          _cardNumberFNode,
                        ),
                      ],
                      onFieldSubmitted: (term) {
                        Utils.instance.fieldFocusChange(
                          context,
                          _cardHolderNameFNode,
                          _cardNumberFNode,
                        );
                      },
                    ),

                    //
                    _buildVerticalGap(),

                    //
                    RbioTextFormField(
                      autovalidateMode: value.autovalidateMode,
                      validator: (value) {
                        if (value?.isNotEmpty ?? false) {
                          return null;
                        } else {
                          return LocaleProvider.current.validation;
                        }
                      },
                      decoration: Utils.instance
                          .inputImageDecoration(
                            context: context,
                            suffixIconClicked: () {},
                            hintText: LocaleProvider.current.credit_card_number,
                            image: R.image.creditCardNumber,
                          )
                          .copyWith(
                            fillColor: context.xCardColor,
                            filled: true,
                          ),
                      focusNode: _cardNumberFNode,
                      controller: _cardNumberController,
                      enableSuggestions: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        TabToNextFieldTextInputFormatter(
                          context,
                          _cardNumberFNode,
                          _cardCcvFNode,
                        )
                      ],
                      onFieldSubmitted: (term) {
                        Utils.instance.fieldFocusChange(
                          context,
                          _cardNumberFNode,
                          _cardCcvFNode,
                        );
                      },
                    ),

                    //
                    _buildVerticalGap(),

                    //
                    RbioTextFormField(
                      autovalidateMode: value.autovalidateMode,
                      validator: (value) {
                        if (value?.isNotEmpty ?? false) {
                          return null;
                        } else {
                          return LocaleProvider.current.validation;
                        }
                      },
                      decoration: Utils.instance
                          .inputImageDecoration(
                            context: context,
                            suffixIconClicked: () {},
                            hintText: LocaleProvider.current.credit_card_cvv,
                            image: R.image.password,
                          )
                          .copyWith(
                            fillColor: context.xCardColor,
                            filled: true,
                          ),
                      focusNode: _cardCcvFNode,
                      controller: _cvvCodeController,
                      enableSuggestions: false,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: <TextInputFormatter>[
                        TabToNextFieldTextInputFormatter(
                          context,
                          _cardCcvFNode,
                          _cardExpirityDateFNode,
                        ),
                      ],
                      onFieldSubmitted: (term) {
                        Utils.instance.fieldFocusChange(
                          context,
                          _cardCcvFNode,
                          _cardExpirityDateFNode,
                        );
                      },
                    ),

                    //
                    _buildVerticalGap(),

                    //
                    RbioTextFormField(
                      autovalidateMode: value.autovalidateMode,
                      validator: (value) {
                        if (value?.isNotEmpty ?? false) {
                          return null;
                        } else {
                          return LocaleProvider.current.validation;
                        }
                      },
                      decoration: Utils.instance
                          .inputImageDecoration(
                            context: context,
                            suffixIconClicked: () {},
                            hintText:
                                LocaleProvider.current.credit_card_expired_date,
                            image: R.image.creditCalendar,
                          )
                          .copyWith(
                            fillColor: context.xCardColor,
                            filled: true,
                          ),
                      focusNode: _cardExpirityDateFNode,
                      controller: _expiryDateController,
                      enableSuggestions: false,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      inputFormatters: <TextInputFormatter>[
                        TabToNextFieldTextInputFormatter(
                          context,
                          _cardExpirityDateFNode,
                          null,
                        ),
                      ],
                      onFieldSubmitted: (term) {
                        Utils.instance.fieldFocusChange(
                          context,
                          _cardExpirityDateFNode,
                          null,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            //
            Padding(
              padding: const EdgeInsets.only(
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
                        child: RbioCheckbox(
                          value: value.isSalesContractConfirmed,
                          onChanged: (newValue) {
                            value.toggleSalesContract();
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            value.showDistanceSaleContract(
                              packageName: LocaleProvider.current.online_appo,
                              price: widget.price ?? '',
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
                        child: RbioCheckbox(
                          value: value.cancellationFormConfirmed,
                          onChanged: (newValue) {
                            value.toggleCancellationForm();
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => {
                            value.showCancellationAndRefund(
                              packageName: LocaleProvider.current.online_appo,
                              price: widget.price ?? '',
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
                      if (value.formKey?.currentState?.validate() ?? false) {
                        if (value.isSalesContractConfirmed) {
                          if (value.cancellationFormConfirmed) {
                            value.doMobilePayment(
                              ERandevuCCResponse(
                                cardNumber: _cardNumberController.text
                                    .replaceAll(" ", ""),
                                cvv: _cvvCodeController.text,
                                cardHolder: _cardHolderNameController.text,
                                expirationMonth: _expiryDateController.text,
                                expirationYear: _expiryDateController.text,
                              ),
                              widget.appointmentId,
                              widget.voucherCode,
                            );
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            ),

            //
            R.widgets.defaultBottomPadding,
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalGap() => R.widgets.hSizer8;
}
