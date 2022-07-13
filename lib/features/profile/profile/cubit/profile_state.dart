part of 'profile_cubit.dart';

enum ProfileStatus {
  loadingProgress,
  success,
  error,
  changeUserToDefault,
  showDefaultErrorDialog,
}

class ProfileState {
  ProfileStatus status;
  bool isLoading;
  late bool isTwoFactorAuth;

  ProfileState({
    this.status = ProfileStatus.loadingProgress,
    this.isLoading = false,
    this.isTwoFactorAuth = false,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    bool? isLoading,
    bool? isTwoFactorAuth,
  }) {
    return ProfileState(
        status: status ?? this.status,
        isLoading: isLoading ?? this.isLoading,
        isTwoFactorAuth: isTwoFactorAuth ?? this.isTwoFactorAuth);
  }
}
