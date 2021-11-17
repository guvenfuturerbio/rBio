// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class LocaleProvider {
  LocaleProvider();
  
  static LocaleProvider current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<LocaleProvider> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      LocaleProvider.current = LocaleProvider();
      
      return LocaleProvider.current;
    });
  } 

  static LocaleProvider of(BuildContext context) {
    return Localizations.of<LocaleProvider>(context, LocaleProvider);
  }

  /// `Ok`
  String get Ok {
    return Intl.message(
      'Ok',
      name: 'Ok',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `I have read, understood and approve the application consent form.`
  String get accept_application_consent_form {
    return Intl.message(
      'I have read, understood and approve the application consent form.',
      name: 'accept_application_consent_form',
      desc: '',
      args: [],
    );
  }

  /// `ACCU-CHEK Blood Glucose`
  String get accu_chek_blood_sugar {
    return Intl.message(
      'ACCU-CHEK Blood Glucose',
      name: 'accu_chek_blood_sugar',
      desc: '',
      args: [],
    );
  }

  /// `Activate`
  String get activate {
    return Intl.message(
      'Activate',
      name: 'activate',
      desc: '',
      args: [],
    );
  }

  /// `You do not have a paired device. Add a new device`
  String get add_new_device {
    return Intl.message(
      'You do not have a paired device. Add a new device',
      name: 'add_new_device',
      desc: '',
      args: [],
    );
  }

  /// `Add Photo`
  String get add_photo {
    return Intl.message(
      'Add Photo',
      name: 'add_photo',
      desc: '',
      args: [],
    );
  }

  /// `Add Reminder`
  String get add_reminder {
    return Intl.message(
      'Add Reminder',
      name: 'add_reminder',
      desc: '',
      args: [],
    );
  }

  /// `Add Strips`
  String get add_strips {
    return Intl.message(
      'Add Strips',
      name: 'add_strips',
      desc: '',
      args: [],
    );
  }

  /// `Additional Information`
  String get additional_info {
    return Intl.message(
      'Additional Information',
      name: 'additional_info',
      desc: '',
      args: [],
    );
  }

  /// `Aft.`
  String get aft {
    return Intl.message(
      'Aft.',
      name: 'aft',
      desc: '',
      args: [],
    );
  }

  /// `After`
  String get after {
    return Intl.message(
      'After',
      name: 'after',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Please allow access to camera by going to your Settings`
  String get allow_permission_camera {
    return Intl.message(
      'Please allow access to camera by going to your Settings',
      name: 'allow_permission_camera',
      desc: '',
      args: [],
    );
  }

  /// `Please allow access to photos by going to your Settings.`
  String get allow_permission_gallery {
    return Intl.message(
      'Please allow access to photos by going to your Settings.',
      name: 'allow_permission_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Apple credential error`
  String get apple_credential_error {
    return Intl.message(
      'Apple credential error',
      name: 'apple_credential_error',
      desc: '',
      args: [],
    );
  }

  /// `Within the scope of this application, no medical procedure (such as examination, diagnosis, diagnosis, treatment) is offered or promised to you. In addition to using the application, you should be examined by a physician before making any health-related decision. All responsibility for the use of the application belongs to you, the application is provided "as is" and no guarantee is given to you. The service provided to you within the scope of the application is by no means the equivalent of being examined by a physician or following your health condition one-to-one by a physician. You should consult your physician for medical diagnosis and treatment, do not delay your controls, and apply to the nearest emergency room without wasting time in any emergency. Otherwise, we will not accept any responsibility.`
  String get application_consent_form_text {
    return Intl.message(
      'Within the scope of this application, no medical procedure (such as examination, diagnosis, diagnosis, treatment) is offered or promised to you. In addition to using the application, you should be examined by a physician before making any health-related decision. All responsibility for the use of the application belongs to you, the application is provided "as is" and no guarantee is given to you. The service provided to you within the scope of the application is by no means the equivalent of being examined by a physician or following your health condition one-to-one by a physician. You should consult your physician for medical diagnosis and treatment, do not delay your controls, and apply to the nearest emergency room without wasting time in any emergency. Otherwise, we will not accept any responsibility.',
      name: 'application_consent_form_text',
      desc: '',
      args: [],
    );
  }

  /// `Appointment`
  String get appointment {
    return Intl.message(
      'Appointment',
      name: 'appointment',
      desc: '',
      args: [],
    );
  }

  /// `Appointment Details`
  String get appointment_details {
    return Intl.message(
      'Appointment Details',
      name: 'appointment_details',
      desc: '',
      args: [],
    );
  }

  /// `Appointment Files`
  String get appointment_files {
    return Intl.message(
      'Appointment Files',
      name: 'appointment_files',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get appointments {
    return Intl.message(
      'Appointments',
      name: 'appointments',
      desc: '',
      args: [],
    );
  }

  /// `To use the Application  You have to confirm the application consent form.`
  String get approve_consent_form {
    return Intl.message(
      'To use the Application  You have to confirm the application consent form.',
      name: 'approve_consent_form',
      desc: '',
      args: [],
    );
  }

  /// `as Excel`
  String get as_excel {
    return Intl.message(
      'as Excel',
      name: 'as_excel',
      desc: '',
      args: [],
    );
  }

  /// `as PDF`
  String get as_pdf {
    return Intl.message(
      'as PDF',
      name: 'as_pdf',
      desc: '',
      args: [],
    );
  }

  /// `as PNG`
  String get as_png {
    return Intl.message(
      'as PNG',
      name: 'as_png',
      desc: '',
      args: [],
    );
  }

  /// `Bef.`
  String get bef {
    return Intl.message(
      'Bef.',
      name: 'bef',
      desc: '',
      args: [],
    );
  }

  /// `Before`
  String get before {
    return Intl.message(
      'Before',
      name: 'before',
      desc: '',
      args: [],
    );
  }

  /// `Let's measure your blood sugar!`
  String get bg_measurement_time {
    return Intl.message(
      'Let\'s measure your blood sugar!',
      name: 'bg_measurement_time',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to delete paired device?`
  String get ble_delete_paired_device_approv {
    return Intl.message(
      'Are you sure want to delete paired device?',
      name: 'ble_delete_paired_device_approv',
      desc: '',
      args: [],
    );
  }

  /// `Please go to the scale for measurement...`
  String get ble_scale_sync_info {
    return Intl.message(
      'Please go to the scale for measurement...',
      name: 'ble_scale_sync_info',
      desc: '',
      args: [],
    );
  }

  /// `Your weight:`
  String get ble_scale_weight_info {
    return Intl.message(
      'Your weight:',
      name: 'ble_scale_weight_info',
      desc: '',
      args: [],
    );
  }

  /// `Measurement stabilizing...`
  String get ble_scale_stabilizing_info {
    return Intl.message(
      'Measurement stabilizing...',
      name: 'ble_scale_stabilizing_info',
      desc: '',
      args: [],
    );
  }

  /// `Weight calculating...`
  String get ble_scale_weight_calculating_info {
    return Intl.message(
      'Weight calculating...',
      name: 'ble_scale_weight_calculating_info',
      desc: '',
      args: [],
    );
  }

  /// `Scaling...`
  String get ble_scale_scaling_info {
    return Intl.message(
      'Scaling...',
      name: 'ble_scale_scaling_info',
      desc: '',
      args: [],
    );
  }

  /// `Enable location services`
  String get ble_status_location_services_disabled {
    return Intl.message(
      'Enable location services',
      name: 'ble_status_location_services_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Bluetooth is powered off on your device turn it on`
  String get ble_status_powered_off {
    return Intl.message(
      'Bluetooth is powered off on your device turn it on',
      name: 'ble_status_powered_off',
      desc: '',
      args: [],
    );
  }

  /// `Bluetooth is up and running`
  String get ble_status_ready {
    return Intl.message(
      'Bluetooth is up and running',
      name: 'ble_status_ready',
      desc: '',
      args: [],
    );
  }

  /// `Authorize the OneDose Health app to use Bluetooth and location`
  String get ble_status_unauthorized {
    return Intl.message(
      'Authorize the OneDose Health app to use Bluetooth and location',
      name: 'ble_status_unauthorized',
      desc: '',
      args: [],
    );
  }

  /// `This device does not support Bluetooth`
  String get ble_status_unsupported {
    return Intl.message(
      'This device does not support Bluetooth',
      name: 'ble_status_unsupported',
      desc: '',
      args: [],
    );
  }

  /// `Waiting to fetch Bluetooth status`
  String get ble_status_waiting {
    return Intl.message(
      'Waiting to fetch Bluetooth status',
      name: 'ble_status_waiting',
      desc: '',
      args: [],
    );
  }

  /// `Your Blood Glucose measurements have been imported.`
  String get blood_glucose_imported {
    return Intl.message(
      'Your Blood Glucose measurements have been imported.',
      name: 'blood_glucose_imported',
      desc: '',
      args: [],
    );
  }

  /// `Blood Glucose Measurement`
  String get blood_glucose_measurement {
    return Intl.message(
      'Blood Glucose Measurement',
      name: 'blood_glucose_measurement',
      desc: '',
      args: [],
    );
  }

  /// `Blood Glucose Progress`
  String get blood_glucose_progress {
    return Intl.message(
      'Blood Glucose Progress',
      name: 'blood_glucose_progress',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get btn_navigation_skip {
    return Intl.message(
      'Skip',
      name: 'btn_navigation_skip',
      desc: '',
      args: [],
    );
  }

  /// `Blood Glucose Tracking`
  String get bg_graph {
    return Intl.message(
      'Blood Glucose Tracking',
      name: 'bg_graph',
      desc: '',
      args: [],
    );
  }

  /// `Call Me`
  String get call_me {
    return Intl.message(
      'Call Me',
      name: 'call_me',
      desc: '',
      args: [],
    );
  }

  /// `Call Us`
  String get call_us {
    return Intl.message(
      'Call Us',
      name: 'call_us',
      desc: '',
      args: [],
    );
  }

  /// `Please call 444 9 494 to contact us.`
  String get call_us_message {
    return Intl.message(
      'Please call 444 9 494 to contact us.',
      name: 'call_us_message',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `We can not retrieve token for you right now!`
  String get cannot_retrieve_token {
    return Intl.message(
      'We can not retrieve token for you right now!',
      name: 'cannot_retrieve_token',
      desc: '',
      args: [],
    );
  }

  /// `Card holder cannot be left blank`
  String get card_holder_cannot_empty {
    return Intl.message(
      'Card holder cannot be left blank',
      name: 'card_holder_cannot_empty',
      desc: '',
      args: [],
    );
  }

  /// `Change Graph`
  String get change_graph_type {
    return Intl.message(
      'Change Graph',
      name: 'change_graph_type',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get chat {
    return Intl.message(
      'Help',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Check your E-Mail`
  String get check_email {
    return Intl.message(
      'Check your E-Mail',
      name: 'check_email',
      desc: '',
      args: [],
    );
  }

  /// `Check your name`
  String get check_name {
    return Intl.message(
      'Check your name',
      name: 'check_name',
      desc: '',
      args: [],
    );
  }

  /// `Hey, checkout my diabetes progess!`
  String get checkout_my_blood_glucose {
    return Intl.message(
      'Hey, checkout my diabetes progess!',
      name: 'checkout_my_blood_glucose',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get choose {
    return Intl.message(
      'Choose',
      name: 'choose',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Closest available appointments`
  String get closest_available_appointments {
    return Intl.message(
      'Closest available appointments',
      name: 'closest_available_appointments',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Connect a Glucometer`
  String get connect_glucometer {
    return Intl.message(
      'Connect a Glucometer',
      name: 'connect_glucometer',
      desc: '',
      args: [],
    );
  }

  /// `Connect a Scale Device`
  String get connect_scale {
    return Intl.message(
      'Connect a Scale Device',
      name: 'connect_scale',
      desc: '',
      args: [],
    );
  }

  /// `Consultation`
  String get consultation {
    return Intl.message(
      'Consultation',
      name: 'consultation',
      desc: '',
      args: [],
    );
  }

  /// `Contour Plus Blood Glucose`
  String get contour_plus_blood_sugar {
    return Intl.message(
      'Contour Plus Blood Glucose',
      name: 'contour_plus_blood_sugar',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get credit_card_cvv {
    return Intl.message(
      'CVV',
      name: 'credit_card_cvv',
      desc: '',
      args: [],
    );
  }

  /// `Expired Date`
  String get credit_card_expired_date {
    return Intl.message(
      'Expired Date',
      name: 'credit_card_expired_date',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder`
  String get credit_card_holder {
    return Intl.message(
      'Card Holder',
      name: 'credit_card_holder',
      desc: '',
      args: [],
    );
  }

  /// `Your credit card number must be 15 or 16 digits`
  String get credit_card_lenght_should {
    return Intl.message(
      'Your credit card number must be 15 or 16 digits',
      name: 'credit_card_lenght_should',
      desc: '',
      args: [],
    );
  }

  /// `Card number`
  String get credit_card_number {
    return Intl.message(
      'Card number',
      name: 'credit_card_number',
      desc: '',
      args: [],
    );
  }

  /// `Cvv code must be at least 3 digits`
  String get cvv_code_least_3_digit {
    return Intl.message(
      'Cvv code must be at least 3 digits',
      name: 'cvv_code_least_3_digit',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get date_of_birth {
    return Intl.message(
      'Date of Birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete selected reminder?`
  String get delete_medicine_confirm_message {
    return Intl.message(
      'Do you want to delete selected reminder?',
      name: 'delete_medicine_confirm_message',
      desc: '',
      args: [],
    );
  }

  /// `Reminders will be removed!`
  String get delete_medicine_title {
    return Intl.message(
      'Reminders will be removed!',
      name: 'delete_medicine_title',
      desc: '',
      args: [],
    );
  }

  /// `Demographic`
  String get demographic {
    return Intl.message(
      'Demographic',
      name: 'demographic',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get department {
    return Intl.message(
      'Department',
      name: 'department',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `If your Glucometer is open close your Glucometer.`
  String get device_connection_step_1 {
    return Intl.message(
      'If your Glucometer is open close your Glucometer.',
      name: 'device_connection_step_1',
      desc: '',
      args: [],
    );
  }

  /// `Press and hold the power button on the side of the device for about 3 seconds until the bluetooth sign appears.`
  String get device_connection_step_2_Contour {
    return Intl.message(
      'Press and hold the power button on the side of the device for about 3 seconds until the bluetooth sign appears.',
      name: 'device_connection_step_2_Contour',
      desc: '',
      args: [],
    );
  }

  /// `Press and hold the power button on the side of the device for about 3 seconds until the bluetooth sign appears.`
  String get device_connection_step_2_Roche {
    return Intl.message(
      'Press and hold the power button on the side of the device for about 3 seconds until the bluetooth sign appears.',
      name: 'device_connection_step_2_Roche',
      desc: '',
      args: [],
    );
  }

  /// `Select the device you want to connect to.`
  String get device_connection_step_3_Contour {
    return Intl.message(
      'Select the device you want to connect to.',
      name: 'device_connection_step_3_Contour',
      desc: '',
      args: [],
    );
  }

  /// `Select the device you want to pair with and enter the 6-digit security number found on the back of your device.`
  String get device_connection_step_3_Roche {
    return Intl.message(
      'Select the device you want to pair with and enter the 6-digit security number found on the back of your device.',
      name: 'device_connection_step_3_Roche',
      desc: '',
      args: [],
    );
  }

  /// `When you get the 'OK' text on the device, turn the device off and on again.`
  String get device_connection_step_4_Roche {
    return Intl.message(
      'When you get the \'OK\' text on the device, turn the device off and on again.',
      name: 'device_connection_step_4_Roche',
      desc: '',
      args: [],
    );
  }

  /// `Place the scale on a hard, flat surface. Stop bare feet in touch with metal surfaces, make sure that the feet are properly in contact with electrodes.`
  String get device_scale_connection_step_1_mi_scale {
    return Intl.message(
      'Place the scale on a hard, flat surface. Stop bare feet in touch with metal surfaces, make sure that the feet are properly in contact with electrodes.',
      name: 'device_scale_connection_step_1_mi_scale',
      desc: '',
      args: [],
    );
  }

  /// `When scale is activated, Select the device you want to connect to.`
  String get device_scale_connection_step_2_mi_scale {
    return Intl.message(
      'When scale is activated, Select the device you want to connect to.',
      name: 'device_scale_connection_step_2_mi_scale',
      desc: '',
      args: [],
    );
  }

  /// `When the weight indicator is stabilized, your body compositions are started to be measured. When a progress indicator below the weight indicator flashes, it means that a measurement is complete, then weigh will match your smart device.`
  String get device_scale_connection_step_3_mi_scale {
    return Intl.message(
      'When the weight indicator is stabilized, your body compositions are started to be measured. When a progress indicator below the weight indicator flashes, it means that a measurement is complete, then weigh will match your smart device.',
      name: 'device_scale_connection_step_3_mi_scale',
      desc: '',
      args: [],
    );
  }

  /// `Device Connections`
  String get device_connections {
    return Intl.message(
      'Device Connections',
      name: 'device_connections',
      desc: '',
      args: [],
    );
  }

  /// `The device is connected.`
  String get device_pairing_completed {
    return Intl.message(
      'The device is connected.',
      name: 'device_pairing_completed',
      desc: '',
      args: [],
    );
  }

  /// `Diabet Type`
  String get diabet_type {
    return Intl.message(
      'Diabet Type',
      name: 'diabet_type',
      desc: '',
      args: [],
    );
  }

  /// `Diabetes Type`
  String get diabetes_type {
    return Intl.message(
      'Diabetes Type',
      name: 'diabetes_type',
      desc: '',
      args: [],
    );
  }

  /// `Type 1`
  String get diabetes_type_1 {
    return Intl.message(
      'Type 1',
      name: 'diabetes_type_1',
      desc: '',
      args: [],
    );
  }

  /// `Type 2`
  String get diabetes_type_2 {
    return Intl.message(
      'Type 2',
      name: 'diabetes_type_2',
      desc: '',
      args: [],
    );
  }

  /// `Discard`
  String get discard {
    return Intl.message(
      'Discard',
      name: 'discard',
      desc: '',
      args: [],
    );
  }

  /// `Disease`
  String get disease {
    return Intl.message(
      'Disease',
      name: 'disease',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to continue ?`
  String get do_u_want_continue {
    return Intl.message(
      'Do you want to continue ?',
      name: 'do_u_want_continue',
      desc: '',
      args: [],
    );
  }

  /// `Doctor`
  String get doctor {
    return Intl.message(
      'Doctor',
      name: 'doctor',
      desc: '',
      args: [],
    );
  }

  /// `DONE`
  String get done {
    return Intl.message(
      'DONE',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Dose Interval`
  String get dose_interval {
    return Intl.message(
      'Dose Interval',
      name: 'dose_interval',
      desc: '',
      args: [],
    );
  }

  /// `Drug Count`
  String get drug_count {
    return Intl.message(
      'Drug Count',
      name: 'drug_count',
      desc: '',
      args: [],
    );
  }

  /// `Drug search`
  String get drug_search {
    return Intl.message(
      'Drug search',
      name: 'drug_search',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `E-Mail`
  String get email {
    return Intl.message(
      'E-Mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `This email is already in use.`
  String get email_address_already_in_use {
    return Intl.message(
      'This email is already in use.',
      name: 'email_address_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `End Angle`
  String get end_angle {
    return Intl.message(
      'End Angle',
      name: 'end_angle',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get end_time {
    return Intl.message(
      'End Time',
      name: 'end_time',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the dosage required`
  String get error_empty_dosage_name {
    return Intl.message(
      'Please enter the dosage required',
      name: 'error_empty_dosage_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the medicine's name`
  String get error_empty_medicine_name {
    return Intl.message(
      'Please enter the medicine\'s name',
      name: 'error_empty_medicine_name',
      desc: '',
      args: [],
    );
  }

  /// `Please select the reminder's interval`
  String get error_empty_time_interval {
    return Intl.message(
      'Please select the reminder\'s interval',
      name: 'error_empty_time_interval',
      desc: '',
      args: [],
    );
  }

  /// `Please select the reminder's starting time`
  String get error_empty_starting_time {
    return Intl.message(
      'Please select the reminder\'s starting time',
      name: 'error_empty_starting_time',
      desc: '',
      args: [],
    );
  }

  /// `Medicine name already exists`
  String get error_exist_medicine_name {
    return Intl.message(
      'Medicine name already exists',
      name: 'error_exist_medicine_name',
      desc: '',
      args: [],
    );
  }

  /// `Estimated HbA1c %`
  String get estimated_hb1ac {
    return Intl.message(
      'Estimated HbA1c %',
      name: 'estimated_hb1ac',
      desc: '',
      args: [],
    );
  }

  /// `Every`
  String get every {
    return Intl.message(
      'Every',
      name: 'every',
      desc: '',
      args: [],
    );
  }

  /// `Every Day`
  String get every_day {
    return Intl.message(
      'Every Day',
      name: 'every_day',
      desc: '',
      args: [],
    );
  }

  /// `MyBloodGlucoseReport.xlsx`
  String get excel_filename {
    return Intl.message(
      'MyBloodGlucoseReport.xlsx',
      name: 'excel_filename',
      desc: '',
      args: [],
    );
  }

  /// `Expiration date should be written in mm/yy format`
  String get expiration_date_should_be {
    return Intl.message(
      'Expiration date should be written in mm/yy format',
      name: 'expiration_date_should_be',
      desc: '',
      args: [],
    );
  }

  /// `Fee information`
  String get fee_information {
    return Intl.message(
      'Fee information',
      name: 'fee_information',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Files`
  String get files {
    return Intl.message(
      'Files',
      name: 'files',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all fields`
  String get fill_all_field {
    return Intl.message(
      'Please fill in all fields',
      name: 'fill_all_field',
      desc: '',
      args: [],
    );
  }

  /// `Filter graph`
  String get filter_graphs {
    return Intl.message(
      'Filter graph',
      name: 'filter_graphs',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Full`
  String get full {
    return Intl.message(
      'Full',
      name: 'full',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Online Appointment`
  String get get_online_appointment {
    return Intl.message(
      'Online Appointment',
      name: 'get_online_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Glucometer is already in use for an other account!`
  String get glucometer_in_use_for_other_account {
    return Intl.message(
      'Glucometer is already in use for an other account!',
      name: 'glucometer_in_use_for_other_account',
      desc: '',
      args: [],
    );
  }

  /// `Blood Glucose Detail`
  String get glucose_data_detail {
    return Intl.message(
      'Blood Glucose Detail',
      name: 'glucose_data_detail',
      desc: '',
      args: [],
    );
  }

  /// `hbA1c Measurement`
  String get hbA1c_measurement {
    return Intl.message(
      'hbA1c Measurement',
      name: 'hbA1c_measurement',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message(
      'High',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get hint_date {
    return Intl.message(
      'Date',
      name: 'hint_date',
      desc: '',
      args: [],
    );
  }

  /// `Doctor`
  String get hint_doctor {
    return Intl.message(
      'Doctor',
      name: 'hint_doctor',
      desc: '',
      args: [],
    );
  }

  /// `Dosage`
  String get hint_dosage {
    return Intl.message(
      'Dosage',
      name: 'hint_dosage',
      desc: '',
      args: [],
    );
  }

  /// `o'clock`
  String get hint_hour {
    return Intl.message(
      'o\'clock',
      name: 'hint_hour',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Hour`
  String get hour {
    return Intl.message(
      'Hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `How many reminders you need?`
  String get how_many_reminder_is_needed {
    return Intl.message(
      'How many reminders you need?',
      name: 'how_many_reminder_is_needed',
      desc: '',
      args: [],
    );
  }

  /// `How to get the photo?`
  String get how_to_get_photo {
    return Intl.message(
      'How to get the photo?',
      name: 'how_to_get_photo',
      desc: '',
      args: [],
    );
  }

  /// `Hungry`
  String get hungry {
    return Intl.message(
      'Hungry',
      name: 'hungry',
      desc: '',
      args: [],
    );
  }

  /// `Hyper`
  String get hyper {
    return Intl.message(
      'Hyper',
      name: 'hyper',
      desc: '',
      args: [],
    );
  }

  /// `Hypo`
  String get hypo {
    return Intl.message(
      'Hypo',
      name: 'hypo',
      desc: '',
      args: [],
    );
  }

  /// `T.C or Passport Number`
  String get identification_passport_number {
    return Intl.message(
      'T.C or Passport Number',
      name: 'identification_passport_number',
      desc: '',
      args: [],
    );
  }

  /// `Identity/Passport Number`
  String get identity_passport {
    return Intl.message(
      'Identity/Passport Number',
      name: 'identity_passport',
      desc: '',
      args: [],
    );
  }

  /// `If you want to be reminded for HbA1c measurement`
  String get if_want_to_be_reminded {
    return Intl.message(
      'If you want to be reminded for HbA1c measurement',
      name: 'if_want_to_be_reminded',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Intermittent Days`
  String get intermittent_days {
    return Intl.message(
      'Intermittent Days',
      name: 'intermittent_days',
      desc: '',
      args: [],
    );
  }

  /// `You are not authorized to login to the application`
  String get invalid_authorization {
    return Intl.message(
      'You are not authorized to login to the application',
      name: 'invalid_authorization',
      desc: '',
      args: [],
    );
  }

  /// `Irrelevant`
  String get irrelevant {
    return Intl.message(
      'Irrelevant',
      name: 'irrelevant',
      desc: '',
      args: [],
    );
  }

  /// `Payment failed`
  String get iyzico_response_0 {
    return Intl.message(
      'Payment failed',
      name: 'iyzico_response_0',
      desc: '',
      args: [],
    );
  }

  /// `Payment was successful, but hospital appointment could not be created. Please contact our hospital`
  String get iyzico_response_10 {
    return Intl.message(
      'Payment was successful, but hospital appointment could not be created. Please contact our hospital',
      name: 'iyzico_response_10',
      desc: '',
      args: [],
    );
  }

  /// `Payment was successful. Your appointment has been created successfully.`
  String get iyzico_response_13 {
    return Intl.message(
      'Payment was successful. Your appointment has been created successfully.',
      name: 'iyzico_response_13',
      desc: '',
      args: [],
    );
  }

  /// `There may be a problem with your bank. Please try again after contacting your bank.`
  String get iyzico_response_9 {
    return Intl.message(
      'There may be a problem with your bank. Please try again after contacting your bank.',
      name: 'iyzico_response_9',
      desc: '',
      args: [],
    );
  }

  /// `join`
  String get join {
    return Intl.message(
      'join',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `The doctor you made your last appointment with`
  String get last_appointment_doctor {
    return Intl.message(
      'The doctor you made your last appointment with',
      name: 'last_appointment_doctor',
      desc: '',
      args: [],
    );
  }

  /// `Last BG`
  String get last_bg {
    return Intl.message(
      'Last BG',
      name: 'last_bg',
      desc: '',
      args: [],
    );
  }

  /// `Last HbA1c`
  String get last_hba1c {
    return Intl.message(
      'Last HbA1c',
      name: 'last_hba1c',
      desc: '',
      args: [],
    );
  }

  /// `Last Measurement`
  String get last_measurement {
    return Intl.message(
      'Last Measurement',
      name: 'last_measurement',
      desc: '',
      args: [],
    );
  }

  /// `Last 1 Day`
  String get last_one_day {
    return Intl.message(
      'Last 1 Day',
      name: 'last_one_day',
      desc: '',
      args: [],
    );
  }

  /// `Last 1 Hour`
  String get last_one_hour {
    return Intl.message(
      'Last 1 Hour',
      name: 'last_one_hour',
      desc: '',
      args: [],
    );
  }

  /// `Last 1 Month`
  String get last_one_month {
    return Intl.message(
      'Last 1 Month',
      name: 'last_one_month',
      desc: '',
      args: [],
    );
  }

  /// `Last 1 Week`
  String get last_one_week {
    return Intl.message(
      'Last 1 Week',
      name: 'last_one_week',
      desc: '',
      args: [],
    );
  }

  /// `Last Test Value: `
  String get last_result {
    return Intl.message(
      'Last Test Value: ',
      name: 'last_result',
      desc: '',
      args: [],
    );
  }

  /// `Last Test Date: `
  String get last_test_date {
    return Intl.message(
      'Last Test Date: ',
      name: 'last_test_date',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `We are sorry, our services currently unavailable.`
  String get login_error_message {
    return Intl.message(
      'We are sorry, our services currently unavailable.',
      name: 'login_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `Make an Online Appointment`
  String get make_an_online {
    return Intl.message(
      'Make an Online Appointment',
      name: 'make_an_online',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Max Range: `
  String get max_range {
    return Intl.message(
      'Max Range: ',
      name: 'max_range',
      desc: '',
      args: [],
    );
  }

  /// `Meal`
  String get meal {
    return Intl.message(
      'Meal',
      name: 'meal',
      desc: '',
      args: [],
    );
  }

  /// `Medication Reminder`
  String get medication_reminder {
    return Intl.message(
      'Medication Reminder',
      name: 'medication_reminder',
      desc: '',
      args: [],
    );
  }

  /// `Daily count`
  String get medicine_daily_count {
    return Intl.message(
      'Daily count',
      name: 'medicine_daily_count',
      desc: '',
      args: [],
    );
  }

  /// `Define daily count`
  String get medicine_daily_count_error_message {
    return Intl.message(
      'Define daily count',
      name: 'medicine_daily_count_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Define drug count`
  String get medicine_drug_count_error_message {
    return Intl.message(
      'Define drug count',
      name: 'medicine_drug_count_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Finishing date of reminder:`
  String get medicine_end_date {
    return Intl.message(
      'Finishing date of reminder:',
      name: 'medicine_end_date',
      desc: '',
      args: [],
    );
  }

  /// `How many drugs you have?`
  String get medicine_how_many_drugs_message {
    return Intl.message(
      'How many drugs you have?',
      name: 'medicine_how_many_drugs_message',
      desc: '',
      args: [],
    );
  }

  /// `How many times a day?`
  String get medicine_how_often_daily_message {
    return Intl.message(
      'How many times a day?',
      name: 'medicine_how_often_daily_message',
      desc: '',
      args: [],
    );
  }

  /// `How many days for per usage?`
  String get medicine_how_often_intermittent_daily_message {
    return Intl.message(
      'How many days for per usage?',
      name: 'medicine_how_often_intermittent_daily_message',
      desc: '',
      args: [],
    );
  }

  /// `How often you need to use the reminder?`
  String get medicine_how_often_message {
    return Intl.message(
      'How often you need to use the reminder?',
      name: 'medicine_how_often_message',
      desc: '',
      args: [],
    );
  }

  /// `Interval`
  String get medicine_intermittent_daily_count {
    return Intl.message(
      'Interval',
      name: 'medicine_intermittent_daily_count',
      desc: '',
      args: [],
    );
  }

  /// `Determine interval between usages`
  String get medicine_intermittent_selection_error {
    return Intl.message(
      'Determine interval between usages',
      name: 'medicine_intermittent_selection_error',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Name`
  String get medicine_name {
    return Intl.message(
      'Medicine Name',
      name: 'medicine_name',
      desc: '',
      args: [],
    );
  }

  /// `How many days before the drug will run out?`
  String get medicine_remind_me_drug_end_message {
    return Intl.message(
      'How many days before the drug will run out?',
      name: 'medicine_remind_me_drug_end_message',
      desc: '',
      args: [],
    );
  }

  /// `Remind ahead of days`
  String get medicine_reminder_day_prior {
    return Intl.message(
      'Remind ahead of days',
      name: 'medicine_reminder_day_prior',
      desc: '',
      args: [],
    );
  }

  /// `Select at least 1 day of the week`
  String get medicine_specific_days_no_day_error {
    return Intl.message(
      'Select at least 1 day of the week',
      name: 'medicine_specific_days_no_day_error',
      desc: '',
      args: [],
    );
  }

  /// `Start date of reminder:`
  String get medicine_start_date {
    return Intl.message(
      'Start date of reminder:',
      name: 'medicine_start_date',
      desc: '',
      args: [],
    );
  }

  /// `Determine time and dosage`
  String get medicine_time_and_dose_message {
    return Intl.message(
      'Determine time and dosage',
      name: 'medicine_time_and_dose_message',
      desc: '',
      args: [],
    );
  }

  /// `time has come`
  String get medicine_time_has_come {
    return Intl.message(
      'time has come',
      name: 'medicine_time_has_come',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Type`
  String get medicine_type {
    return Intl.message(
      'Medicine Type',
      name: 'medicine_type',
      desc: '',
      args: [],
    );
  }

  /// `Bottle`
  String get medicine_type_bottle {
    return Intl.message(
      'Bottle',
      name: 'medicine_type_bottle',
      desc: '',
      args: [],
    );
  }

  /// `Pill`
  String get medicine_type_pill {
    return Intl.message(
      'Pill',
      name: 'medicine_type_pill',
      desc: '',
      args: [],
    );
  }

  /// `Syringe`
  String get medicine_type_syringe {
    return Intl.message(
      'Syringe',
      name: 'medicine_type_syringe',
      desc: '',
      args: [],
    );
  }

  /// `Tablet`
  String get medicine_type_tablet {
    return Intl.message(
      'Tablet',
      name: 'medicine_type_tablet',
      desc: '',
      args: [],
    );
  }

  /// `What is the usage type for reminder?`
  String get medicine_usage_type_message {
    return Intl.message(
      'What is the usage type for reminder?',
      name: 'medicine_usage_type_message',
      desc: '',
      args: [],
    );
  }

  /// `Medicines`
  String get medicines {
    return Intl.message(
      'Medicines',
      name: 'medicines',
      desc: '',
      args: [],
    );
  }

  /// `Add New Mediminder`
  String get mediminder_add_new {
    return Intl.message(
      'Add New Mediminder',
      name: 'mediminder_add_new',
      desc: '',
      args: [],
    );
  }

  /// `Mediminder Details`
  String get mediminder_details {
    return Intl.message(
      'Mediminder Details',
      name: 'mediminder_details',
      desc: '',
      args: [],
    );
  }

  /// `Delete Mediminder`
  String get mediminder_delete {
    return Intl.message(
      'Delete Mediminder',
      name: 'mediminder_delete',
      desc: '',
      args: [],
    );
  }

  /// `Delete this Mediminder?`
  String get mediminder_delete_approv {
    return Intl.message(
      'Delete this Mediminder?',
      name: 'mediminder_delete_approv',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `Mi Scale`
  String get mi_scale {
    return Intl.message(
      'Mi Scale',
      name: 'mi_scale',
      desc: '',
      args: [],
    );
  }

  /// `Min Range: `
  String get min_range {
    return Intl.message(
      'Min Range: ',
      name: 'min_range',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `My Reminders`
  String get my_medicines {
    return Intl.message(
      'My Reminders',
      name: 'my_medicines',
      desc: '',
      args: [],
    );
  }

  /// `Name and Surname`
  String get name_and_surname {
    return Intl.message(
      'Name and Surname',
      name: 'name_and_surname',
      desc: '',
      args: [],
    );
  }

  /// `Name Surname`
  String get name_surname {
    return Intl.message(
      'Name Surname',
      name: 'name_surname',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nationality {
    return Intl.message(
      'Nationality',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// `You have never strip used so far`
  String get never_used_strip {
    return Intl.message(
      'You have never strip used so far',
      name: 'never_used_strip',
      desc: '',
      args: [],
    );
  }

  /// `NEW APPOINTMENT`
  String get new_appointment {
    return Intl.message(
      'NEW APPOINTMENT',
      name: 'new_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to create a new profile?`
  String get new_profile_addition {
    return Intl.message(
      'Do you want to create a new profile?',
      name: 'new_profile_addition',
      desc: '',
      args: [],
    );
  }

  /// `You need to switch to a new profile to pair more than 1 device.`
  String get new_profile_for_new_glucometer_message {
    return Intl.message(
      'You need to switch to a new profile to pair more than 1 device.',
      name: 'new_profile_for_new_glucometer_message',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `No suitable spaces were found for the selected dates. Would you like us to call you?`
  String get no_appo_call_us {
    return Intl.message(
      'No suitable spaces were found for the selected dates. Would you like us to call you?',
      name: 'no_appo_call_us',
      desc: '',
      args: [],
    );
  }

  /// `You have no appointments for the selected date`
  String get no_appointment {
    return Intl.message(
      'You have no appointments for the selected date',
      name: 'no_appointment',
      desc: '',
      args: [],
    );
  }

  /// `You have no last measurement`
  String get no_measurement {
    return Intl.message(
      'You have no last measurement',
      name: 'no_measurement',
      desc: '',
      args: [],
    );
  }

  /// `Try again after making sure there is no problem with your internet connection`
  String get no_network {
    return Intl.message(
      'Try again after making sure there is no problem with your internet connection',
      name: 'no_network',
      desc: '',
      args: [],
    );
  }

  /// `Please check the internet connection`
  String get no_network_connection {
    return Intl.message(
      'Please check the internet connection',
      name: 'no_network_connection',
      desc: '',
      args: [],
    );
  }

  /// `No suitable appointment was found for the selected date`
  String get no_suitable_appo {
    return Intl.message(
      'No suitable appointment was found for the selected date',
      name: 'no_suitable_appo',
      desc: '',
      args: [],
    );
  }

  /// `Non-Diabetes`
  String get non_diabetes {
    return Intl.message(
      'Non-Diabetes',
      name: 'non_diabetes',
      desc: '',
      args: [],
    );
  }

  /// `Non-Smoker`
  String get non_smoker {
    return Intl.message(
      'Non-Smoker',
      name: 'non_smoker',
      desc: '',
      args: [],
    );
  }

  /// `Normal Range`
  String get normal_range {
    return Intl.message(
      'Normal Range',
      name: 'normal_range',
      desc: '',
      args: [],
    );
  }

  /// `Not Specified`
  String get not_specified {
    return Intl.message(
      'Not Specified',
      name: 'not_specified',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `OAuth credential error`
  String get oauth_credential_error {
    return Intl.message(
      'OAuth credential error',
      name: 'oauth_credential_error',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Omron Blood Pressure Arm`
  String get omron_blood_pressure_arm {
    return Intl.message(
      'Omron Blood Pressure Arm',
      name: 'omron_blood_pressure_arm',
      desc: '',
      args: [],
    );
  }

  /// `Omron Blood Pressure Wrist`
  String get omron_blood_pressure_wrist {
    return Intl.message(
      'Omron Blood Pressure Wrist',
      name: 'omron_blood_pressure_wrist',
      desc: '',
      args: [],
    );
  }

  /// `Omron Scale`
  String get omron_scale {
    return Intl.message(
      'Omron Scale',
      name: 'omron_scale',
      desc: '',
      args: [],
    );
  }

  /// `You can use 1 glucometer for a single profile only.`
  String get one_glucometer_one_profile_message {
    return Intl.message(
      'You can use 1 glucometer for a single profile only.',
      name: 'one_glucometer_one_profile_message',
      desc: '',
      args: [],
    );
  }

  /// `One time a day`
  String get one_time_a_day {
    return Intl.message(
      'One time a day',
      name: 'one_time_a_day',
      desc: '',
      args: [],
    );
  }

  /// `Oth.`
  String get oth {
    return Intl.message(
      'Oth.',
      name: 'oth',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `The device has been successfully paired`
  String get pair_successful {
    return Intl.message(
      'The device has been successfully paired',
      name: 'pair_successful',
      desc: '',
      args: [],
    );
  }

  /// `Paired Devices`
  String get paired_devices {
    return Intl.message(
      'Paired Devices',
      name: 'paired_devices',
      desc: '',
      args: [],
    );
  }

  /// `Paired Devices successfully deleted`
  String get paired_devices_deleted {
    return Intl.message(
      'Paired Devices successfully deleted',
      name: 'paired_devices_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Your password must include at least 6 characters`
  String get password_at_least_6 {
    return Intl.message(
      'Your password must include at least 6 characters',
      name: 'password_at_least_6',
      desc: '',
      args: [],
    );
  }

  /// `Patients`
  String get patients {
    return Intl.message(
      'Patients',
      name: 'patients',
      desc: '',
      args: [],
    );
  }

  /// `Pairing`
  String get pairing {
    return Intl.message(
      'Pairing',
      name: 'pairing',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `MyBloodGlucoseReport.pdf`
  String get pdf_filename {
    return Intl.message(
      'MyBloodGlucoseReport.pdf',
      name: 'pdf_filename',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Pick`
  String get pick {
    return Intl.message(
      'Pick',
      name: 'pick',
      desc: '',
      args: [],
    );
  }

  /// `Pick a photo option`
  String get pick_a_photo_option {
    return Intl.message(
      'Pick a photo option',
      name: 'pick_a_photo_option',
      desc: '',
      args: [],
    );
  }

  /// `Pick Time`
  String get pick_time {
    return Intl.message(
      'Pick Time',
      name: 'pick_time',
      desc: '',
      args: [],
    );
  }

  /// `piece`
  String get piece {
    return Intl.message(
      'piece',
      name: 'piece',
      desc: '',
      args: [],
    );
  }

  /// `https://app.guven.com.tr/kvkk_en.html`
  String get policy_url {
    return Intl.message(
      'https://app.guven.com.tr/kvkk_en.html',
      name: 'policy_url',
      desc: '',
      args: [],
    );
  }

  /// `Premium`
  String get premium {
    return Intl.message(
      'Premium',
      name: 'premium',
      desc: '',
      args: [],
    );
  }

  /// `Press + to add a Reminder`
  String get press_plus_to_add_medicine {
    return Intl.message(
      'Press + to add a Reminder',
      name: 'press_plus_to_add_medicine',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Your profile picture will be updated with the selected one. Do you confirm?`
  String get profile_picture_change {
    return Intl.message(
      'Your profile picture will be updated with the selected one. Do you confirm?',
      name: 'profile_picture_change',
      desc: '',
      args: [],
    );
  }

  /// `Profile picture will be deleted. Do you confirm?`
  String get profile_picture_delete {
    return Intl.message(
      'Profile picture will be deleted. Do you confirm?',
      name: 'profile_picture_delete',
      desc: '',
      args: [],
    );
  }

  /// `Profile Picture`
  String get profile_picture_name {
    return Intl.message(
      'Profile Picture',
      name: 'profile_picture_name',
      desc: '',
      args: [],
    );
  }

  /// `Profiles`
  String get profiles {
    return Intl.message(
      'Profiles',
      name: 'profiles',
      desc: '',
      args: [],
    );
  }

  /// `Remind me, every`
  String get remind_me_every {
    return Intl.message(
      'Remind me, every',
      name: 'remind_me_every',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder {
    return Intl.message(
      'Reminder',
      name: 'reminder',
      desc: '',
      args: [],
    );
  }

  /// `Reminder Date: `
  String get reminder_date {
    return Intl.message(
      'Reminder Date: ',
      name: 'reminder_date',
      desc: '',
      args: [],
    );
  }

  /// `Reminder name`
  String get reminder_name {
    return Intl.message(
      'Reminder name',
      name: 'reminder_name',
      desc: '',
      args: [],
    );
  }

  /// `Determine time of the reminder`
  String get reminder_time_selection {
    return Intl.message(
      'Determine time of the reminder',
      name: 'reminder_time_selection',
      desc: '',
      args: [],
    );
  }

  /// `Reminders`
  String get reminders {
    return Intl.message(
      'Reminders',
      name: 'reminders',
      desc: '',
      args: [],
    );
  }

  /// `Remove Strips`
  String get remove_strips {
    return Intl.message(
      'Remove Strips',
      name: 'remove_strips',
      desc: '',
      args: [],
    );
  }

  /// `Reset Filter Values`
  String get reset_filter_value {
    return Intl.message(
      'Reset Filter Values',
      name: 'reset_filter_value',
      desc: '',
      args: [],
    );
  }

  /// `are required`
  String get required_area {
    return Intl.message(
      'are required',
      name: 'required_area',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `BMI`
  String get scale_data_bmi {
    return Intl.message(
      'BMI',
      name: 'scale_data_bmi',
      desc: '',
      args: [],
    );
  }

  /// `Body Fat`
  String get scale_data_body_fat {
    return Intl.message(
      'Body Fat',
      name: 'scale_data_body_fat',
      desc: '',
      args: [],
    );
  }

  /// `Bone Mass`
  String get scale_data_bone_mass {
    return Intl.message(
      'Bone Mass',
      name: 'scale_data_bone_mass',
      desc: '',
      args: [],
    );
  }

  /// `Muscle`
  String get scale_data_muscle {
    return Intl.message(
      'Muscle',
      name: 'scale_data_muscle',
      desc: '',
      args: [],
    );
  }

  /// `Visceral Fat`
  String get scale_data_visceral_fat {
    return Intl.message(
      'Visceral Fat',
      name: 'scale_data_visceral_fat',
      desc: '',
      args: [],
    );
  }

  /// `Water`
  String get scale_data_water {
    return Intl.message(
      'Water',
      name: 'scale_data_water',
      desc: '',
      args: [],
    );
  }

  /// `Body values progress`
  String get scale_progress {
    return Intl.message(
      'Body values progress',
      name: 'scale_progress',
      desc: '',
      args: [],
    );
  }

  /// `Body Scale Tracking`
  String get scale_graph {
    return Intl.message(
      'Body Scale Tracking',
      name: 'scale_graph',
      desc: '',
      args: [],
    );
  }

  /// `Select an Interval`
  String get select_interval {
    return Intl.message(
      'Select an Interval',
      name: 'select_interval',
      desc: '',
      args: [],
    );
  }

  /// `App Language`
  String get select_language {
    return Intl.message(
      'App Language',
      name: 'select_language',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Send Message`
  String get send_message {
    return Intl.message(
      'Send Message',
      name: 'send_message',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get show {
    return Intl.message(
      'Show',
      name: 'show',
      desc: '',
      args: [],
    );
  }

  /// `SIGN IN`
  String get sign_in {
    return Intl.message(
      'SIGN IN',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Apple`
  String get sign_with_apple {
    return Intl.message(
      'Sign in with Apple',
      name: 'sign_with_apple',
      desc: '',
      args: [],
    );
  }

  /// `Sign in/Sign up with e-mail`
  String get sign_with_email {
    return Intl.message(
      'Sign in/Sign up with e-mail',
      name: 'sign_with_email',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Facebook`
  String get sign_with_facebook {
    return Intl.message(
      'Sign in with Facebook',
      name: 'sign_with_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get sign_with_google {
    return Intl.message(
      'Sign in with Google',
      name: 'sign_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Single Day`
  String get single_day {
    return Intl.message(
      'Single Day',
      name: 'single_day',
      desc: '',
      args: [],
    );
  }

  /// `Smoker`
  String get smoker {
    return Intl.message(
      'Smoker',
      name: 'smoker',
      desc: '',
      args: [],
    );
  }

  /// `Smoker Type`
  String get smoker_type {
    return Intl.message(
      'Smoker Type',
      name: 'smoker_type',
      desc: '',
      args: [],
    );
  }

  /// `Smokes Occasionally`
  String get smokes_occasionally {
    return Intl.message(
      'Smokes Occasionally',
      name: 'smokes_occasionally',
      desc: '',
      args: [],
    );
  }

  /// `Smokes Often`
  String get smokes_often {
    return Intl.message(
      'Smokes Often',
      name: 'smokes_often',
      desc: '',
      args: [],
    );
  }

  /// `Smoking`
  String get smoking {
    return Intl.message(
      'Smoking',
      name: 'smoking',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, we are currently unable to complete your transaction. Please try again later`
  String get sorry_dont_transaction {
    return Intl.message(
      'Sorry, we are currently unable to complete your transaction. Please try again later',
      name: 'sorry_dont_transaction',
      desc: '',
      args: [],
    );
  }

  /// `Specific`
  String get specific {
    return Intl.message(
      'Specific',
      name: 'specific',
      desc: '',
      args: [],
    );
  }

  /// `Specific Days`
  String get specific_days {
    return Intl.message(
      'Specific Days',
      name: 'specific_days',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get start_time {
    return Intl.message(
      'Start Time',
      name: 'start_time',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get stop {
    return Intl.message(
      'Stop',
      name: 'stop',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get store {
    return Intl.message(
      'Store',
      name: 'store',
      desc: '',
      args: [],
    );
  }

  /// `We have detected %1$ readings. Tap to remove %2$ strips from your strips.`
  String get strip_detected_message {
    return Intl.message(
      'We have detected %1\$ readings. Tap to remove %2\$ strips from your strips.',
      name: 'strip_detected_message',
      desc: '',
      args: [],
    );
  }

  /// `Number of Strips`
  String get strip_number {
    return Intl.message(
      'Number of Strips',
      name: 'strip_number',
      desc: '',
      args: [],
    );
  }

  /// `Strip number decreases automatically when the blood glucose measurement is added. In cases such as loss or breakage, you need to reduce it manually`
  String get strip_page_info_message {
    return Intl.message(
      'Strip number decreases automatically when the blood glucose measurement is added. In cases such as loss or breakage, you need to reduce it manually',
      name: 'strip_page_info_message',
      desc: '',
      args: [],
    );
  }

  /// `Strip Tracker`
  String get strip_tracker {
    return Intl.message(
      'Strip Tracker',
      name: 'strip_tracker',
      desc: '',
      args: [],
    );
  }

  /// `Strip Tracking`
  String get strip_tracking {
    return Intl.message(
      'Strip Tracking',
      name: 'strip_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Strips`
  String get strips {
    return Intl.message(
      'Strips',
      name: 'strips',
      desc: '',
      args: [],
    );
  }

  /// `Strips left.`
  String get strips_left {
    return Intl.message(
      'Strips left.',
      name: 'strips_left',
      desc: '',
      args: [],
    );
  }

  /// `You have used %1$ strips so far`
  String get strips_used {
    return Intl.message(
      'You have used %1\$ strips so far',
      name: 'strips_used',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been successfully created`
  String get succefully_created_account {
    return Intl.message(
      'Your account has been successfully created',
      name: 'succefully_created_account',
      desc: '',
      args: [],
    );
  }

  /// `Your new password has been successfully created`
  String get succefully_created_pass {
    return Intl.message(
      'Your new password has been successfully created',
      name: 'succefully_created_pass',
      desc: '',
      args: [],
    );
  }

  /// `Supported Devices`
  String get supported_devices {
    return Intl.message(
      'Supported Devices',
      name: 'supported_devices',
      desc: '',
      args: [],
    );
  }

  /// `We're currently sync your data please wait...`
  String get sync_data {
    return Intl.message(
      'We\'re currently sync your data please wait...',
      name: 'sync_data',
      desc: '',
      args: [],
    );
  }

  /// `Target`
  String get target {
    return Intl.message(
      'Target',
      name: 'target',
      desc: '',
      args: [],
    );
  }

  /// `https://tawk.to/chat/5cb46145c1fe2560f3fee0c1/1ehjtkv10`
  String get tawkto_url {
    return Intl.message(
      'https://tawk.to/chat/5cb46145c1fe2560f3fee0c1/1ehjtkv10',
      name: 'tawkto_url',
      desc: '',
      args: [],
    );
  }

  /// `Test Result`
  String get test_result {
    return Intl.message(
      'Test Result',
      name: 'test_result',
      desc: '',
      args: [],
    );
  }

  /// `The doctor you chose`
  String get the_doctor_u_chose {
    return Intl.message(
      'The doctor you chose',
      name: 'the_doctor_u_chose',
      desc: '',
      args: [],
    );
  }

  /// `There are no reminders`
  String get there_are_no_reminders {
    return Intl.message(
      'There are no reminders',
      name: 'there_are_no_reminders',
      desc: '',
      args: [],
    );
  }

  /// `3 Months`
  String get three_months {
    return Intl.message(
      '3 Months',
      name: 'three_months',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `It's time to measure Hba1c`
  String get time_hba1c {
    return Intl.message(
      'It\'s time to measure Hba1c',
      name: 'time_hba1c',
      desc: '',
      args: [],
    );
  }

  /// `It's time to take medicine`
  String get time_take_medicine {
    return Intl.message(
      'It\'s time to take medicine',
      name: 'time_take_medicine',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `2 Week`
  String get two_Week {
    return Intl.message(
      '2 Week',
      name: 'two_Week',
      desc: '',
      args: [],
    );
  }

  /// `2 weeks`
  String get two_week {
    return Intl.message(
      '2 weeks',
      name: 'two_week',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Unspecified`
  String get unspecified {
    return Intl.message(
      'Unspecified',
      name: 'unspecified',
      desc: '',
      args: [],
    );
  }

  /// `Use Voucher`
  String get use_voucher {
    return Intl.message(
      'Use Voucher',
      name: 'use_voucher',
      desc: '',
      args: [],
    );
  }

  /// `User could not be created`
  String get user_create_error {
    return Intl.message(
      'User could not be created',
      name: 'user_create_error',
      desc: '',
      args: [],
    );
  }

  /// `User ID`
  String get user_id {
    return Intl.message(
      'User ID',
      name: 'user_id',
      desc: '',
      args: [],
    );
  }

  /// `User login information cannot be left blank`
  String get user_login_cannot_blank {
    return Intl.message(
      'User login information cannot be left blank',
      name: 'user_login_cannot_blank',
      desc: '',
      args: [],
    );
  }

  /// `User with this email doesn't exist.`
  String get user_with_email_does_not_exists {
    return Intl.message(
      'User with this email doesn\'t exist.',
      name: 'user_with_email_does_not_exists',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your email.`
  String get verify_email_error {
    return Intl.message(
      'Please verify your email.',
      name: 'verify_email_error',
      desc: '',
      args: [],
    );
  }

  /// `Very High`
  String get very_high {
    return Intl.message(
      'Very High',
      name: 'very_high',
      desc: '',
      args: [],
    );
  }

  /// `Very Low`
  String get very_low {
    return Intl.message(
      'Very Low',
      name: 'very_low',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get view_details {
    return Intl.message(
      'View Details',
      name: 'view_details',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `We're currently facing unexpected issue. Please try again later...`
  String get we_have_an_error {
    return Intl.message(
      'We\'re currently facing unexpected issue. Please try again later...',
      name: 'we_have_an_error',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get weekdays_friday {
    return Intl.message(
      'Friday',
      name: 'weekdays_friday',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get weekdays_monday {
    return Intl.message(
      'Monday',
      name: 'weekdays_monday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get weekdays_saturday {
    return Intl.message(
      'Saturday',
      name: 'weekdays_saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get weekdays_sunday {
    return Intl.message(
      'Sunday',
      name: 'weekdays_sunday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get weekdays_thursday {
    return Intl.message(
      'Thursday',
      name: 'weekdays_thursday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get weekdays_tuesday {
    return Intl.message(
      'Tuesday',
      name: 'weekdays_tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get weekdays_wednesday {
    return Intl.message(
      'Wednesday',
      name: 'weekdays_wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `When would you like to be notified?`
  String get when_to_be_notified {
    return Intl.message(
      'When would you like to be notified?',
      name: 'when_to_be_notified',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password`
  String get wrong_password {
    return Intl.message(
      'Wrong password',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Wrong User ID or Password`
  String get wrong_user_credential {
    return Intl.message(
      'Wrong User ID or Password',
      name: 'wrong_user_credential',
      desc: '',
      args: [],
    );
  }

  /// `Year of Diagnosis`
  String get year_of_diagnosis {
    return Intl.message(
      'Year of Diagnosis',
      name: 'year_of_diagnosis',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Test stribini cihaza yerleştirin.`
  String get accu_check_step1 {
    return Intl.message(
      'Test stribini cihaza yerleştirin.',
      name: 'accu_check_step1',
      desc: '',
      args: [],
    );
  }

  /// `Bir kan damlası çıkartmak için parmağınızı parmak delme cihazı kullanın.`
  String get accu_check_step2 {
    return Intl.message(
      'Bir kan damlası çıkartmak için parmağınızı parmak delme cihazı kullanın.',
      name: 'accu_check_step2',
      desc: '',
      args: [],
    );
  }

  /// `Kan damlasını test stribinin sarı uçlu alanına dikkatlice dokundurun.`
  String get accu_check_step3 {
    return Intl.message(
      'Kan damlasını test stribinin sarı uçlu alanına dikkatlice dokundurun.',
      name: 'accu_check_step3',
      desc: '',
      args: [],
    );
  }

  /// `Kan şekeri sonucunu görüntüleyin.`
  String get accu_check_step4 {
    return Intl.message(
      'Kan şekeri sonucunu görüntüleyin.',
      name: 'accu_check_step4',
      desc: '',
      args: [],
    );
  }

  /// `Test stribini cihaza yerleştirin.`
  String get contour_plus_blood_step1 {
    return Intl.message(
      'Test stribini cihaza yerleştirin.',
      name: 'contour_plus_blood_step1',
      desc: '',
      args: [],
    );
  }

  /// `Bir kan damlası çıkartmak için parmağınızı parmak delme cihazı kullanın.`
  String get contour_plus_blood_step2 {
    return Intl.message(
      'Bir kan damlası çıkartmak için parmağınızı parmak delme cihazı kullanın.',
      name: 'contour_plus_blood_step2',
      desc: '',
      args: [],
    );
  }

  /// `Kan damlasını test stribinin sarı uçlu alanına dikkatlice dokundurun.`
  String get contour_plus_blood_step3 {
    return Intl.message(
      'Kan damlasını test stribinin sarı uçlu alanına dikkatlice dokundurun.',
      name: 'contour_plus_blood_step3',
      desc: '',
      args: [],
    );
  }

  /// `Kan şekeri sonucunu görüntüleyin.`
  String get contour_plus_blood_step4 {
    return Intl.message(
      'Kan şekeri sonucunu görüntüleyin.',
      name: 'contour_plus_blood_step4',
      desc: '',
      args: [],
    );
  }

  /// `Cihazın bandını dirseğinizin hemen üzerinden bağlayın`
  String get omron_arm_step1 {
    return Intl.message(
      'Cihazın bandını dirseğinizin hemen üzerinden bağlayın',
      name: 'omron_arm_step1',
      desc: '',
      args: [],
    );
  }

  /// `Kolunuzu serbest bırakın`
  String get omron_arm_step2 {
    return Intl.message(
      'Kolunuzu serbest bırakın',
      name: 'omron_arm_step2',
      desc: '',
      args: [],
    );
  }

  /// `Cihaz üzerinde bulunan start düğmesine basın`
  String get omron_arm_step3 {
    return Intl.message(
      'Cihaz üzerinde bulunan start düğmesine basın',
      name: 'omron_arm_step3',
      desc: '',
      args: [],
    );
  }

  /// `Sonucunuz ekrana gelene kadar bekleyin.`
  String get omron_arm_step4 {
    return Intl.message(
      'Sonucunuz ekrana gelene kadar bekleyin.',
      name: 'omron_arm_step4',
      desc: '',
      args: [],
    );
  }

  /// `Cihaz ölçüm yaparken rahat ve hareketsiz bekledğinizden emin olun.`
  String get omron_arm_step5 {
    return Intl.message(
      'Cihaz ölçüm yaparken rahat ve hareketsiz bekledğinizden emin olun.',
      name: 'omron_arm_step5',
      desc: '',
      args: [],
    );
  }

  /// `Cihazın bandını el bileğinize bağlayın`
  String get omron_wrist_step1 {
    return Intl.message(
      'Cihazın bandını el bileğinize bağlayın',
      name: 'omron_wrist_step1',
      desc: '',
      args: [],
    );
  }

  /// `Kolunuzu serbest bırakın`
  String get omron_wrist_step2 {
    return Intl.message(
      'Kolunuzu serbest bırakın',
      name: 'omron_wrist_step2',
      desc: '',
      args: [],
    );
  }

  /// `Cihaz üzerinde bulunan start düğmesine basın`
  String get omron_wrist_step3 {
    return Intl.message(
      'Cihaz üzerinde bulunan start düğmesine basın',
      name: 'omron_wrist_step3',
      desc: '',
      args: [],
    );
  }

  /// `Sonucunuz ekrana gelene kadar bekleyin.`
  String get omron_wrist_step4 {
    return Intl.message(
      'Sonucunuz ekrana gelene kadar bekleyin.',
      name: 'omron_wrist_step4',
      desc: '',
      args: [],
    );
  }

  /// `Cihaz ölçüm yaparken rahat ve hareketsiz bekledğinizden emin olun.`
  String get omron_wrist_step5 {
    return Intl.message(
      'Cihaz ölçüm yaparken rahat ve hareketsiz bekledğinizden emin olun.',
      name: 'omron_wrist_step5',
      desc: '',
      args: [],
    );
  }

  /// `Tartınızı düz bir zemine yerleştirin.`
  String get omron_scale_step1 {
    return Intl.message(
      'Tartınızı düz bir zemine yerleştirin.',
      name: 'omron_scale_step1',
      desc: '',
      args: [],
    );
  }

  /// `Kan basıncı ve detaylı yağ ölçümü için yalın ayak şekilde cihazın üzerine çıkın.`
  String get omron_scale_step2 {
    return Intl.message(
      'Kan basıncı ve detaylı yağ ölçümü için yalın ayak şekilde cihazın üzerine çıkın.',
      name: 'omron_scale_step2',
      desc: '',
      args: [],
    );
  }

  /// `Parmak uçlarınızda veya topuklarınız üzerinde durmadığınızdan emin olun.`
  String get omron_scale_step3 {
    return Intl.message(
      'Parmak uçlarınızda veya topuklarınız üzerinde durmadığınızdan emin olun.',
      name: 'omron_scale_step3',
      desc: '',
      args: [],
    );
  }

  /// `Cihaz üzerinde 4 saniye stabil olarak bekleyin.`
  String get omron_scale_step4 {
    return Intl.message(
      'Cihaz üzerinde 4 saniye stabil olarak bekleyin.',
      name: 'omron_scale_step4',
      desc: '',
      args: [],
    );
  }

  /// `Ekranda ölçümünüzü görebilirsiniz.`
  String get omron_scale_step5 {
    return Intl.message(
      'Ekranda ölçümünüzü görebilirsiniz.',
      name: 'omron_scale_step5',
      desc: '',
      args: [],
    );
  }

  /// `Tartınızı düz bir zemine yerleştirin.`
  String get mi_scale_step1 {
    return Intl.message(
      'Tartınızı düz bir zemine yerleştirin.',
      name: 'mi_scale_step1',
      desc: '',
      args: [],
    );
  }

  /// `Kan basıncı ve detaylı yağ ölçümü için yalın ayak şekilde cihazın üzerine çıkın.`
  String get mi_scale_step2 {
    return Intl.message(
      'Kan basıncı ve detaylı yağ ölçümü için yalın ayak şekilde cihazın üzerine çıkın.',
      name: 'mi_scale_step2',
      desc: '',
      args: [],
    );
  }

  /// `Parmak uçlarınızda veya topuklarınız üzerinde durmadığınızdan emin olun.`
  String get mi_scale_step3 {
    return Intl.message(
      'Parmak uçlarınızda veya topuklarınız üzerinde durmadığınızdan emin olun.',
      name: 'mi_scale_step3',
      desc: '',
      args: [],
    );
  }

  /// `Cihaz üzerinde 4 saniye stabil olarak bekleyin.`
  String get mi_scale_step4 {
    return Intl.message(
      'Cihaz üzerinde 4 saniye stabil olarak bekleyin.',
      name: 'mi_scale_step4',
      desc: '',
      args: [],
    );
  }

  /// `Ekranda ölçümünüzü görebilirsiniz.`
  String get mi_scale_step5 {
    return Intl.message(
      'Ekranda ölçümünüzü görebilirsiniz.',
      name: 'mi_scale_step5',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<LocaleProvider> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'fa'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<LocaleProvider> load(Locale locale) => LocaleProvider.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}