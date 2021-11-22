import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/features/mediminder/models/strip_detail_model.dart';

import '../../../features/chronic_tracking/lib/models/bg_measurement/blood_glucose_report_body.dart';
import '../../../features/chronic_tracking/lib/models/bg_measurement/blood_glucose_value_model.dart';
import '../../../features/chronic_tracking/lib/models/bg_measurement/delete_bg_measurement_request.dart';
import '../../../features/chronic_tracking/lib/models/bg_measurement/get_blood_glucose_data_of_person.dart';
import '../../../features/chronic_tracking/lib/models/bg_measurement/get_hba1c_measurement_list.dart';
import '../../../features/chronic_tracking/lib/models/bg_measurement/hospital_hba1c_measurement.dart';
import '../../../features/chronic_tracking/lib/models/bg_measurement/update_bg_measurement_request.dart';
import '../../../features/chronic_tracking/lib/models/firebase/add_firebase_body.dart';
import '../../../features/chronic_tracking/lib/models/login_response.dart';
import '../../../features/chronic_tracking/lib/models/user_profiles/person.dart';
import '../../../features/chronic_tracking/lib/models/user_profiles/save_and_retrieve_token_model.dart';
import '../../../model/shared/guven_response_model.dart';
import '../../constants/constants.dart';
import '../../enums/shared_preferences_keys.dart';
import '../../locator.dart';
import '../../manager/shared_preferences_manager.dart';
import '../helper/dio_helper.dart';
import '../service/local_cache_service.dart';

part '../repository/cronic_tracking_repository.dart';
part '../service/chronic_tracking_service.dart';
part '../service/chronic_tracking_service_impl.dart';
