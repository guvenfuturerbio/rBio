import '../../../../core/core.dart';

class DoctorConsultationUserModel
    extends IBaseModel<DoctorConsultationUserModel> {
  final String name;
  final String lastMessage;
  final String photoUrl;

  DoctorConsultationUserModel({
    this.name,
    this.lastMessage,
    this.photoUrl,
  });

  @override
  DoctorConsultationUserModel fromJson(Map<String, dynamic> json) =>
      DoctorConsultationUserModel(
        name: json['name'],
        lastMessage: json['lastMessage'],
        photoUrl: json['photoUrl'],
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'lastMessage': lastMessage,
        'photoUrl': photoUrl,
      };
}
