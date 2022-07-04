// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_password_cubit.dart';

enum ChangePasswordStatus {
  initial,
  showDialog,
  done,
  failure,
}

class ChangePasswordState {
  bool showProgressOverlay = false;
  bool oldPasswordVisibility;
  bool passwordVisibility;
  bool passwordAgainVisibility;
  late bool checkLowerCase;
  late bool checkUpperCase;
  late bool checkNumeric;
  late bool checkSpecial;
  late bool checkLength;
  final String? dialogTitle;
  final String? dialogMessage;
  ChangePasswordStatus status;
  ChangePasswordState({
    this.showProgressOverlay = false,
    this.oldPasswordVisibility = false,
    this.passwordVisibility = false,
    this.passwordAgainVisibility = false,
    this.status = ChangePasswordStatus.initial,
    this.dialogMessage,
    this.dialogTitle,
    this.checkLowerCase = false,
    this.checkUpperCase = false,
    this.checkNumeric = false,
    this.checkSpecial = false,
    this.checkLength = false,
  });

  ChangePasswordState copyWith({
    bool? showProgressOverlay,
    bool? oldPasswordVisibility,
    bool? passwordVisibility,
    bool? passwordAgainVisibility,
    bool? checkLowerCase,
    bool? checkUpperCase,
    bool? checkNumeric,
    bool? checkSpecial,
    bool? checkLength,
    ChangePasswordStatus? status,
    String? dialogTitle,
    String? dialogMessage,
  }) {
    return ChangePasswordState(
      showProgressOverlay: showProgressOverlay ?? this.showProgressOverlay,
      oldPasswordVisibility:
          oldPasswordVisibility ?? this.oldPasswordVisibility,
      passwordVisibility: passwordVisibility ?? this.passwordVisibility,
      passwordAgainVisibility:
          passwordAgainVisibility ?? this.passwordAgainVisibility,
      checkLowerCase: checkLowerCase ?? this.checkLowerCase,
      checkUpperCase: checkUpperCase ?? this.checkUpperCase,
      checkNumeric: checkNumeric ?? this.checkNumeric,
      checkSpecial: checkSpecial ?? this.checkSpecial,
      checkLength: checkLength ?? this.checkLength,
      status: status ?? this.status,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      dialogMessage: dialogMessage ?? this.dialogMessage,
    );
  }
}
