// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'personel_information_cubit.dart';

enum PersonelInformationStatus {
  inital,
  getPhotoFromSource,
  deletePhoto,
  success,
  errorDialog,
}

class PersonelInformationState {
  bool isLoading;
  PersonelInformationStatus? status;
  late ImageProvider<Object> getProfileImage;
  ImageSource? imageSource;
  PersonelInformationState({
    this.isLoading = false,
    this.status,
    ImageProvider<Object>? getProfileImage,
    this.imageSource,
  }) {
    this.getProfileImage = getProfileImage ?? Utils.instance.getCacheProfileImage;
  }

  PersonelInformationState copyWith({
    bool? isLoading,
    PersonelInformationStatus? status,
    ImageProvider<Object>? getProfileImage,
    ImageSource? imageSource,
  }) {
    return PersonelInformationState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      getProfileImage: getProfileImage ?? this.getProfileImage,
      imageSource: imageSource ?? this.imageSource,
    );
  }
}
