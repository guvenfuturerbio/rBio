import 'dart:convert';
import 'dart:io';

import '../database/datamodels/glucose_data.dart';
import '../models/bg_measurement/get_blood_glucose_data_of_person.dart';
import '../models/user_profiles/person.dart';
import '../pages/signup&login/token_provider.dart';
import 'base_provider.dart';

class RepositoryServices {
  Future<List<GlucoseData>> getBloodGlucoseDataOfPerson(Person pd) async {
    var _baseProvider = BaseProvider.create(TokenProvider().authToken);

    try {
      GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPerson =
          new GetBloodGlucoseDataOfPerson(
              id: pd.id, start: "01.01.2011", end: "01.01.2025");
      final response = await _baseProvider
          .getBloodGlucoseDataOfPerson(getBloodGlucoseDataOfPerson);

      if (response.statusCode == HttpStatus.ok) {
        var profilesBody = jsonDecode(utf8.decode(response.bodyBytes));
        if (profilesBody['is_successful']) {
          List datum =
              profilesBody["datum"]["blood_glucose_measurement_details"];
          List<GlucoseData> glucoseDataList = [];
          glucoseDataList = datum
              .map((bgMeasurement) => GlucoseData(
                  time:
                      DateTime.parse(bgMeasurement["detail"]["occurrence_time"])
                          .millisecondsSinceEpoch,
                  userId: pd.id,
                  level: bgMeasurement["blood_glucose_measurement"]["value"],
                  note: bgMeasurement["blood_glucose_measurement"]
                      ["value_note"],
                  tag: bgMeasurement["tag"]["id"],
                  manual: bgMeasurement["is_manuel"],
                  measurementId: bgMeasurement["id"],
                  device: 103))
              .toList();

          return glucoseDataList;
        } else {
          throw Exception(
              '/Measurement/get-my-blood-glucose-with-detail-and-limit-value isSuccessful:false');
        }
      } else {
        throw Exception(
            '/Measurement/get-my-blood-glucose-with-detail-and-limit-value ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
