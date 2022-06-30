part of 'visit_detail_cubit.dart';

class VisitDetailState {
  String? laboratoryFileBytes;
  late bool pathologySelected;
  late bool radiologySelected;
  late bool laboratorySelected;
  late List<LaboratoryResponse> laboratoryResults;
  late List<PathologyResponse> pathologyResults;
  late List<RadiologyResponse> radiologyResults;
  late RbioLoadingProgress status;
  late bool isLoading;
  VisitDetailState({
    this.laboratoryFileBytes,
    this.pathologySelected = false,
    this.radiologySelected = false,
    this.laboratorySelected = false,
    this.isLoading = false,
    List<LaboratoryResponse>? laboratoryResults,
    List<PathologyResponse>? pathologyResults,
    List<RadiologyResponse>? radiologyResults,
    this.status = RbioLoadingProgress.initial,
  }) {
    this.laboratoryResults = laboratoryResults ?? [LaboratoryResponse()];
    this.pathologyResults = pathologyResults ?? [PathologyResponse()];
    this.radiologyResults = radiologyResults ?? [RadiologyResponse()];
  }

  VisitDetailState copyWith({
    String? laboratoryFileBytes,
    bool? pathologySelected,
    bool? radiologySelected,
    bool? laboratorySelected,
    List<LaboratoryResponse>? laboratoryResults,
    List<PathologyResponse>? pathologyResults,
    List<RadiologyResponse>? radiologyResults,
    RbioLoadingProgress? status,
    bool? isLoading,
  }) {
    return VisitDetailState(
        laboratoryFileBytes: laboratoryFileBytes ?? this.laboratoryFileBytes,
        pathologySelected: pathologySelected ?? this.pathologySelected,
        radiologySelected: radiologySelected ?? this.radiologySelected,
        laboratorySelected: laboratorySelected ?? this.laboratorySelected,
        laboratoryResults: laboratoryResults ?? this.laboratoryResults,
        pathologyResults: pathologyResults ?? this.pathologyResults,
        radiologyResults: radiologyResults ?? this.radiologyResults,
        status: status ?? this.status,
        isLoading: isLoading ?? this.isLoading);
  }
}
