import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/model.dart';
import '../../constants/constants.dart';
import '../../enums/shared_preferences_keys.dart';
import '../../locator.dart';
import '../../manager/shared_preferences_manager.dart';
import '../helper/dio_helper.dart';
import '../service/local_cache_service.dart';

part '../service/doctor_service.dart';
part '../service/doctor_service_impl.dart';

class DoctorRepository {
  final DoctorApiService apiService;
  final LocalCacheService localCacheService;

  DoctorRepository({
    @required this.apiService,
    @required this.localCacheService,
  });

  Future<List<Appointment>> getAllAppointment(
          AppointmentFilter appointmentFilter) =>
      apiService.getAllAppointment(appointmentFilter);
  Future<List<DoctorPatientModel>> getMySugarPatient(
          GetMyPatientFilter getMyPatientFilter) =>
      apiService.getMySugarPatient(getMyPatientFilter);
  Future<DoctorPatientDetailModel> getMyPatientDetail(int patientId) =>
      apiService.getMyPatientDetail(patientId);
  Future<bool> updateMyPatientLimit(
          int patientId, UpdateMyPatientLimit updateMyPatientLimit) =>
      apiService.updateMyPatientLimit(patientId, updateMyPatientLimit);
  Future<List<BloodGlucose>> getMyPatientBloodGlucose(
          int patientId, GetMyPatientFilter getMyPatientFilter) =>
      apiService.getMyPatientBloodGlucose(patientId, getMyPatientFilter);
}
