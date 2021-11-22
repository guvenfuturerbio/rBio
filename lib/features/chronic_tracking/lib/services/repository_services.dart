import '../../../../core/data/imports/cronic_tracking.dart';
import '../../../../core/locator.dart';
import '../database/datamodels/glucose_data.dart';
import '../models/bg_measurement/get_blood_glucose_data_of_person.dart';
import '../models/user_profiles/person.dart';

class RepositoryServices {
  Future<List<GlucoseData>> getBloodGlucoseDataOfPerson(Person pd) async {
    try {
      GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPerson =
          new GetBloodGlucoseDataOfPerson(
              id: pd.id, start: "01.01.2011", end: "01.01.2025");
      final response = await getIt<ChronicTrackingRepository>()
          .getBloodGlucoseDataOfPerson(getBloodGlucoseDataOfPerson);
      List datum = response.datum["blood_glucose_measurement_details"];
      List<GlucoseData> glucoseDataList = [];
      glucoseDataList = datum
          .map((bgMeasurement) => GlucoseData(
              time: DateTime.parse(bgMeasurement["detail"]["occurrence_time"])
                  .millisecondsSinceEpoch,
              userId: pd.id,
              level: bgMeasurement["blood_glucose_measurement"]["value"],
              note: bgMeasurement["blood_glucose_measurement"]["value_note"],
              tag: bgMeasurement["tag"]["id"],
              manual: bgMeasurement["is_manuel"],
              measurementId: bgMeasurement["id"],
              device: 103))
          .toList();
      return glucoseDataList;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
