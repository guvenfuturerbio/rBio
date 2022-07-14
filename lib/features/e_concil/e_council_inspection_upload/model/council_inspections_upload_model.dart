
/// [ECouncilInspectionUploadScreen] ekranında istenilen tetkiklerin modelidir.
class CouncilInspectionUploadModel {
  final String inspectionName;
  final bool isUploaded;

  const CouncilInspectionUploadModel({
    required this.inspectionName,
    required this.isUploaded,
  });

  CouncilInspectionUploadModel copyWith({
    String? inspectionName,
    bool? isUploaded,
  }) {
    return CouncilInspectionUploadModel(
      inspectionName: inspectionName ?? this.inspectionName,
      isUploaded: isUploaded ?? this.isUploaded,
    );
  }
}
