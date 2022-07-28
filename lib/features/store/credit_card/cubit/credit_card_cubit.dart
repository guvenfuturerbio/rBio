import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../../config/config.dart';
import '../credit_card.dart';

part 'credit_card_cubit.freezed.dart';
part 'credit_card_state.dart';

class CreditCardCubit extends Cubit<CreditCardState> {
  CreditCardCubit(
    this.userNotifier,
    this.userFacade,
    this.repository,
  ) : super(const CreditCardState());
  late final UserNotifier userNotifier;
  late final UserFacade userFacade;
  late final Repository repository;

  void toggleDistanceContract() {
    emit(
      CreditCardState(
        status: state.status,
        result: state.result.toggleDistanceContractSelected(),
      ),
    );
  }

  void toggleInformationForm() {
    emit(
      CreditCardState(
        status: state.status,
        result: state.result.toggleInformationFormAccepted(),
      ),
    );
  }

  Future<void> showDistanceSaleContract({
    required String packageName,
    required String price,
  }) async {
    final userAccount = userFacade.getUserAccount();
    String filledForm = fillAllFormFields(
      LocaleProvider.current.distance_sales_contract_context,
      (userAccount.name! + ' ' + userAccount.surname!),
      userAccount.electronicMail!,
      userAccount.phoneNumber!,
      packageName,
      (DateTime.now().toString().substring(0, 10)),
    );
    _showDialog(packageName, filledForm);
  }

  Future<void> showCancellationAndRefund({
    required String packageName,
    required String price,
  }) async {
    final userAccount = userFacade.getUserAccount();
    String filledForm = fillAllFormFields(
      LocaleProvider.current.preinformation_form_context,
      (userAccount.name! + ' ' + userAccount.surname!),
      userAccount.electronicMail!,
      userAccount.phoneNumber!,
      packageName,
      (DateTime.now().toString().substring(0, 10)),
    );
    _showDialog(packageName, filledForm);
  }

  bool checkRequiredFields({
    required String cardHolder,
    required String cardNumber,
    required String cvv,
    required String date,
  }) {
    bool isCorrect = false;
    if (state.result.isDistanceContractSelected) {
      if (state.result.isInformationFormAccepted) {
        if (cardHolder.isNotEmpty) {
          if (cardNumber.replaceAll(" ", "").length == 16) {
            if (cvv.length > 2) {
              if (date.length == 5) {
                isCorrect = true;
              } else {
                _showDialog(LocaleProvider.current.warning,
                    LocaleProvider.current.expiration_date_should_be);
              }
            } else {
              _showDialog(LocaleProvider.current.warning,
                  LocaleProvider.current.cvv_code_least_3_digit);
            }
          } else {
            _showDialog(LocaleProvider.current.warning,
                LocaleProvider.current.credit_card_lenght_should);
          }
        } else {
          _showDialog(LocaleProvider.current.warning,
              LocaleProvider.current.card_holder_cannot_empty);
        }
      } else {
        _showDialog(LocaleProvider.current.warning,
            LocaleProvider.current.check_information);
      }
    } else {
      _showDialog(LocaleProvider.current.warning,
          LocaleProvider.current.check_distance_sales_contract);
    }
    return isCorrect;
  }

  Future<void> doPackagePayment(PackagePaymentRequest packagePayment) async {
    try {
      emit(state.copyWith(status: CreditCardStatus.loadingInProgress));
      await Future.delayed(const Duration(milliseconds: 500));
      final paymentResponse = await repository.doPackagePayment(packagePayment);
      emit(
        state.copyWith(
          status: CreditCardStatus.done,
          result: state.result.copyWith(
            htmlContent: paymentResponse,
          ),
        ),
      );
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      emit(
        state.copyWith(
          status: CreditCardStatus.failure,
        ),
      );
    }
  }

  String fillAllFormFields(
    String formContext,
    String userNameAndSurname,
    String userEmail,
    String phoneNumber,
    String packageName,
    String currentDate,
  ) {
    String tmpContexHolder = Utils.instance.fillAllFields(
      formContext,
      userNameAndSurname,
      userEmail,
      phoneNumber,
      currentDate,
      packageName,
    );
    return tmpContexHolder;
  }

  void _showDialog(String title, String description) {
    emit(
      CreditCardState(
        status: CreditCardStatus.showDialog,
        result: state.result.copyWith(
          dialogTitle: title,
          dialogMessage: description,
        ),
      ),
    );
    Future.delayed(
      const Duration(milliseconds: 250),
      () {
        emit(
          CreditCardState(
            status: CreditCardStatus.initial,
            result: state.result.clearDialogParams(),
          ),
        );
      },
    );
  }
}
