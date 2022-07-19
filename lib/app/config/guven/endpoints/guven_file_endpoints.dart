part of '../../abstract/app_config.dart';

class GuvenFileEndpoints extends FileEndpoints {
  @override
  String get getProfilePicturePath =>
      '/file/retrieve-user-profile-image'.xBaseUrl;

  @override
  String deleteOnlineAppoFilePath(String webAppoId, String fileName) =>
      '/file/report-file-delete/$webAppoId/$fileName'.xBaseUrl;

  @override
  String get deleteProfilePicturePath => '/file/delete-profile-photo'.xBaseUrl;

  @override
  String downloadAppointmentFilePath(String id, String name) =>
      '/file/report-file-download/$id/$name'.xBaseUrl;

  @override
  String downloadAppointmentSingleFilePath(String folder, String path) =>
      '/file/download-patient-appointment-single-file/$folder/$path'.xBaseUrl;

  @override
  String get getAllFilesPath =>
      '/file/get-patient-all-appointments-file-names'.xBaseUrl;

  @override
  String getOnlineAppoFilesPath(String roomId) =>
      '/file/get-patient-appointments-file-names/$roomId'.xBaseUrl;

  @override
  String uploadFileToAppoPath(String webAppoId) =>
      '/file/upload-patient-document-for-appoinment/$webAppoId'.xBaseUrl;

  @override
  String get uploadProfilePicturePath => '/file/profil-image-upload'.xBaseUrl;

  @override
  String uploadPatientDocumentsPath(String webAppoId) =>
      '/file/upload-patient-document-for-appoinment/$webAppoId'.xBaseUrl;
}
