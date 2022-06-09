part of 'credit_card_cubit.dart';

enum CreditCardStatus {
  initial,
  showDialog,
  loadingInProgress,
  done,
  failure,
}

@freezed
class CreditCardState with _$CreditCardState {
  const factory CreditCardState({
    @Default(CreditCardResult()) CreditCardResult result,
    @Default(CreditCardStatus.initial) CreditCardStatus status,
  }) = _CreditCardState;

  const CreditCardState._();
}

class CreditCardResult {
  final String? htmlContent;
  final String? dialogTitle;
  final String? dialogMessage;
  final bool isDistanceContractSelected;
  final bool isInformationFormAccepted;

  const CreditCardResult({
    this.htmlContent,
    this.dialogTitle,
    this.dialogMessage,
    this.isDistanceContractSelected = false,
    this.isInformationFormAccepted = false,
  });

  CreditCardResult copyWith({
    String? htmlContent,
    String? dialogTitle,
    String? dialogMessage,
    bool? isDistanceContractSelected,
    bool? isInformationFormAccepted,
  }) {
    return CreditCardResult(
      htmlContent: htmlContent ?? this.htmlContent,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      dialogMessage: dialogMessage ?? this.dialogMessage,
      isDistanceContractSelected:
          isDistanceContractSelected ?? this.isDistanceContractSelected,
      isInformationFormAccepted:
          isInformationFormAccepted ?? this.isInformationFormAccepted,
    );
  }

  CreditCardResult toggleDistanceContractSelected() {
    return CreditCardResult(
      htmlContent: htmlContent,
      isDistanceContractSelected: !isDistanceContractSelected,
      isInformationFormAccepted: isInformationFormAccepted,
      dialogTitle: dialogTitle,
      dialogMessage: dialogMessage,
    );
  }

  CreditCardResult toggleInformationFormAccepted() {
    return CreditCardResult(
      htmlContent: htmlContent,
      isDistanceContractSelected: isDistanceContractSelected,
      isInformationFormAccepted: !isInformationFormAccepted,
      dialogTitle: dialogTitle,
      dialogMessage: dialogMessage,
    );
  }

  CreditCardResult clearDialogParams() {
    return CreditCardResult(
      htmlContent: htmlContent,
      isDistanceContractSelected: isDistanceContractSelected,
      isInformationFormAccepted: isInformationFormAccepted,
      dialogTitle: null,
      dialogMessage: null,
    );
  }
}
