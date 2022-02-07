import 'package:flutter/material.dart';

import '../../../core/data/repository/doctor_repository.dart';
import '../../../core/core.dart';
import '../../../model/model.dart';
import 'patient_notifiers.dart';

enum BgMeasurementState { loading, loaded, error }

class BgMeasurementsNotifierDoc extends ChangeNotifier {
  late BgMeasurementState state;

  List<BgMeasurementViewModel> bgMeasurements = <BgMeasurementViewModel>[];

  List<DateTime> bgMeasurementDates = <DateTime>[];
  List<BloodGlucose> bloodGlucoseList = <BloodGlucose>[];

  Future<void> fetchBgMeasurements({required int patientId}) async {
    final result = await getIt<DoctorRepository>().getMyPatientBloodGlucose(
      patientId,
      GetMyPatientFilter(end: null, start: null),
    );

    bloodGlucoseList = result;
    List<BgMeasurement> bgMeasure = result
        .map((e) => BgMeasurement(
            notes: e.bloodGlucoseMeasurement?.valueNote,
            id: e.id,
            color: Utils.instance.fetchMeasurementColor(
                measurement: int.parse(e.bloodGlucoseMeasurement?.value as String),
                criticMin: PatientNotifiers.instace.patientDetail.hypo!,
                criticMax: PatientNotifiers().patientDetail.hyper!,
                targetMax: PatientNotifiers().patientDetail.rangeMax!,
                targetMin: PatientNotifiers().patientDetail.rangeMin!),
            date: e.detail?.occurrenceTime,
            tag: e.tag?.id,
            result: e.bloodGlucoseMeasurement?.value,
            isManual: e.isManuel))
        .toList();
    bgMeasurements.clear();

    bgMeasurements =
        bgMeasure.map((e) => BgMeasurementViewModel( e)).toList();
      bgMeasurements.sort((a, b) => a.date.compareTo(b.date));

    fetchBgMeasurementsDateList(bgMeasurements);

    notifyListeners();
  }

  Future<void> fetchBgMeasurementsInDateRange(
      DateTime start, DateTime end) async {
    //final result = await MeasurementService().fetchBgMeasurements();
    List<BgMeasurement> bgMeasure = bloodGlucoseList
        .map(
          (e) => BgMeasurement(
            notes: e.bloodGlucoseMeasurement?.valueNote,
            id: e.id,
            color: Utils.instance.fetchMeasurementColor(
                measurement: int.parse(e.bloodGlucoseMeasurement?.value as String),
                criticMin: PatientNotifiers().patientDetail.hypo!,
                criticMax: PatientNotifiers().patientDetail.hyper!,
                targetMax: PatientNotifiers().patientDetail.rangeMax!,
                targetMin: PatientNotifiers().patientDetail.rangeMin!),
            date: e.detail?.occurrenceTime,
            tag: e.tag?.id,
            result: e.bloodGlucoseMeasurement?.value,
            isManual: e.isManuel,
          ),
        )
        .toList();
    bgMeasurements.clear();
    for (var e in bgMeasure) {
      if (!bgMeasurements.contains(BgMeasurementViewModel( e))) {
        DateTime measurementDate =
            BgMeasurementViewModel( e).date;
        if (measurementDate.isAfter(start) && measurementDate.isBefore(end)) {
          bgMeasurements.add(BgMeasurementViewModel( e));
        }
      }
    }
    bgMeasurements.sort((a, b) => a.date.compareTo(b.date));
    fetchBgMeasurementsDateList(bgMeasurements);
    notifyListeners();
  }

  getMoreData({required int patientId,required DateTime date}) async {
    final result = await getIt<DoctorRepository>().getMyPatientBloodGlucose(
      patientId,
      GetMyPatientFilter(end: date.toIso8601String(), start: null),
    );

    bloodGlucoseList = result;
    List<BgMeasurementViewModel> bgMeasure = bloodGlucoseList
        .map((e) => BgMeasurementViewModel(
           BgMeasurement(
                notes: e.bloodGlucoseMeasurement?.valueNote,
                id: e.id,
                color: Utils.instance.fetchMeasurementColor(
                    measurement: int.parse(e.bloodGlucoseMeasurement?.value as String),
                    criticMin: PatientNotifiers().patientDetail.hypo!,
                    criticMax: PatientNotifiers().patientDetail.hyper!,
                    targetMax: PatientNotifiers().patientDetail.rangeMax!,
                    targetMin: PatientNotifiers().patientDetail.rangeMin!),
                date: e.detail?.occurrenceTime,
                tag: e.tag?.id,
                result: e.bloodGlucoseMeasurement?.value,
                isManual: e.isManuel,
              ),
            ))
        .toList();
    bgMeasurements.addAll(bgMeasure);
    bgMeasurements.sort((a, b) => a.date.compareTo(b.date));
    fetchBgMeasurementsDateList(bgMeasurements);
    notifyListeners();
  }

  void fetchBgMeasurementsDateList(
      List<BgMeasurementViewModel> bgMeasurements) {
    bool isInclude = false;
    bgMeasurementDates.clear();
    for (var data in bgMeasurements) {
      for (var data2 in bgMeasurementDates) {
        if (DateTime(data.date.year, data.date.month, data.date.day)
            .isAtSameMomentAs(DateTime(data2.year, data2.month, data2.day))) {
          isInclude = true;
        }
      }
      if (!isInclude) {
        bgMeasurementDates
            .add(DateTime(data.date.year, data.date.month, data.date.day));
      }
      isInclude = false;
      bgMeasurementDates.sort((a, b) => a.compareTo(b));
    }
    notifyListeners();
  }
}
