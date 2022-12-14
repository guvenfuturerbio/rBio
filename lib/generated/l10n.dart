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
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class LocaleProvider {
  LocaleProvider();

  static LocaleProvider? _current;

  static LocaleProvider get current {
    assert(_current != null,
        'No instance of LocaleProvider was loaded. Try to initialize the LocaleProvider delegate before accessing LocaleProvider.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<LocaleProvider> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = LocaleProvider();
      LocaleProvider._current = instance;

      return instance;
    });
  }

  static LocaleProvider of(BuildContext context) {
    final instance = LocaleProvider.maybeOf(context);
    assert(instance != null,
        'No instance of LocaleProvider present in the widget tree. Did you add LocaleProvider.delegate in localizationsDelegates?');
    return instance!;
  }

  static LocaleProvider? maybeOf(BuildContext context) {
    return Localizations.of<LocaleProvider>(context, LocaleProvider);
  }

  /// `Create`
  String get btn_create {
    return Intl.message(
      'Create',
      name: 'btn_create',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get btn_cancel {
    return Intl.message(
      'Cancel',
      name: 'btn_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get btn_delete {
    return Intl.message(
      'Delete',
      name: 'btn_delete',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get btn_confirm {
    return Intl.message(
      'Confirm',
      name: 'btn_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get btn_done {
    return Intl.message(
      'Done',
      name: 'btn_done',
      desc: '',
      args: [],
    );
  }

  /// `find`
  String get btn_find {
    return Intl.message(
      'find',
      name: 'btn_find',
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

  /// `next`
  String get btn_next {
    return Intl.message(
      'next',
      name: 'btn_next',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get btn_remember_me {
    return Intl.message(
      'Remember me',
      name: 'btn_remember_me',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get btn_sign_in {
    return Intl.message(
      'Sign In',
      name: 'btn_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get btn_sign_up {
    return Intl.message(
      'Sign Up',
      name: 'btn_sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Chronic Tracking`
  String get chronic_track {
    return Intl.message(
      'Chronic Tracking',
      name: 'chronic_track',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Create Appointment`
  String get create_appointment_events {
    return Intl.message(
      'Create Appointment',
      name: 'create_appointment_events',
      desc: '',
      args: [],
    );
  }

  /// `Followers`
  String get followers {
    return Intl.message(
      'Followers',
      name: 'followers',
      desc: '',
      args: [],
    );
  }

  /// `Subscriptions`
  String get subscriptions {
    return Intl.message(
      'Subscriptions',
      name: 'subscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Health Information`
  String get health_information {
    return Intl.message(
      'Health Information',
      name: 'health_information',
      desc: '',
      args: [],
    );
  }

  /// `Health Tracker`
  String get chronic_track_home {
    return Intl.message(
      'Health Tracker',
      name: 'chronic_track_home',
      desc: '',
      args: [],
    );
  }

  /// `Video Call Appointment`
  String get take_video_appointment {
    return Intl.message(
      'Video Call Appointment',
      name: 'take_video_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Devices`
  String get devices {
    return Intl.message(
      'Devices',
      name: 'devices',
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

  /// `Upload\nFile`
  String get uploadFile {
    return Intl.message(
      'Upload\nFile',
      name: 'uploadFile',
      desc: '',
      args: [],
    );
  }

  /// `Request\nTranslator`
  String get requestTranslator {
    return Intl.message(
      'Request\nTranslator',
      name: 'requestTranslator',
      desc: '',
      args: [],
    );
  }

  /// `Start\nMeeting`
  String get startMeeting {
    return Intl.message(
      'Start\nMeeting',
      name: 'startMeeting',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Privacy`
  String get terms_and_privacy {
    return Intl.message(
      'Terms and Privacy',
      name: 'terms_and_privacy',
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

  /// `Do you want delete doctor `
  String get content_delete_doctor_first {
    return Intl.message(
      'Do you want delete doctor ',
      name: 'content_delete_doctor_first',
      desc: '',
      args: [],
    );
  }

  /// `Please contact us from 444 94 94 for Health Tracker services`
  String get not_chronic_warning {
    return Intl.message(
      'Please contact us from 444 94 94 for Health Tracker services',
      name: 'not_chronic_warning',
      desc: '',
      args: [],
    );
  }

  /// ` on list?`
  String get content_delete_doctor_second {
    return Intl.message(
      ' on list?',
      name: 'content_delete_doctor_second',
      desc: '',
      args: [],
    );
  }

  /// `We just need your registered Email to  send you password reset intruction`
  String get des_forgot_password {
    return Intl.message(
      'We just need your registered Email to  send you password reset intruction',
      name: 'des_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `We just need your T.C identity and Phone number to send you temporary password`
  String get des_forgot_password_tc {
    return Intl.message(
      'We just need your T.C identity and Phone number to send you temporary password',
      name: 'des_forgot_password_tc',
      desc: '',
      args: [],
    );
  }

  /// `We just need your Passport and Phone number to send you temporary password`
  String get des_forgot_password_other {
    return Intl.message(
      'We just need your Passport and Phone number to send you temporary password',
      name: 'des_forgot_password_other',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get gender_female {
    return Intl.message(
      'Female',
      name: 'gender_female',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get gender_male {
    return Intl.message(
      'Male',
      name: 'gender_male',
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

  /// `Password`
  String get hint_input_password {
    return Intl.message(
      'Password',
      name: 'hint_input_password',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get hint_time {
    return Intl.message(
      'Time',
      name: 'hint_time',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get lbl_dont_have_account {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'lbl_dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get lbl_forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'lbl_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Hospital Appointment`
  String get lbl_find_hospital {
    return Intl.message(
      'Hospital Appointment',
      name: 'lbl_find_hospital',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get lbl_personal_information {
    return Intl.message(
      'Personal Information',
      name: 'lbl_personal_information',
      desc: '',
      args: [],
    );
  }

  /// `How can we take care of you?`
  String get lbl_take_care {
    return Intl.message(
      'How can we take care of you?',
      name: 'lbl_take_care',
      desc: '',
      args: [],
    );
  }

  /// `DASHBOARD`
  String get menu_dashboard {
    return Intl.message(
      'DASHBOARD',
      name: 'menu_dashboard',
      desc: '',
      args: [],
    );
  }

  /// `DOCTORS`
  String get menu_doctors {
    return Intl.message(
      'DOCTORS',
      name: 'menu_doctors',
      desc: '',
      args: [],
    );
  }

  /// `DRUGS`
  String get menu_drugs {
    return Intl.message(
      'DRUGS',
      name: 'menu_drugs',
      desc: '',
      args: [],
    );
  }

  /// `HOME`
  String get menu_home {
    return Intl.message(
      'HOME',
      name: 'menu_home',
      desc: '',
      args: [],
    );
  }

  /// `LOG OUT`
  String get menu_log_out {
    return Intl.message(
      'LOG OUT',
      name: 'menu_log_out',
      desc: '',
      args: [],
    );
  }

  /// `NEWS HEALTHLY`
  String get menu_news_healthly {
    return Intl.message(
      'NEWS HEALTHLY',
      name: 'menu_news_healthly',
      desc: '',
      args: [],
    );
  }

  /// `PROFILE`
  String get menu_profile {
    return Intl.message(
      'PROFILE',
      name: 'menu_profile',
      desc: '',
      args: [],
    );
  }

  /// `SERVICES`
  String get menu_services {
    return Intl.message(
      'SERVICES',
      name: 'menu_services',
      desc: '',
      args: [],
    );
  }

  /// `Create Appointment`
  String get title_appointment {
    return Intl.message(
      'Create Appointment',
      name: 'title_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Appointment Details`
  String get title_appointment_detail {
    return Intl.message(
      'Appointment Details',
      name: 'title_appointment_detail',
      desc: '',
      args: [],
    );
  }

  /// `Book Appointment`
  String get title_book_appointment {
    return Intl.message(
      'Book Appointment',
      name: 'title_book_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Delete Doctor`
  String get title_delete_doctor {
    return Intl.message(
      'Delete Doctor',
      name: 'title_delete_doctor',
      desc: '',
      args: [],
    );
  }

  /// `Doctors`
  String get title_doctors {
    return Intl.message(
      'Doctors',
      name: 'title_doctors',
      desc: '',
      args: [],
    );
  }

  /// `Doctor's Profile`
  String get title_doctors_profiles {
    return Intl.message(
      'Doctor\'s Profile',
      name: 'title_doctors_profiles',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get title_forgot_password {
    return Intl.message(
      'Forgot Password',
      name: 'title_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Goal`
  String get title_goal {
    return Intl.message(
      'Goal',
      name: 'title_goal',
      desc: '',
      args: [],
    );
  }

  /// `Hospital`
  String get title_hospital {
    return Intl.message(
      'Hospital',
      name: 'title_hospital',
      desc: '',
      args: [],
    );
  }

  /// `User Profile`
  String get title_user_profile {
    return Intl.message(
      'User Profile',
      name: 'title_user_profile',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Username or Password!`
  String get wrong_username_password {
    return Intl.message(
      'Wrong Username or Password!',
      name: 'wrong_username_password',
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

  /// `Sorry, we are currently unable to complete your transaction. Please try again later`
  String get sorry_dont_transaction {
    return Intl.message(
      'Sorry, we are currently unable to complete your transaction. Please try again later',
      name: 'sorry_dont_transaction',
      desc: '',
      args: [],
    );
  }

  /// `T.C identity/Passport Number`
  String get tc_or_passport {
    return Intl.message(
      'T.C identity/Passport Number',
      name: 'tc_or_passport',
      desc: '',
      args: [],
    );
  }

  /// `Username or password cannot be empty !`
  String get tc_or_pass_cannot_empty {
    return Intl.message(
      'Username or password cannot be empty !',
      name: 'tc_or_pass_cannot_empty',
      desc: '',
      args: [],
    );
  }

  /// `Citizen of T.C`
  String get citizen_of_tc {
    return Intl.message(
      'Citizen of T.C',
      name: 'citizen_of_tc',
      desc: '',
      args: [],
    );
  }

  /// `Foreign National`
  String get foreign_national {
    return Intl.message(
      'Foreign National',
      name: 'foreign_national',
      desc: '',
      args: [],
    );
  }

  /// `T.C identity Number`
  String get tc_identity_number {
    return Intl.message(
      'T.C identity Number',
      name: 'tc_identity_number',
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

  /// `E-mail Address`
  String get email_address {
    return Intl.message(
      'E-mail Address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Surname`
  String get surname {
    return Intl.message(
      'Surname',
      name: 'surname',
      desc: '',
      args: [],
    );
  }

  /// `Passport Number/Citizen Id`
  String get passport_number {
    return Intl.message(
      'Passport Number/Citizen Id',
      name: 'passport_number',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personal_info {
    return Intl.message(
      'Personal Information',
      name: 'personal_info',
      desc: '',
      args: [],
    );
  }

  /// `Create Password`
  String get create_password {
    return Intl.message(
      'Create Password',
      name: 'create_password',
      desc: '',
      args: [],
    );
  }

  /// `Sms Verification`
  String get sms_verification {
    return Intl.message(
      'Sms Verification',
      name: 'sms_verification',
      desc: '',
      args: [],
    );
  }

  /// `Sms Verification Code`
  String get sms_verification_code {
    return Intl.message(
      'Sms Verification Code',
      name: 'sms_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Password Again`
  String get password_again {
    return Intl.message(
      'Password Again',
      name: 'password_again',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't find a relevant result`
  String get searchEmpty {
    return Intl.message(
      'We couldn\'t find a relevant result',
      name: 'searchEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Do you want delete doctor $doctor on list?`
  String get content_delete_doctor {
    return Intl.message(
      'Do you want delete doctor \$doctor on list?',
      name: 'content_delete_doctor',
      desc: '',
      args: [],
    );
  }

  /// `Balance: balance`
  String get lbl_balance {
    return Intl.message(
      'Balance: balance',
      name: 'lbl_balance',
      desc: '',
      args: [],
    );
  }

  /// `$distance km way`
  String get lbl_distance {
    return Intl.message(
      '\$distance km way',
      name: 'lbl_distance',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get lbl_hello {
    return Intl.message(
      'Hello',
      name: 'lbl_hello',
      desc: '',
      args: [],
    );
  }

  /// `$number available`
  String get lbl_number_appointment {
    return Intl.message(
      '\$number available',
      name: 'lbl_number_appointment',
      desc: '',
      args: [],
    );
  }

  /// `$number doctors`
  String get lbl_number_doctor {
    return Intl.message(
      '\$number doctors',
      name: 'lbl_number_doctor',
      desc: '',
      args: [],
    );
  }

  /// `$number hospital`
  String get lbl_number_hospital {
    return Intl.message(
      '\$number hospital',
      name: 'lbl_number_hospital',
      desc: '',
      args: [],
    );
  }

  /// `$number services`
  String get lbl_number_services {
    return Intl.message(
      '\$number services',
      name: 'lbl_number_services',
      desc: '',
      args: [],
    );
  }

  /// `$price`
  String get lbl_price {
    return Intl.message(
      '\$price',
      name: 'lbl_price',
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

  /// `CONFIRM`
  String get confirm {
    return Intl.message(
      'CONFIRM',
      name: 'confirm',
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

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `We could not find an account corresponding to the information entered. If you wish, you can create a new account by clicking the sign up button.`
  String get we_couldnt_find_account {
    return Intl.message(
      'We could not find an account corresponding to the information entered. If you wish, you can create a new account by clicking the sign up button.',
      name: 'we_couldnt_find_account',
      desc: '',
      args: [],
    );
  }

  /// `Temporary Password`
  String get temporary_pass {
    return Intl.message(
      'Temporary Password',
      name: 'temporary_pass',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get new_password {
    return Intl.message(
      'New password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `New password again`
  String get new_password_again {
    return Intl.message(
      'New password again',
      name: 'new_password_again',
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

  /// `You entered your temporary password incorrectly`
  String get wrong_temporary_pass {
    return Intl.message(
      'You entered your temporary password incorrectly',
      name: 'wrong_temporary_pass',
      desc: '',
      args: [],
    );
  }

  /// `'new password' and 'again new password' values must be the same.`
  String get pass_must_same {
    return Intl.message(
      '\'new password\' and \'again new password\' values must be the same.',
      name: 'pass_must_same',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get my_appointments {
    return Intl.message(
      'Appointments',
      name: 'my_appointments',
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

  /// `2 weeks`
  String get two_week {
    return Intl.message(
      '2 weeks',
      name: 'two_week',
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

  /// `Your appointment has been created successfully`
  String get appo_created {
    return Intl.message(
      'Your appointment has been created successfully',
      name: 'appo_created',
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

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel your appointment ?`
  String get cancel_appo_question {
    return Intl.message(
      'Are you sure you want to cancel your appointment ?',
      name: 'cancel_appo_question',
      desc: '',
      args: [],
    );
  }

  /// `Appointment availability is off. Please make a different choice`
  String get appo_availabity_off {
    return Intl.message(
      'Appointment availability is off. Please make a different choice',
      name: 'appo_availabity_off',
      desc: '',
      args: [],
    );
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

  /// `Your appointment has been successfully canceled`
  String get appo_canceled {
    return Intl.message(
      'Your appointment has been successfully canceled',
      name: 'appo_canceled',
      desc: '',
      args: [],
    );
  }

  /// `You can reach 444 94 94 for your transactions regarding the appointment you have chosen`
  String get call_for_ur_appo {
    return Intl.message(
      'You can reach 444 94 94 for your transactions regarding the appointment you have chosen',
      name: 'call_for_ur_appo',
      desc: '',
      args: [],
    );
  }

  /// `Results`
  String get results {
    return Intl.message(
      'Results',
      name: 'results',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get not {
    return Intl.message(
      'Note',
      name: 'not',
      desc: '',
      args: [],
    );
  }

  /// `Show Result`
  String get show_result {
    return Intl.message(
      'Show Result',
      name: 'show_result',
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

  /// `Expired Date`
  String get credit_card_expired_date {
    return Intl.message(
      'Expired Date',
      name: 'credit_card_expired_date',
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

  /// `Card Holder`
  String get credit_card_holder {
    return Intl.message(
      'Card Holder',
      name: 'credit_card_holder',
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

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Birthday `
  String get birth_date {
    return Intl.message(
      'Birthday ',
      name: 'birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Payment transaction is successful. Your appointment has been created successfully`
  String get payment_successfull {
    return Intl.message(
      'Payment transaction is successful. Your appointment has been created successfully',
      name: 'payment_successfull',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `An error has been encountered, but your appointment has been created. Please contact us`
  String get appointment_created_but_error {
    return Intl.message(
      'An error has been encountered, but your appointment has been created. Please contact us',
      name: 'appointment_created_but_error',
      desc: '',
      args: [],
    );
  }

  /// `Your appointment couldn't be created`
  String get appointment_could_not_create {
    return Intl.message(
      'Your appointment couldn\'t be created',
      name: 'appointment_could_not_create',
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

  /// `Please fill in all fields`
  String get fill_all_field {
    return Intl.message(
      'Please fill in all fields',
      name: 'fill_all_field',
      desc: '',
      args: [],
    );
  }

  /// `Please Try again by checking the information that you have entered`
  String get check_and_try_again {
    return Intl.message(
      'Please Try again by checking the information that you have entered',
      name: 'check_and_try_again',
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

  /// `Expiration date should be written in mm/yy format`
  String get expiration_date_should_be {
    return Intl.message(
      'Expiration date should be written in mm/yy format',
      name: 'expiration_date_should_be',
      desc: '',
      args: [],
    );
  }

  /// `Your credit card number must be 16 digits`
  String get credit_card_lenght_should {
    return Intl.message(
      'Your credit card number must be 16 digits',
      name: 'credit_card_lenght_should',
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

  /// `Make an Appointment`
  String get make_an_appointment {
    return Intl.message(
      'Make an Appointment',
      name: 'make_an_appointment',
      desc: '',
      args: [],
    );
  }

  /// `CV has not been uploaded yet`
  String get doctor_cv_not_uploaded {
    return Intl.message(
      'CV has not been uploaded yet',
      name: 'doctor_cv_not_uploaded',
      desc: '',
      args: [],
    );
  }

  /// `Career`
  String get career_information {
    return Intl.message(
      'Career',
      name: 'career_information',
      desc: '',
      args: [],
    );
  }

  /// `Cv`
  String get cv {
    return Intl.message(
      'Cv',
      name: 'cv',
      desc: '',
      args: [],
    );
  }

  /// `Publications`
  String get publications {
    return Intl.message(
      'Publications',
      name: 'publications',
      desc: '',
      args: [],
    );
  }

  /// `Experiences`
  String get experiences {
    return Intl.message(
      'Experiences',
      name: 'experiences',
      desc: '',
      args: [],
    );
  }

  /// `Educations`
  String get educations {
    return Intl.message(
      'Educations',
      name: 'educations',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get log_out {
    return Intl.message(
      'Log Out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Doctor, Hospital, Department`
  String get search_hint {
    return Intl.message(
      'Doctor, Hospital, Department',
      name: 'search_hint',
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

  /// `Call Me`
  String get call_me {
    return Intl.message(
      'Call Me',
      name: 'call_me',
      desc: '',
      args: [],
    );
  }

  /// `We will call you as soon as possible`
  String get we_will_call {
    return Intl.message(
      'We will call you as soon as possible',
      name: 'we_will_call',
      desc: '',
      args: [],
    );
  }

  /// `No online call payment has been made. You cannot participate`
  String get online_appo_error_eksi1 {
    return Intl.message(
      'No online call payment has been made. You cannot participate',
      name: 'online_appo_error_eksi1',
      desc: '',
      args: [],
    );
  }

  /// `The meeting has been completed. You cannot participate`
  String get online_appo_error_0 {
    return Intl.message(
      'The meeting has been completed. You cannot participate',
      name: 'online_appo_error_0',
      desc: '',
      args: [],
    );
  }

  /// `You came long before the call time. please try again later`
  String get online_appo_error_1 {
    return Intl.message(
      'You came long before the call time. please try again later',
      name: 'online_appo_error_1',
      desc: '',
      args: [],
    );
  }

  /// `The meeting has been completed. You cannot participate`
  String get online_appo_error_4 {
    return Intl.message(
      'The meeting has been completed. You cannot participate',
      name: 'online_appo_error_4',
      desc: '',
      args: [],
    );
  }

  /// `The e-mail address has already been registered`
  String get already_registered_mail {
    return Intl.message(
      'The e-mail address has already been registered',
      name: 'already_registered_mail',
      desc: '',
      args: [],
    );
  }

  /// `Your Mobile Phone Number Registered In Our Hospital Is Different. Please Check It or You can update your number by calling 444 94 94.`
  String get already_registered_phone {
    return Intl.message(
      'Your Mobile Phone Number Registered In Our Hospital Is Different. Please Check It or You can update your number by calling 444 94 94.',
      name: 'already_registered_phone',
      desc: '',
      args: [],
    );
  }

  /// `Credentials already exist linked to an account. First of all, it must be deleted from the account it is linked to`
  String get credential_already_exist {
    return Intl.message(
      'Credentials already exist linked to an account. First of all, it must be deleted from the account it is linked to',
      name: 'credential_already_exist',
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

  /// `I have read and understood the privacy statement and personal data protection policy`
  String get accept_personal_data {
    return Intl.message(
      'I have read and understood the privacy statement and personal data protection policy',
      name: 'accept_personal_data',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Statement and Personal Data Protection Policy`
  String get personal_data_policy {
    return Intl.message(
      'Privacy Statement and Personal Data Protection Policy',
      name: 'personal_data_policy',
      desc: '',
      args: [],
    );
  }

  /// `In order for us to continue with your registration, you must approve the Privacy Statement and the Personal Data Protection Policy`
  String get check_personal_data {
    return Intl.message(
      'In order for us to continue with your registration, you must approve the Privacy Statement and the Personal Data Protection Policy',
      name: 'check_personal_data',
      desc: '',
      args: [],
    );
  }

  /// `I have read understood and approve the distance sales contract`
  String get accept_distance_sales_contract {
    return Intl.message(
      'I have read understood and approve the distance sales contract',
      name: 'accept_distance_sales_contract',
      desc: '',
      args: [],
    );
  }

  /// `Distance Sales Contract`
  String get distance_sales_contract {
    return Intl.message(
      'Distance Sales Contract',
      name: 'distance_sales_contract',
      desc: '',
      args: [],
    );
  }

  /// `In order to continue your transaction, You need to read and approve the distance sales contract`
  String get check_distance_sales_contract {
    return Intl.message(
      'In order to continue your transaction, You need to read and approve the distance sales contract',
      name: 'check_distance_sales_contract',
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

  /// `Online Appointment`
  String get online_appo {
    return Intl.message(
      'Online Appointment',
      name: 'online_appo',
      desc: '',
      args: [],
    );
  }

  /// `Please call 444 94 94 to cancel the appointment`
  String get cancel_call_appo {
    return Intl.message(
      'Please call 444 94 94 to cancel the appointment',
      name: 'cancel_call_appo',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start_video_call {
    return Intl.message(
      'Start',
      name: 'start_video_call',
      desc: '',
      args: [],
    );
  }

  /// `Translator`
  String get get_translator {
    return Intl.message(
      'Translator',
      name: 'get_translator',
      desc: '',
      args: [],
    );
  }

  /// `Appointment Files`
  String get appointment_file {
    return Intl.message(
      'Appointment Files',
      name: 'appointment_file',
      desc: '',
      args: [],
    );
  }

  /// `File has been successfully deleted`
  String get file_deleted {
    return Intl.message(
      'File has been successfully deleted',
      name: 'file_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this file ?`
  String get delete_file_question {
    return Intl.message(
      'Are you sure you want to delete this file ?',
      name: 'delete_file_question',
      desc: '',
      args: [],
    );
  }

  /// `No file was found for the selected appointment`
  String get no_file_found {
    return Intl.message(
      'No file was found for the selected appointment',
      name: 'no_file_found',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to upload this file for selected appointment ? `
  String get upload_file_question {
    return Intl.message(
      'Are you sure you want to upload this file for selected appointment ? ',
      name: 'upload_file_question',
      desc: '',
      args: [],
    );
  }

  /// `File has been successfully uploaded`
  String get file_uploaded {
    return Intl.message(
      'File has been successfully uploaded',
      name: 'file_uploaded',
      desc: '',
      args: [],
    );
  }

  /// `Relatives`
  String get relatives {
    return Intl.message(
      'Relatives',
      name: 'relatives',
      desc: '',
      args: [],
    );
  }

  /// `Add New Relative`
  String get add_new_relative {
    return Intl.message(
      'Add New Relative',
      name: 'add_new_relative',
      desc: '',
      args: [],
    );
  }

  /// `Saved Relatives`
  String get saved_relatives {
    return Intl.message(
      'Saved Relatives',
      name: 'saved_relatives',
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

  /// `Deparment`
  String get department {
    return Intl.message(
      'Deparment',
      name: 'department',
      desc: '',
      args: [],
    );
  }

  /// `COVID-19`
  String get whats_covid {
    return Intl.message(
      'COVID-19',
      name: 'whats_covid',
      desc: '',
      args: [],
    );
  }

  /// `What is COVID-19 (New Coronavirus)?`
  String get covid_title_1 {
    return Intl.message(
      'What is COVID-19 (New Coronavirus)?',
      name: 'covid_title_1',
      desc: '',
      args: [],
    );
  }

  /// `How did COVID-19 (New Coronavirus) come about?`
  String get covid_title_2 {
    return Intl.message(
      'How did COVID-19 (New Coronavirus) come about?',
      name: 'covid_title_2',
      desc: '',
      args: [],
    );
  }

  /// `How is COVID-19 (New Coronavirus) transmitted?`
  String get covid_title_3 {
    return Intl.message(
      'How is COVID-19 (New Coronavirus) transmitted?',
      name: 'covid_title_3',
      desc: '',
      args: [],
    );
  }

  /// `Which countries and how many people has COVID-19 (New Coronavirus) affected?`
  String get covid_title_4 {
    return Intl.message(
      'Which countries and how many people has COVID-19 (New Coronavirus) affected?',
      name: 'covid_title_4',
      desc: '',
      args: [],
    );
  }

  /// `Who is at higher risk for COVID-19 (New Coronavirus) transmission?`
  String get covid_title_5 {
    return Intl.message(
      'Who is at higher risk for COVID-19 (New Coronavirus) transmission?',
      name: 'covid_title_5',
      desc: '',
      args: [],
    );
  }

  /// `How is COVID-19 (New Coronavirus) diagnosed?`
  String get covid_title_6 {
    return Intl.message(
      'How is COVID-19 (New Coronavirus) diagnosed?',
      name: 'covid_title_6',
      desc: '',
      args: [],
    );
  }

  /// `What are the symptoms of COVID-19 (New Coronavirus)?`
  String get covid_title_7 {
    return Intl.message(
      'What are the symptoms of COVID-19 (New Coronavirus)?',
      name: 'covid_title_7',
      desc: '',
      args: [],
    );
  }

  /// `Viruses that can cause disease in humans and animals and have many types are called "Coronavirus". These viruses, which usually cause colds in humans, can also cause loss of life. The SARS-CoV virus epidemic that started in Guangdong Province of China in 2002 has spread to 17 countries worldwide. In this epidemic, 8098 people got the disease and 774 people died. The MERS-CoV virus epidemic, which started in Saudi Arabia in 2012, affected 27 countries worldwide, 861 out of 2499 people caught in the epidemic died.`
  String get covid_text_1 {
    return Intl.message(
      'Viruses that can cause disease in humans and animals and have many types are called "Coronavirus". These viruses, which usually cause colds in humans, can also cause loss of life. The SARS-CoV virus epidemic that started in Guangdong Province of China in 2002 has spread to 17 countries worldwide. In this epidemic, 8098 people got the disease and 774 people died. The MERS-CoV virus epidemic, which started in Saudi Arabia in 2012, affected 27 countries worldwide, 861 out of 2499 people caught in the epidemic died.',
      name: 'covid_text_1',
      desc: '',
      args: [],
    );
  }

  /// `In the last days of 2019, it was noticed that there was a cluster of pneumonia cases admitted to the hospital in Wuhan, China's Hubei Province. The first cases are epidemiologically related to an animal market in Wuhan. Three patients were admitted to a hospital in Wuhan on 27 December 2019 with the diagnosis of severe pneumonia. The first case is a 49-year-old woman who was a fish seller at the animal market in Wuhan. The second patient is a 61-year-old male who frequently shoppers at the animal market.`
  String get covid_text_2 {
    return Intl.message(
      'In the last days of 2019, it was noticed that there was a cluster of pneumonia cases admitted to the hospital in Wuhan, China\'s Hubei Province. The first cases are epidemiologically related to an animal market in Wuhan. Three patients were admitted to a hospital in Wuhan on 27 December 2019 with the diagnosis of severe pneumonia. The first case is a 49-year-old woman who was a fish seller at the animal market in Wuhan. The second patient is a 61-year-old male who frequently shoppers at the animal market.',
      name: 'covid_text_2',
      desc: '',
      args: [],
    );
  }

  /// `Samples taken from the first patients were tested for many known pathogens. A new Coronavirus (2019-nCoV) has been identified, showing 85 percent similarity to the bat SARS-CoV virus. It has been found that the virus is transmitted by droplets and close contact. On January 1, 2020, the animal market in Wuhan, which was thought to be the origin of the virus, was closed.\n\nThe virus is transmitted through droplets. As a result of the coughing of an individual carrying COVID-19, inhalation of droplets that spread around can cause transmission of the disease. In addition, the virus can be transmitted by touching the face, eyes, nose or mouth without washing the hands after touching the surfaces where the droplets may have settled.`
  String get covid_text_3 {
    return Intl.message(
      'Samples taken from the first patients were tested for many known pathogens. A new Coronavirus (2019-nCoV) has been identified, showing 85 percent similarity to the bat SARS-CoV virus. It has been found that the virus is transmitted by droplets and close contact. On January 1, 2020, the animal market in Wuhan, which was thought to be the origin of the virus, was closed.\n\nThe virus is transmitted through droplets. As a result of the coughing of an individual carrying COVID-19, inhalation of droplets that spread around can cause transmission of the disease. In addition, the virus can be transmitted by touching the face, eyes, nose or mouth without washing the hands after touching the surfaces where the droplets may have settled.',
      name: 'covid_text_3',
      desc: '',
      args: [],
    );
  }

  /// `Click the button to reach the countries affected by the coronavirus and the current issues.`
  String get covid_text_4 {
    return Intl.message(
      'Click the button to reach the countries affected by the coronavirus and the current issues.',
      name: 'covid_text_4',
      desc: '',
      args: [],
    );
  }

  /// `Considering the cases that have occurred to date, individuals of advanced age (65 years and over) and people with chronic diseases such as heart, hypertension, diabetes, chronic respiratory disease and cancer are more affected by COVID-19 infection. Considering all the numbers, it is possible to say that 80 percent of the infected people overcome the disease slightly. The remaining 20 percent require treatment under hospital conditions. This epidemic rarely affects children. There is not enough scientific evidence yet regarding the effects of the epidemic on pregnant women. There is also limited scientific evidence that the virus can be transmitted from mother to baby during pregnancy.`
  String get covid_text_5 {
    return Intl.message(
      'Considering the cases that have occurred to date, individuals of advanced age (65 years and over) and people with chronic diseases such as heart, hypertension, diabetes, chronic respiratory disease and cancer are more affected by COVID-19 infection. Considering all the numbers, it is possible to say that 80 percent of the infected people overcome the disease slightly. The remaining 20 percent require treatment under hospital conditions. This epidemic rarely affects children. There is not enough scientific evidence yet regarding the effects of the epidemic on pregnant women. There is also limited scientific evidence that the virus can be transmitted from mother to baby during pregnancy.',
      name: 'covid_text_5',
      desc: '',
      args: [],
    );
  }

  /// `The diagnosis of COVID-19 (New Coronavirus) is made by molecular tests performed in health institutions determined by the Ministry of Health.`
  String get covid_text_6 {
    return Intl.message(
      'The diagnosis of COVID-19 (New Coronavirus) is made by molecular tests performed in health institutions determined by the Ministry of Health.',
      name: 'covid_text_6',
      desc: '',
      args: [],
    );
  }

  /// `Early stage symptoms of the disease; Cough, chest tightness, fever and shortness of breath. In advanced stages, cough and shortness of breath may increase, as well as respiratory distress, findings similar to pneumonia can be seen.`
  String get covid_text_7 {
    return Intl.message(
      'Early stage symptoms of the disease; Cough, chest tightness, fever and shortness of breath. In advanced stages, cough and shortness of breath may increase, as well as respiratory distress, findings similar to pneumonia can be seen.',
      name: 'covid_text_7',
      desc: '',
      args: [],
    );
  }

  /// `Take a COVID-19 Test`
  String get take_covid_19 {
    return Intl.message(
      'Take a COVID-19 Test',
      name: 'take_covid_19',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code`
  String get enter_the_code {
    return Intl.message(
      'Enter the code',
      name: 'enter_the_code',
      desc: '',
      args: [],
    );
  }

  /// `Please check your SMS/Email`
  String get check_sms {
    return Intl.message(
      'Please check your SMS/Email',
      name: 'check_sms',
      desc: '',
      args: [],
    );
  }

  /// `Checking for updates...`
  String get check_for_updates {
    return Intl.message(
      'Checking for updates...',
      name: 'check_for_updates',
      desc: '',
      args: [],
    );
  }

  /// `assets/images/language_eng-01.png`
  String get select_language {
    return Intl.message(
      'assets/images/language_eng-01.png',
      name: 'select_language',
      desc: '',
      args: [],
    );
  }

  /// `Let's know you better!`
  String get lets_know_you_better {
    return Intl.message(
      'Let\'s know you better!',
      name: 'lets_know_you_better',
      desc: '',
      args: [],
    );
  }

  /// `SELECT BIRTH DATE`
  String get select_birth_date {
    return Intl.message(
      'SELECT BIRTH DATE',
      name: 'select_birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Existing User Saved Into Relatives.`
  String get existing_relative_add {
    return Intl.message(
      'Existing User Saved Into Relatives.',
      name: 'existing_relative_add',
      desc: '',
      args: [],
    );
  }

  /// `Further operations will be completed by the selected user, do you confirm?`
  String get relative_change_message {
    return Intl.message(
      'Further operations will be completed by the selected user, do you confirm?',
      name: 'relative_change_message',
      desc: '',
      args: [],
    );
  }

  /// `Please update the app to continue.`
  String get force_update_message {
    return Intl.message(
      'Please update the app to continue.',
      name: 'force_update_message',
      desc: '',
      args: [],
    );
  }

  /// `A new version is available`
  String get optional_update_message {
    return Intl.message(
      'A new version is available',
      name: 'optional_update_message',
      desc: '',
      args: [],
    );
  }

  /// `Don't ask me again`
  String get dont_ask_again {
    return Intl.message(
      'Don\'t ask me again',
      name: 'dont_ask_again',
      desc: '',
      args: [],
    );
  }

  /// `Never ask again`
  String get never_ask_again {
    return Intl.message(
      'Never ask again',
      name: 'never_ask_again',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Update Now`
  String get update_now {
    return Intl.message(
      'Update Now',
      name: 'update_now',
      desc: '',
      args: [],
    );
  }

  /// `App Update Available`
  String get app_update_available {
    return Intl.message(
      'App Update Available',
      name: 'app_update_available',
      desc: '',
      args: [],
    );
  }

  /// `Switch Back To Default`
  String get switch_back_to_default_account {
    return Intl.message(
      'Switch Back To Default',
      name: 'switch_back_to_default_account',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported Language`
  String get unsupported_language {
    return Intl.message(
      'Unsupported Language',
      name: 'unsupported_language',
      desc: '',
      args: [],
    );
  }

  /// `Select another language`
  String get select_another_language {
    return Intl.message(
      'Select another language',
      name: 'select_another_language',
      desc: '',
      args: [],
    );
  }

  /// `Deleting!`
  String get delete_relative_title {
    return Intl.message(
      'Deleting!',
      name: 'delete_relative_title',
      desc: '',
      args: [],
    );
  }

  /// `Do you confirm?`
  String get delete_relative_confirm_message {
    return Intl.message(
      'Do you confirm?',
      name: 'delete_relative_confirm_message',
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

  /// `All Appointment Files`
  String get all_appointment_file {
    return Intl.message(
      'All Appointment Files',
      name: 'all_appointment_file',
      desc: '',
      args: [],
    );
  }

  /// `Online Hospital`
  String get online_hospital {
    return Intl.message(
      'Online Hospital',
      name: 'online_hospital',
      desc: '',
      args: [],
    );
  }

  /// `Show Report`
  String get show_report {
    return Intl.message(
      'Show Report',
      name: 'show_report',
      desc: '',
      args: [],
    );
  }

  /// `https://tawk.to/chat/5f86c131a2eb1124c0bcccc5/default`
  String get tawkto_url {
    return Intl.message(
      'https://tawk.to/chat/5f86c131a2eb1124c0bcccc5/default',
      name: 'tawkto_url',
      desc: '',
      args: [],
    );
  }

  /// `https://app.guven.com.tr/assets/static/kvkk_en.html`
  String get policy_url {
    return Intl.message(
      'https://app.guven.com.tr/assets/static/kvkk_en.html',
      name: 'policy_url',
      desc: '',
      args: [],
    );
  }

  /// `https://app.guven.com.tr/assets/static/sales_contract_en.html`
  String get sales_contract_url {
    return Intl.message(
      'https://app.guven.com.tr/assets/static/sales_contract_en.html',
      name: 'sales_contract_url',
      desc: '',
      args: [],
    );
  }

  /// `Switch`
  String get select_relative {
    return Intl.message(
      'Switch',
      name: 'select_relative',
      desc: '',
      args: [],
    );
  }

  /// `You can only add children of your own below age of 18`
  String get relatives_only_children_warning {
    return Intl.message(
      'You can only add children of your own below age of 18',
      name: 'relatives_only_children_warning',
      desc: '',
      args: [],
    );
  }

  /// `Cancellation and refund conditions`
  String get cancellation_refund_conditions {
    return Intl.message(
      'Cancellation and refund conditions',
      name: 'cancellation_refund_conditions',
      desc: '',
      args: [],
    );
  }

  /// `https://app.guven.com.tr/assets/static/iptal_en.html`
  String get iptal_url {
    return Intl.message(
      'https://app.guven.com.tr/assets/static/iptal_en.html',
      name: 'iptal_url',
      desc: '',
      args: [],
    );
  }

  /// `Informed consent form??`
  String get informed_consent_form {
    return Intl.message(
      'Informed consent form??',
      name: 'informed_consent_form',
      desc: '',
      args: [],
    );
  }

  /// `https://app.guven.com.tr/assets/static/onam_en.html`
  String get informed_consent_form_url {
    return Intl.message(
      'https://app.guven.com.tr/assets/static/onam_en.html',
      name: 'informed_consent_form_url',
      desc: '',
      args: [],
    );
  }

  /// `In order to continue your transaction, You need to read and approve the informed consent form`
  String get check_informed_consent_form {
    return Intl.message(
      'In order to continue your transaction, You need to read and approve the informed consent form',
      name: 'check_informed_consent_form',
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

  /// `Click and Go`
  String get click_go {
    return Intl.message(
      'Click and Go',
      name: 'click_go',
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

  /// `Irrelevant`
  String get irrelevant {
    return Intl.message(
      'Irrelevant',
      name: 'irrelevant',
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

  /// `Every`
  String get every {
    return Intl.message(
      'Every',
      name: 'every',
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

  /// `Select the type of appointment you want to process`
  String get select_appo_type {
    return Intl.message(
      'Select the type of appointment you want to process',
      name: 'select_appo_type',
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

  /// `Profile picture will be deleted. Do you confirm?`
  String get profile_picture_delete {
    return Intl.message(
      'Profile picture will be deleted. Do you confirm?',
      name: 'profile_picture_delete',
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

  /// `??l????m ba??ar??yla silindi...`
  String get delete_measurement_succesfull {
    return Intl.message(
      '??l????m ba??ar??yla silindi...',
      name: 'delete_measurement_succesfull',
      desc: '',
      args: [],
    );
  }

  /// `??l????m silinemedi...`
  String get delete_measurement_un_succesfull {
    return Intl.message(
      '??l????m silinemedi...',
      name: 'delete_measurement_un_succesfull',
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

  /// `Loading Meeting...`
  String get load_zoom_meeting {
    return Intl.message(
      'Loading Meeting...',
      name: 'load_zoom_meeting',
      desc: '',
      args: [],
    );
  }

  /// `Starting Meeting...`
  String get start_zoom_meeting {
    return Intl.message(
      'Starting Meeting...',
      name: 'start_zoom_meeting',
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

  /// `Please call 444 9 494 to contact us.`
  String get call_us_message {
    return Intl.message(
      'Please call 444 9 494 to contact us.',
      name: 'call_us_message',
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

  /// `Info`
  String get success_message_title {
    return Intl.message(
      'Info',
      name: 'success_message_title',
      desc: '',
      args: [],
    );
  }

  /// `Symptom Analyzer`
  String get symptom_analyzer {
    return Intl.message(
      'Symptom Analyzer',
      name: 'symptom_analyzer',
      desc: '',
      args: [],
    );
  }

  /// `en-gb`
  String get symptomChecker_language {
    return Intl.message(
      'en-gb',
      name: 'symptomChecker_language',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get hint_input_old_password {
    return Intl.message(
      'Old Password',
      name: 'hint_input_old_password',
      desc: '',
      args: [],
    );
  }

  /// `G??VENin`
  String get guven_journal {
    return Intl.message(
      'G??VENin',
      name: 'guven_journal',
      desc: '',
      args: [],
    );
  }

  /// `https://www.guvenin.com.tr`
  String get guven_journal_url {
    return Intl.message(
      'https://www.guvenin.com.tr',
      name: 'guven_journal_url',
      desc: '',
      args: [],
    );
  }

  /// `Old password is wrong! Please try again.`
  String get error_old_password_wrong {
    return Intl.message(
      'Old password is wrong! Please try again.',
      name: 'error_old_password_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid password.`
  String get password_wrong {
    return Intl.message(
      'Please enter valid password.',
      name: 'password_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Passwords mismatch! Please try again.`
  String get error_password_mismatch {
    return Intl.message(
      'Passwords mismatch! Please try again.',
      name: 'error_password_mismatch',
      desc: '',
      args: [],
    );
  }

  /// `System has encountered a problem! Please try again later.`
  String get error_system_malfunction {
    return Intl.message(
      'System has encountered a problem! Please try again later.',
      name: 'error_system_malfunction',
      desc: '',
      args: [],
    );
  }

  /// `Youtube Stream`
  String get youtube_stream {
    return Intl.message(
      'Youtube Stream',
      name: 'youtube_stream',
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

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
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

  /// `Pick a photo option`
  String get pick_a_photo_option {
    return Intl.message(
      'Pick a photo option',
      name: 'pick_a_photo_option',
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

  /// `Please allow access to camera by going to your Settings`
  String get allow_permission_camera {
    return Intl.message(
      'Please allow access to camera by going to your Settings',
      name: 'allow_permission_camera',
      desc: '',
      args: [],
    );
  }

  /// `Please fill out the form to apply for the lottery`
  String get fill_all_field_to_win_lottery {
    return Intl.message(
      'Please fill out the form to apply for the lottery',
      name: 'fill_all_field_to_win_lottery',
      desc: '',
      args: [],
    );
  }

  /// `Video Id`
  String get video_id {
    return Intl.message(
      'Video Id',
      name: 'video_id',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for completing our survey.`
  String get thank_you_for_survey {
    return Intl.message(
      'Thank you for completing our survey.',
      name: 'thank_you_for_survey',
      desc: '',
      args: [],
    );
  }

  /// `Powered By`
  String get powered_by {
    return Intl.message(
      'Powered By',
      name: 'powered_by',
      desc: '',
      args: [],
    );
  }

  /// `For You`
  String get for_you {
    return Intl.message(
      'For You',
      name: 'for_you',
      desc: '',
      args: [],
    );
  }

  /// `Package Description`
  String get package_description {
    return Intl.message(
      'Package Description',
      name: 'package_description',
      desc: '',
      args: [],
    );
  }

  /// `Select Package`
  String get select_package {
    return Intl.message(
      'Select Package',
      name: 'select_package',
      desc: '',
      args: [],
    );
  }

  /// `We will contact you very quickly to plan the days and hours`
  String get called_by_our_hospital {
    return Intl.message(
      'We will contact you very quickly to plan the days and hours',
      name: 'called_by_our_hospital',
      desc: '',
      args: [],
    );
  }

  /// `https://www.guven.com.tr/8-mart/mesafeli-satis-sozlesmesi`
  String get package_distance_sale_contract {
    return Intl.message(
      'https://www.guven.com.tr/8-mart/mesafeli-satis-sozlesmesi',
      name: 'package_distance_sale_contract',
      desc: '',
      args: [],
    );
  }

  /// `https://www.guven.com.tr/8-mart/on-bilgilendirme-formu`
  String get package_information_form {
    return Intl.message(
      'https://www.guven.com.tr/8-mart/on-bilgilendirme-formu',
      name: 'package_information_form',
      desc: '',
      args: [],
    );
  }

  /// `Buy Package`
  String get buy_package {
    return Intl.message(
      'Buy Package',
      name: 'buy_package',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get add_cart {
    return Intl.message(
      'Add to Cart',
      name: 'add_cart',
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

  /// `The product has been added to the cart. Would you like to view the cart?`
  String get addcart_success_message {
    return Intl.message(
      'The product has been added to the cart. Would you like to view the cart?',
      name: 'addcart_success_message',
      desc: '',
      args: [],
    );
  }

  /// `Information Form`
  String get information_form {
    return Intl.message(
      'Information Form',
      name: 'information_form',
      desc: '',
      args: [],
    );
  }

  /// `Date Filter : `
  String get date_filter {
    return Intl.message(
      'Date Filter : ',
      name: 'date_filter',
      desc: '',
      args: [],
    );
  }

  /// `Has Result`
  String get has_result {
    return Intl.message(
      'Has Result',
      name: 'has_result',
      desc: '',
      args: [],
    );
  }

  /// `Result Detail`
  String get result_detail {
    return Intl.message(
      'Result Detail',
      name: 'result_detail',
      desc: '',
      args: [],
    );
  }

  /// `Pathology\nResults`
  String get pathology_result {
    return Intl.message(
      'Pathology\nResults',
      name: 'pathology_result',
      desc: '',
      args: [],
    );
  }

  /// `Laboratory\nResults`
  String get laboratory_result {
    return Intl.message(
      'Laboratory\nResults',
      name: 'laboratory_result',
      desc: '',
      args: [],
    );
  }

  /// `Radiology\nResults`
  String get radiology_result {
    return Intl.message(
      'Radiology\nResults',
      name: 'radiology_result',
      desc: '',
      args: [],
    );
  }

  /// `Test Name`
  String get test_name {
    return Intl.message(
      'Test Name',
      name: 'test_name',
      desc: '',
      args: [],
    );
  }

  /// `Group Name`
  String get group_name {
    return Intl.message(
      'Group Name',
      name: 'group_name',
      desc: '',
      args: [],
    );
  }

  /// `Approved Date`
  String get approved_date {
    return Intl.message(
      'Approved Date',
      name: 'approved_date',
      desc: '',
      args: [],
    );
  }

  /// `View Detailed Report`
  String get detailed_report {
    return Intl.message(
      'View Detailed Report',
      name: 'detailed_report',
      desc: '',
      args: [],
    );
  }

  /// `Se??ilen tarihler i??in sonu?? bulunamad??. Tarih aral??????n??z?? de??i??tirebilirsiniz.`
  String get no_result_selected_date {
    return Intl.message(
      'Se??ilen tarihler i??in sonu?? bulunamad??. Tarih aral??????n??z?? de??i??tirebilirsiniz.',
      name: 'no_result_selected_date',
      desc: '',
      args: [],
    );
  }

  /// `De??er`
  String get value {
    return Intl.message(
      'De??er',
      name: 'value',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get try_again {
    return Intl.message(
      'Try Again',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `G??ven Hospital Ayranc??`
  String get guven_hospital_ayranci {
    return Intl.message(
      'G??ven Hospital Ayranc??',
      name: 'guven_hospital_ayranci',
      desc: '',
      args: [],
    );
  }

  /// `G??ven ??ayyolu Campus`
  String get guven_cayyolu_campus {
    return Intl.message(
      'G??ven ??ayyolu Campus',
      name: 'guven_cayyolu_campus',
      desc: '',
      args: [],
    );
  }

  /// `Package Detail`
  String get package_detail {
    return Intl.message(
      'Package Detail',
      name: 'package_detail',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to rate your appointment ?`
  String get rate_appointment {
    return Intl.message(
      'Would you like to rate your appointment ?',
      name: 'rate_appointment',
      desc: '',
      args: [],
    );
  }

  /// `How was the quality of the video call ?`
  String get how_video_quality {
    return Intl.message(
      'How was the quality of the video call ?',
      name: 'how_video_quality',
      desc: '',
      args: [],
    );
  }

  /// `Are you satisfied with your doctor ?`
  String get how_video_doctor {
    return Intl.message(
      'Are you satisfied with your doctor ?',
      name: 'how_video_doctor',
      desc: '',
      args: [],
    );
  }

  /// `Your Comments and Suggestions`
  String get comments_and_suggestion {
    return Intl.message(
      'Your Comments and Suggestions',
      name: 'comments_and_suggestion',
      desc: '',
      args: [],
    );
  }

  /// `(Bad 1 ??? 5 Very Good)`
  String get video_call_legand {
    return Intl.message(
      '(Bad 1 ??? 5 Very Good)',
      name: 'video_call_legand',
      desc: '',
      args: [],
    );
  }

  /// `(Not Satisfied 1 ??? 5 Very Satisfied)`
  String get doctor_legand {
    return Intl.message(
      '(Not Satisfied 1 ??? 5 Very Satisfied)',
      name: 'doctor_legand',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get rate {
    return Intl.message(
      'Rate',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Requests and Suggestions`
  String get request_and_suggestions {
    return Intl.message(
      'Requests and Suggestions',
      name: 'request_and_suggestions',
      desc: '',
      args: [],
    );
  }

  /// `This Form; In order to provide you with a better service, it has been prepared for you to report the problems / suggestions you have experienced and observed in application and your thanks. Your notification will be examined by the Hospital Management as soon as possible, and you will be informed about the measures taken and the arrangements to be made. Thank you for your interest and contribution.`
  String get request_and_suggestions_text {
    return Intl.message(
      'This Form; In order to provide you with a better service, it has been prepared for you to report the problems / suggestions you have experienced and observed in application and your thanks. Your notification will be examined by the Hospital Management as soon as possible, and you will be informed about the measures taken and the arrangements to be made. Thank you for your interest and contribution.',
      name: 'request_and_suggestions_text',
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

  /// `Within the scope of this application, no medical procedure (such as examination, diagnosis, diagnosis, treatment) is offered or promised to you. In addition to using the application, you should be examined by a physician before making any health-related decision. All responsibility for the use of the application belongs to you, the application is provided "as is" and no guarantee is given to you. The service provided to you within the scope of the application is by no means the equivalent of being examined by a physician or following your health condition one-to-one by a physician. You should consult your physician for medical diagnosis and treatment, do not delay your controls, and apply to the nearest emergency room without wasting time in any emergency. Otherwise, we will not accept any responsibility.`
  String get application_consent_form_text {
    return Intl.message(
      'Within the scope of this application, no medical procedure (such as examination, diagnosis, diagnosis, treatment) is offered or promised to you. In addition to using the application, you should be examined by a physician before making any health-related decision. All responsibility for the use of the application belongs to you, the application is provided "as is" and no guarantee is given to you. The service provided to you within the scope of the application is by no means the equivalent of being examined by a physician or following your health condition one-to-one by a physician. You should consult your physician for medical diagnosis and treatment, do not delay your controls, and apply to the nearest emergency room without wasting time in any emergency. Otherwise, we will not accept any responsibility.',
      name: 'application_consent_form_text',
      desc: '',
      args: [],
    );
  }

  /// `Application Consent Form`
  String get application_consent_form {
    return Intl.message(
      'Application Consent Form',
      name: 'application_consent_form',
      desc: '',
      args: [],
    );
  }

  /// `You have to confirm the application consent form.`
  String get approve_consent_form {
    return Intl.message(
      'You have to confirm the application consent form.',
      name: 'approve_consent_form',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your interest and contribution`
  String get suggestion_thanks_message {
    return Intl.message(
      'Thank you for your interest and contribution',
      name: 'suggestion_thanks_message',
      desc: '',
      args: [],
    );
  }

  /// `Awards`
  String get awards {
    return Intl.message(
      'Awards',
      name: 'awards',
      desc: '',
      args: [],
    );
  }

  /// `Trainings`
  String get trainings {
    return Intl.message(
      'Trainings',
      name: 'trainings',
      desc: '',
      args: [],
    );
  }

  /// `Memberships`
  String get memberships {
    return Intl.message(
      'Memberships',
      name: 'memberships',
      desc: '',
      args: [],
    );
  }

  /// `Treatments`
  String get treatments {
    return Intl.message(
      'Treatments',
      name: 'treatments',
      desc: '',
      args: [],
    );
  }

  /// `Treatment`
  String get treatment {
    return Intl.message(
      'Treatment',
      name: 'treatment',
      desc: '',
      args: [],
    );
  }

  /// `Specialities`
  String get specialities {
    return Intl.message(
      'Specialities',
      name: 'specialities',
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

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get free {
    return Intl.message(
      'Free',
      name: 'free',
      desc: '',
      args: [],
    );
  }

  /// `Date range:`
  String get range {
    return Intl.message(
      'Date range:',
      name: 'range',
      desc: '',
      args: [],
    );
  }

  /// `The appointment has not been paid for, you have to pay to attend the appointment, do you want to continue?`
  String get payment_question_tag {
    return Intl.message(
      'The appointment has not been paid for, you have to pay to attend the appointment, do you want to continue?',
      name: 'payment_question_tag',
      desc: '',
      args: [],
    );
  }

  /// `The entered Identity number does not match your registration information`
  String get doesnt_match_tc {
    return Intl.message(
      'The entered Identity number does not match your registration information',
      name: 'doesnt_match_tc',
      desc: '',
      args: [],
    );
  }

  /// `In order to use this feature, you need to enter your ID/passport number.`
  String get necessary_identity_message {
    return Intl.message(
      'In order to use this feature, you need to enter your ID/passport number.',
      name: 'necessary_identity_message',
      desc: '',
      args: [],
    );
  }

  /// `T.C Identity/Passport Number/Email`
  String get email_or_identity {
    return Intl.message(
      'T.C Identity/Passport Number/Email',
      name: 'email_or_identity',
      desc: '',
      args: [],
    );
  }

  /// `No suitable appointment was found for this doctor. To contact us, please call us.`
  String get appo_suitability {
    return Intl.message(
      'No suitable appointment was found for this doctor. To contact us, please call us.',
      name: 'appo_suitability',
      desc: '',
      args: [],
    );
  }

  /// `444 94 94`
  String get phone_guven {
    return Intl.message(
      '444 94 94',
      name: 'phone_guven',
      desc: '',
      args: [],
    );
  }

  /// `Health Counseling Line`
  String get free_consultation_appointment {
    return Intl.message(
      'Health Counseling Line',
      name: 'free_consultation_appointment',
      desc: '',
      args: [],
    );
  }

  /// `You can have a different appointment on the same date or time,`
  String get detailed_error_dialog_part1 {
    return Intl.message(
      'You can have a different appointment on the same date or time,',
      name: 'detailed_error_dialog_part1',
      desc: '',
      args: [],
    );
  }

  /// `You may already have an appointment with the doctor you want to make an appointment with,`
  String get detailed_error_dialog_part2 {
    return Intl.message(
      'You may already have an appointment with the doctor you want to make an appointment with,',
      name: 'detailed_error_dialog_part2',
      desc: '',
      args: [],
    );
  }

  /// `If you think there is a different problem, you can call us at the number below.`
  String get detailed_error_dialog_part3 {
    return Intl.message(
      'If you think there is a different problem, you can call us at the number below.',
      name: 'detailed_error_dialog_part3',
      desc: '',
      args: [],
    );
  }

  /// `I have read and understood the notice of information regarding the policy of protection and processing of personal data.`
  String get read_understood_kvkk {
    return Intl.message(
      'I have read and understood the notice of information regarding the policy of protection and processing of personal data.',
      name: 'read_understood_kvkk',
      desc: '',
      args: [],
    );
  }

  /// `https://www.guven.com.tr/online-doktor-e-konsultasyon/kvkk-aydinlatma-metni`
  String get kvkk_url {
    return Intl.message(
      'https://www.guven.com.tr/online-doktor-e-konsultasyon/kvkk-aydinlatma-metni',
      name: 'kvkk_url',
      desc: '',
      args: [],
    );
  }

  /// `You must read and approve the information notice regarding the policy on the protection and processing of personal data.`
  String get must_clicked_kvkk {
    return Intl.message(
      'You must read and approve the information notice regarding the policy on the protection and processing of personal data.',
      name: 'must_clicked_kvkk',
      desc: '',
      args: [],
    );
  }

  /// `Password Must contain at least 1 lowercase letter`
  String get must_contain_lowercase {
    return Intl.message(
      'Password Must contain at least 1 lowercase letter',
      name: 'must_contain_lowercase',
      desc: '',
      args: [],
    );
  }

  /// `Password Must contain at least 1 uppercase letter`
  String get must_contain_uppercase {
    return Intl.message(
      'Password Must contain at least 1 uppercase letter',
      name: 'must_contain_uppercase',
      desc: '',
      args: [],
    );
  }

  /// `My Children`
  String get kids {
    return Intl.message(
      'My Children',
      name: 'kids',
      desc: '',
      args: [],
    );
  }

  /// `Countries`
  String get country {
    return Intl.message(
      'Countries',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Password Must contain at least 1 special character.`
  String get must_contain_special {
    return Intl.message(
      'Password Must contain at least 1 special character.',
      name: 'must_contain_special',
      desc: '',
      args: [],
    );
  }

  /// `Password Must contain at least 1 digit`
  String get must_contain_digit {
    return Intl.message(
      'Password Must contain at least 1 digit',
      name: 'must_contain_digit',
      desc: '',
      args: [],
    );
  }

  /// `Password length must be at least 8 characters`
  String get password_must_8_char {
    return Intl.message(
      'Password length must be at least 8 characters',
      name: 'password_must_8_char',
      desc: '',
      args: [],
    );
  }

  /// `ONLINE DOCTOR AND E-CONSULTATION INFORMATIONAL TEXT ON PERSONAL DATA PROTECTION`
  String get kvkk_title {
    return Intl.message(
      'ONLINE DOCTOR AND E-CONSULTATION INFORMATIONAL TEXT ON PERSONAL DATA PROTECTION',
      name: 'kvkk_title',
      desc: '',
      args: [],
    );
  }

  /// `We as G??ven Hastanesi A.??. seated at the address of "Remzi O??uz Ar??k Mahallesi Paris Cad. No:58 ??ankaya Ankara??? place great value on the confidentiality and protection of your personal data. We would like to inform you of our personal data protection policies within the context of the Personal Data Protection Law No. 6698 (PDPL).\n\nWe are deemed as a Data Controller for the personal data we collect from you in due course of performance of our activities. As the Data Controller, your personal information may, within the framework described below, be recorded verbally, in writing or electronically, stored, updated, categorized, be divulged and / or transferred to third parties and / or abroad where permitted by legislation, and processed in other ways set out under the PDPL. \n\nThe purpose and legal reason for the processing of personal data is to prepare all records and documents that will be the basis of a transaction conducted electronically or on paper; to abide by information retention and reporting obligations and obligations to inform set out by legislation and the relevant authorities; to provide requested products and services and to perform and deliver the goods and services and performing the agreement which you have signed. \n\nTo provide better services to our customers, we request certain personal information from you (such as name, age, interests, e-mail information etc.). This information, collated in our servers, is stored, and utilized for the purposes of ???categorizing??? customers for seasonal promotional campaign works, preparing private promotion activities directed at customer profiles and preventing the sending of unwanted e-mails, and for the continuation of advertisement, promotion and marketing activities prepared over personal information. \n\nWe may process and store your personal data for the confirmation of identity of persons shopping in person or through a third party over the web site and mobile applications, to record addresses and other necessary information for communication, to contact our customers for the terms and conditions, status and updates on distance sales agreements and agreements concluded pursuant to the relevant provisions of the Consumer Protection Law, to relay necessary information, to prepare all records and documents that will be the basis of a transaction conducted electronically (internet / mobile etc.) or on paper, to perform our obligations assumed under distance sales agreements and agreements concluded pursuant to the relevant provisions of the Consumer Protection Law, to inform public officials on issues of public security upon request or pursuant to legislation, to provide for a better shopping experience for our customers, to inform our customers on products they might be interested in having considered their interests, to relay promotional campaigns, to enhance customer satisfaction, to recognize customers shopping on the web site and / or mobile applications and use these for customer portfolio analyses, for various promotional campaigns or advertisements and in this context for surveys conducted physically and / or electronically by way of service providers, to offer proposals to our customers from our in-network providers and service providers, to inform our customers as to our services, to evaluate customer suggestions and complaints on our services, to perform our legal obligations and to utilize our rights deriving from the laws in effect. \n\nFor the purposes set out above, persons or institutions to whom personal data might be transmitted are listed as our majority shareholder, our direct and / or indirect subsidiaries within the country or abroad; our business partner institutions with whom we collaborate and retain services to perform our activities, and business partners and other third parties for whom you consent pursuant to the Confidentiality Agreement. \n\nFor the purposes set out above, and for the services that will be rendered by our Company, your personal data might be collected, processed, recorded, stored, amended, updated, periodically reviewed, rearranged, categorized and secured verbally, in writing or through electronic means while logging in to the G??ven Online application, during your use of the application, over applications made to G??ven Hastanesi A.??. and to G??ven ??ayyolu Medical Center, through affiliates, by public institutions and organizations, automatically and non-automatically, by our company units and offices, through our internet site, our call center, social media venues, mobile applications, by business partners, suppliers, service providers and by other similar means. \n\nPursuant to Article 11 of PDPL, you have a right to file an application with G??ven Hastanesi A.??. for the purposes of a) being informed as to whether or not your personal data is being processed, b) requesting information if it is being processed, c) being informed as to the purpose of processing and whether or not it is being processed in line with this purpose, d) requesting information on third parties within the country or abroad to whom your data is transmitted, e) requesting a correction if it is incorrectly or inaccurately processed, f) requesting an erasure or destruction pursuant to the conditions set out under Article 7 of the PDPL, g) requesting the notification of the procedures carried out under subclauses (e) and (f) above to third parties to whom data was transmitted, h) objecting to any adverse conclusions drawn due to the analysis of data exclusively through automatic systems, and i) requesting compensation if you incur damages due to unlawful processing of your personal data. \n\nOur e-mail and correspondence address to which you may send your request on the use of your rights is as below: \nguven@guven.com.tr\nRemzi O??uz Ar??k Mahallesi Paris Cad. No:58 ??ankaya Ankara  \n\nIf the reasons for the processing of personal data cease, then, even where personal data was processed pursuant to the Law No. 6698 and other relevant provisions, your personal data will, by our company or upon your request, be erased, destroyed, or anonymized. However, pursuant to Law No. 6563 on the Regulation of Electronic Commerce, any records on the withdrawal of consent must be maintained for a term of 1 year as of the withdrawal date, and any record on the content and relaying of electronic transmissions have to be maintained for a term of 3 years to be submitted to the relevant Ministry where required. Following the expiry of this term, your personal data, by our company or upon your request, will be erased, destroyed, or anonymized. \n\nRespectfully submitted for your information.\nG??VEN HASTANES?? A.??.\n`
  String get kvkk_url_text {
    return Intl.message(
      'We as G??ven Hastanesi A.??. seated at the address of "Remzi O??uz Ar??k Mahallesi Paris Cad. No:58 ??ankaya Ankara??? place great value on the confidentiality and protection of your personal data. We would like to inform you of our personal data protection policies within the context of the Personal Data Protection Law No. 6698 (PDPL).\n\nWe are deemed as a Data Controller for the personal data we collect from you in due course of performance of our activities. As the Data Controller, your personal information may, within the framework described below, be recorded verbally, in writing or electronically, stored, updated, categorized, be divulged and / or transferred to third parties and / or abroad where permitted by legislation, and processed in other ways set out under the PDPL. \n\nThe purpose and legal reason for the processing of personal data is to prepare all records and documents that will be the basis of a transaction conducted electronically or on paper; to abide by information retention and reporting obligations and obligations to inform set out by legislation and the relevant authorities; to provide requested products and services and to perform and deliver the goods and services and performing the agreement which you have signed. \n\nTo provide better services to our customers, we request certain personal information from you (such as name, age, interests, e-mail information etc.). This information, collated in our servers, is stored, and utilized for the purposes of ???categorizing??? customers for seasonal promotional campaign works, preparing private promotion activities directed at customer profiles and preventing the sending of unwanted e-mails, and for the continuation of advertisement, promotion and marketing activities prepared over personal information. \n\nWe may process and store your personal data for the confirmation of identity of persons shopping in person or through a third party over the web site and mobile applications, to record addresses and other necessary information for communication, to contact our customers for the terms and conditions, status and updates on distance sales agreements and agreements concluded pursuant to the relevant provisions of the Consumer Protection Law, to relay necessary information, to prepare all records and documents that will be the basis of a transaction conducted electronically (internet / mobile etc.) or on paper, to perform our obligations assumed under distance sales agreements and agreements concluded pursuant to the relevant provisions of the Consumer Protection Law, to inform public officials on issues of public security upon request or pursuant to legislation, to provide for a better shopping experience for our customers, to inform our customers on products they might be interested in having considered their interests, to relay promotional campaigns, to enhance customer satisfaction, to recognize customers shopping on the web site and / or mobile applications and use these for customer portfolio analyses, for various promotional campaigns or advertisements and in this context for surveys conducted physically and / or electronically by way of service providers, to offer proposals to our customers from our in-network providers and service providers, to inform our customers as to our services, to evaluate customer suggestions and complaints on our services, to perform our legal obligations and to utilize our rights deriving from the laws in effect. \n\nFor the purposes set out above, persons or institutions to whom personal data might be transmitted are listed as our majority shareholder, our direct and / or indirect subsidiaries within the country or abroad; our business partner institutions with whom we collaborate and retain services to perform our activities, and business partners and other third parties for whom you consent pursuant to the Confidentiality Agreement. \n\nFor the purposes set out above, and for the services that will be rendered by our Company, your personal data might be collected, processed, recorded, stored, amended, updated, periodically reviewed, rearranged, categorized and secured verbally, in writing or through electronic means while logging in to the G??ven Online application, during your use of the application, over applications made to G??ven Hastanesi A.??. and to G??ven ??ayyolu Medical Center, through affiliates, by public institutions and organizations, automatically and non-automatically, by our company units and offices, through our internet site, our call center, social media venues, mobile applications, by business partners, suppliers, service providers and by other similar means. \n\nPursuant to Article 11 of PDPL, you have a right to file an application with G??ven Hastanesi A.??. for the purposes of a) being informed as to whether or not your personal data is being processed, b) requesting information if it is being processed, c) being informed as to the purpose of processing and whether or not it is being processed in line with this purpose, d) requesting information on third parties within the country or abroad to whom your data is transmitted, e) requesting a correction if it is incorrectly or inaccurately processed, f) requesting an erasure or destruction pursuant to the conditions set out under Article 7 of the PDPL, g) requesting the notification of the procedures carried out under subclauses (e) and (f) above to third parties to whom data was transmitted, h) objecting to any adverse conclusions drawn due to the analysis of data exclusively through automatic systems, and i) requesting compensation if you incur damages due to unlawful processing of your personal data. \n\nOur e-mail and correspondence address to which you may send your request on the use of your rights is as below: \nguven@guven.com.tr\nRemzi O??uz Ar??k Mahallesi Paris Cad. No:58 ??ankaya Ankara  \n\nIf the reasons for the processing of personal data cease, then, even where personal data was processed pursuant to the Law No. 6698 and other relevant provisions, your personal data will, by our company or upon your request, be erased, destroyed, or anonymized. However, pursuant to Law No. 6563 on the Regulation of Electronic Commerce, any records on the withdrawal of consent must be maintained for a term of 1 year as of the withdrawal date, and any record on the content and relaying of electronic transmissions have to be maintained for a term of 3 years to be submitted to the relevant Ministry where required. Following the expiry of this term, your personal data, by our company or upon your request, will be erased, destroyed, or anonymized. \n\nRespectfully submitted for your information.\nG??VEN HASTANES?? A.??.\n',
      name: 'kvkk_url_text',
      desc: '',
      args: [],
    );
  }

  /// `According to our security policies, your password must comply with the security criteria.`
  String get password_security {
    return Intl.message(
      'According to our security policies, your password must comply with the security criteria.',
      name: 'password_security',
      desc: '',
      args: [],
    );
  }

  /// `You need to check the information form to continue`
  String get check_information {
    return Intl.message(
      'You need to check the information form to continue',
      name: 'check_information',
      desc: '',
      args: [],
    );
  }

  /// `You need to check the cancellation and refund conditions to continue`
  String get check_cancellation_refund {
    return Intl.message(
      'You need to check the cancellation and refund conditions to continue',
      name: 'check_cancellation_refund',
      desc: '',
      args: [],
    );
  }

  /// `??N B??LG??LEND??RME FORMU\nG??ncelleme: 16.09.2021\nMADDE 1: TARAFLAR ve KONU\n1.\t????bu Mesafeli Sat???? S??zle??mesi ??n Bilgilendirme Formu???nun (???Bilgilendirme Formu???) taraflar?? a??a????daki gibidir: \nSATICI (???G??ven Hastanesi???) \nTicari Unvan??\t: G??ven Hastanesi A.??.\nAdresi\t\t: Remzi O??uz Ar??k Mahallesi Paris Cad. No:58 ??ankaya Ankara\nTelefon \t\t: 444 94 94\nE-mail \t\t: guven@guven.com.tr\nMERS??S No\t: 0451001685100012\nALICI (???Al??c?????)\nAd?? Soyad?? \t: <userName>\nAdresi \t\t: <adress>\nTelefon \t\t: <phoneNumber>\nE-mail \t\t: <email>\nAl??c?? ve G??ven Hastanesi bundan b??yle ayr?? ayr?? ???Taraf??? ve birlikte ???Taraflar??? olarak an??labilecektir.\n2.\tG??ven Hastanesi, 27166 say?? ve 11.03.2009 tarihli Resmi Gazete???de yay??mlanarak y??r??rl????e giren "??zel Hastaneler Y??netmeli??i" ve sair mevzuatta belirtilen ??artlar?? ta????yan, ??e??itli uzmanl??k dallar??nda hastalara ayakta ve yat??rarak muayene, te??his ve tedavi hizmeti sunan, Ankara???da Paris Caddesi No: 58 Kavakl??dere Ankara adresinde mukim ??zel bir hastanedir. \n3.\t????bu Bilgilendirme Formu 6502 Say??l?? T??keticinin Korunmas?? Hakk??nda Kanun (???Kanun???) ve Mesafeli S??zle??meler Y??netmeli??i???ne uygun olarak d??zenlenmi??tir. ????bu Bilgilendirme Formu, Al??c?????n??n G??ven Hastanesi???ne ait web sitesi ve telefon uygulamalar?? (???Online Platform???) ??zerinden i??bu Bilgilendirme Formu Madde 2.2???de belirtilen sa??l??k hizmeti paketini (???Hizmet Paketi???) sat??n almas??nda Taraflar??n kar????l??kl?? hak ve y??k??ml??l??klerini d??zenlemektedir.  \n4.\t????bu Bilgilendirme Formu???nun Taraflar?? i??bu Bilgilendirme Formu taht??nda Kanun???dan ve Mesafeli S??zle??meler Y??netmeli??i???nden kaynaklanan y??k??ml??l??k ve sorumluluklar??n?? bildiklerini ve anlad??klar??n?? kabul ve beyan ederler.\n5.\tAl??c??, i??bu Bilgilendirme Formu???nu elektronik ortamda teyit etmekle, mesafeli s??zle??melerin akdinden ??nce G??ven Hastanesi taraf??ndan Al??c?????ya verilmesi gereken adres, sipari??i verilen hizmete ait temel ??zellikler, hizmetin vergiler dahil fiyat?? ve ??deme bilgilerini de do??ru ve eksiksiz olarak edindi??ini teyit etmi?? olur.\nMADDE 2: S??ZLE??ME KONUSUNUN TEMEL N??TEL??KLER?? VE BEDEL?? \n1.\tHizmet Paketi???nin temel ??zellikleri Online Platform???da yer almaktad??r ve Online Platform???da incelenebilecektir. Hizmet Paketi???nin ???online g??r????me??? olmas?? halinde Hizmet Paketi, hasta ve hekimin bir arada bulunmas?? gereken durumlarda muayenenin bir muadili olmay??p, Al??c?????ya sadece Online Platform???da se??ilen hekime dan????ma ve kons??ltasyon imkan?? sunulacakt??r. \n2.\tAl??c?? taraf??ndan i??bu Bilgilendirme Formu kapsam??nda sat??n al??nacak olan Hizmet Paketi???ne ili??kin bilgiler a??a????daki ??ekildedir:\nHizmet Paketi A????klamas??\tAdet\tBirim Fiyat??\tAra Toplam\n(KDV Dahil)\n\t\t\t\n<packageName>\t\t\t\nToplam :\t\n\n??deme ??ekli ve Plan??\t: <paymentPlan>\nFatura Adresi\t\t: <adress>\nTeslimat Adresi\t\t: <adress>\nTeslim Edilecek Ki??i\t: <userName>\nSat??n Alma Tarihi\t: <currentDate>\n3.\tOnline Platform???da ilan edilen fiyatlar sat???? fiyat??d??r. ??lan edilen fiyatlar ve vaatler g??ncelleme yap??lana ve de??i??tirilene kadar ge??erlidir. S??reli olarak ilan edilen fiyatlar ise belirtilen s??re sonuna kadar ge??erlidir.\n4.\tG??ven Hastanesi, Al??c?????n??n Online Platform ??zerinden onaylayarak sat??n ald?????? Hizmet Paketi???ni en ge?? 24 saat i??inde i??leme alarak ilgili birimlerine iletir.\n5.\tHizmet, G??ven Hastanesi taraf??ndan m??mk??n olan en k??sa s??rede ve en ge?? 7 (yedi) i?? g??n?? i??inde Al??c?????ya sunulur. Hizmet Paketi???nin tek seferde kullan??lmakla t??kenecek bir hizmete ili??kin olmas?? halinde Hizmet Paketi???nin Al??c?? taraf??ndan <expirationDate> tarihine kadar kullan??lmas?? gerekmektedir. Hizmet Paketi???nin devaml??l?????? olan bir hizmete y??nelik, d??nemli bir hizmete ili??kin olmas?? halinde ise Al??c?? taraf??ndan Hizmet Paketi???nin kullan??m??na <currentDate> tarihine kadar ba??lan??lm???? olmas?? ve bu tarihten itibaren 3 (????) ay i??erisinde Hizmet Paketi???nin tamamen kullan??lmas?? gerekir. ????bu maddede belirtilen tarihlere kadar kullan??lmayan Hizmet Paketi belirtilen tarihlerden sonra kullan??lamaz ve bu hususta Al??c?????ya herhangi bir ??deme / geri ??deme yap??lmayaca???? gibi, Al??c?????n??n herhangi bir talep hakk?? da bulunmayacakt??r.\n6.\tG??ven Hastanesi???nden kaynaklanmayan sebeplerle gecikmelerin ya??anmas?? halinde G??ven Hastanesi durumu derhal Al??c?????ya bildirir. \n7.\tAl??c?????n??n sat??n ald?????? Hizmet Paketi???nin pe??in veya vadeli fiyat?? sipari?? formunda yer al??r, Al??c?? taraf??ndan onaylan??r ve sipari?? sonunda Al??c?????n??n e-posta adresine e-fatura olarak g??nderilir. Yap??lan indirimler ve promosyonlar sat???? fiyat??na yans??t??l??r.\n8.\tHizmet Paketi???nin Al??c?????ya fiziki teslimat gerektirmesi halinde, teslimat masraflar?? aksi G??ven Hastanesi taraf??ndan beyan edilmedi??i m??ddet??e Al??c?????ya aittir. Bu durumda G??ven Hastanesi Hizmet Paketi???ni sipari?? tarihinden itibaren 30 (otuz) g??n i??inde teslim eder. G??ven Hastanesi bu s??re i??inde yaz??l?? bildirimle ek 10 (on) g??nl??k s??re uzat??m hakk??n?? sakl?? tutar. Hizmet Paketi???nin arac?? posta veya kargo ??irketine teslim edilmesi ile hasardan sorumluluk Al??c?????ya ge??er.\n9.\tMesafeli sat???? s??zle??mesi Al??c?? taraf??ndan Online Platform ??zerinden onaylanmakla y??r??rl????e girer ve Al??c?????n??n G??ven Hastanesi???nden sat??n alm???? oldu??u Hizmet Paketi???nin Al??c?????ya online ve/veya fiziksel ortamda sunulmas?? ile ifa edilmi?? olur. \n10.\tHizmet Paketi, Al??c?????n??n sipari?? formunda ve mesafeli sat???? s??zle??mesinde belirtmi?? oldu??u adreste bulunan ki??i/ki??ilere teslim edilecektir.\nMADDE 3: ALICININ BEYAN VE TAAHH??TLER??\n1.\tAl??c??, Hizmet Paketi???nin nitelikleri, t??m vergiler dahil sat???? fiyat??, ??deme ??ekli, teslimat ve cayma hakk?? ile kullan??m ??artlar??na ili??kin olarak ??n bilgilerin taraf??na ula??t??????n??, G??ven Hastanesi taraf??ndan kendisine Online Platform ??zerinden sunulan bilgileri okudu??unu, anlad??????n??, eksiksiz olarak bilgilendi??ini, elektronik ortamda teyit etti??ini ve elektronik ortamda sat???? i??in gerekli onaylar?? verdi??ini beyan eder. \n2.\t????bu Bilgilendirme Formu???nu kabul etmekle Al??c??, s??zle??me konusu Hizmet Paketi???ni onaylad?????? takdirde Hizmet Paketi???nin bedeli ve vergi gibi belirtilen ek ??cretleri ??deme y??k??ml??l?????? alt??na girece??ini ve bu konuda bilgilendirildi??ini pe??inen kabul eder.\n3.\tAl??c??, se??mi?? oldu??u Hizmet Paketi???nin gereklerinin ifa edilebilmesi i??in 6698 say??l?? Ki??isel Verileri Koruma Kanunu uyar??nca ??zel nitelikli ki??isel veri say??lan sa??l??k verilerinin Hizmet Paketi kapsam??ndaki hizmetin ifas?? amac?? ile s??n??rl?? olmak kayd??yla i??lenmesine a????k olarak r??za g??stermektedir.  \n4.\tAl??c??, talep ve ??ik??yetlerini G??ven Hastanesi???nin yukar??da yer alan ileti??im kanallar??na ula??t??rabilir. G??ven Hastanesi, talep ve ??ik??yetleri de??erlendirerek Al??c?????ya en k??sa zamanda geri d??n???? yapar. \n5.\tAl??c??, herhangi bir nedenle s??zle??me konusu Hizmet Paketi???nin bedelinin ??denmemesi ve/veya banka kay??tlar??nda iptal edilmesi halinde, G??ven Hastanesi???nin s??zle??me konusu Hizmet Paketi???ni ifa ve/veya teslim y??k??ml??l??????n??n sona erece??ini kabul, beyan ve taahh??t eder.\n6.\tAl??c??, i??bu Bilgilendirme Formu???nu ve mesafeli sat???? s??zle??mesini kabul ederken en az 18 ya????nda oldu??unu veya ilgili ??lke mevzuat??na g??re i??bu Bilgilendirme Formu???nu ve mesafeli sat???? s??zle??mesini akdetmeye uygun ya??ta oldu??unu, k??s??tl?? olmad??????n?? ve i??bu Bilgilendirme Formu???nu ve mesafeli sat???? s??zle??mesini akdetmeye yetkili oldu??unu kabul ve beyan eder. Al??c?????n??n i??bu maddede belirtilen ya?? s??n??r??ndan daha k??????k oldu??unun, k??s??tl?? oldu??unun veya sair surette i??bu Bilgilendirme Formu???nu ve/veya mesafeli sat???? s??zle??mesini akdetmeye yetkili olmad??????n??n tespiti halinde mesafeli sat???? s??zle??mesi G??ven Hastanesi taraf??ndan derhal feshedilebilir ve Al??c?????ya veya yasal temsilcisine herhangi bir ??deme iadesi yap??lmaz.\n7.\tHizmet Paketi???nin ???online g??r????me??? olmas?? halinde Al??c?????n??n, randevu saatinden en ge?? 5 (be??) dakika ??nce G??ven Online uygulamas??na giri?? yapmas??, ba??lant??ya haz??r durumda olmas?? ve hekimle g??r????meyi ba??latm???? olmas?? gerekir. Al??c?????n??n bu maddede belirtilen ??ekilde haz??r olmamas?? ve/veya g??r????meye hi?? kat??lmamas?? halinde ilgili g??r????me yap??lm???? say??larak ??cretlendirmesi yap??l??r ve Al??c?????ya herhangi bir iade yap??lmaz.\n8.\tHizmet Paketi???nin ???online g??r????me??? olmas?? halinde Al??c?????n??n g??r??nt??l?? g??r????me yapabilmek i??in dikkat etmesi gereken hususlar ve hizmetin kullan??labilmesi i??in gereken donan??m ve yaz??l??mlara ili??kin bilgi ???https://www.guven.com.tr/online-doktor??? adresindeki ilgili b??l??mlerde yer almakta olup, bu hususlar zaman zaman G??ven Hastanesi taraf??ndan g??ncellenebilecektir. G??ncellemeleri takip etmek ve bu hususlara uymak Al??c?????n??n sorumlulu??undad??r.\n9.\tAl??c??, Ek-1: Online Doktor ve E-Kons??ltasyon Hizmetinin Kapsam?? Hakk??nda Bilgilendirme ve Ayd??nlat??lm???? Onam Belgesi???nde yer alan bilgileri okudu??unu, anlad??????n?? ve kabul etti??ini beyan ve taahh??t eder.\nMADDE 4: ??FADA SIRA, TEMERR??D HAL?? VE HUKUK?? SONU??LARI\n1.\tAl??c?????n??n ??demeyi ger??ekle??tirmesini takiben, mesafeli sat???? s??zle??mesi ko??ullar??na uygun olarak G??ven Hastanesi i??bu Bilgilendirme Formu???nda ve mesafeli sat???? s??zle??mesinde belirtilen Hizmet Paketi kapsam??ndaki hizmeti sunar. \n2.\tAl??c?? borcundan dolay?? temerr??de d????mesi halinde, borcun gecikmeli ifas??ndan dolay?? G??ven Hastanesi???nin olu??an zarar ve ziyan??n?? ??demeyi kabul eder.\nMADDE 5: CAYMA HAKKI\n1.\tAl??c??, hi??bir hukuki ve cezai sorumluluk ??stlenmeksizin ve hi??bir gerek??e g??stermeksizin, mal sat??????na ili??kin i??lemlerde teslimat tarihinden itibaren, hizmet sat??????na ili??kin i??lemlerde sat??n alma tarihinden itibaren 14 (on d??rt) g??n i??erisinde cayma hakk??n?? kullanabilir. Mal sat??????na ili??kin i??lemlerde Al??c??, mal??n teslimine kadar olan s??re i??inde de cayma hakk??n?? kullanabilir. \n2.\tHizmet Paketi kapsam??ndaki hizmetin Al??c?? taraf??ndan k??smen veya tamamen kullan??lm???? olmas?? halinde cayma hakk?? kullan??lamaz. Cayma hakk?? s??resi sona ermeden ??nce, Al??c?????n??n onay?? ile ifas??na ba??lanan hizmetler i??in de cayma hakk?? kullan??lamaz.\n3.\tAl??c?????n??n cayma hakk??n?? kullanmas??ndan itibaren 14 (on d??rt) g??n i??erisinde (mal sat??????na ili??kin i??lemlerde mal??n G??ven Hastanesi???nin iade i??in belirtti??i ta????y??c?? arac??l??????yla geri g??nderilmesi kayd??yla), Al??c?????n??n ilgili mal veya hizmete ili??kin G??ven Hastanesi???ne yapt?????? t??m ??demeler Al??c?????ya Hizmet Paketi???ni sat??n al??rken kulland?????? ??deme arac??na uygun bir ??ekilde ve Al??c?????ya herhangi bir masraf veya y??k??ml??l??k getirmeden ve tek seferde iade edilecektir.\n4.\tCayma hakk??na ili??kin bildirimler G??ven Hastanesi???ne ait <hospitalEmail> e-posta adresine yap??lacakt??r.\n5.\tCayma hakk??n??n kullan??m??ndan kaynaklanan masraflar G??ven Hastanesi???ne aittir. Al??c??, i??bu Bilgilendirme Formu???nu ve mesafeli sat???? s??zle??mesini kabul etmekle, cayma hakk?? konusunda bilgilendirildi??ini pe??inen kabul eder.\nMADDE 6: SORUMLULUK SINIRI \n1.\tAl??c?????n??n her durumda t??bbi tan??, tedavi ve hastal??klar??n ??nlenmesi i??in ??zg??r iradesiyle se??ece??i hekimine ba??vurmas??, kontrollerini aksatmamas?? ve her t??rl?? acil durumda vakit kaybetmeden en yak??n acil servise m??racaat etmesi gerekmektedir. Aksi halde G??ven Hastanesi???nin hi??bir sorumlulu??u bulunmamaktad??r.\n2.\t???Online g??r????me??? kapsam??nda G??ven Online???da yer alan hekimler taraf??ndan Al??c?????ya herhangi bir t??bbi i??lem (muayene, tan??, te??his, tedavi gibi) sunulmamakta ve vaat edilmemekte olup; G??ven Hastanesi???nin ve/veya G??ven Online???da yer alan hekimlerin t??bbi k??t?? uygulamadan (malpraktis) dolay?? herhangi bir sorumlulu??u bulunmayacakt??r.\n3.\t???Online g??r????me??? kapsam??nda G??ven Online???da yer alan hekimler, herhangi bir g??r????te bulunmu?? olmamaktad??r. ???Online g??r????me??? kapsam??nda sunulan herhangi bir bilgi veya verinin do??rulu??unu teyit etmek Al??c?????n??n y??k??ml??l?????? ve sorumlulu??undad??r. ???Online g??r????me??? kapsam??nda G??ven Hastanesi ve G??ven Online???da yer alan hekimler, G??ven Online?????n ve/veya ???online g??r????me??? ??zelli??inin kullan??lmas?? veya kullan??lmamas??, G??ven Online???da sunulan hizmetin aksamas?? veya kesintiye u??ramas?? ve mesafeli sat???? s??zle??mesindeki hizmetlerin ifas?? nedeniyle ortaya ????kabilecek herhangi bir yaralanma, bedensel zarar, maddi veya manevi zarar, k??r kayb??, i?? kayb?? veya sair her t??rl?? do??rudan ya da dolayl?? zararlardan hi??bir bi??imde sorumlu de??ildir.\n4.\tUygulanacak hukuk alt??nda izin verildi??i ??l????de, G??ven Hastanesi???nin Al??c?????n??n Hizmet Paketi ve mesafeli sat???? s??zle??mesi kapsam??ndaki herhangi bir zarar??na ili??kin sorumlulu??u, hangisi daha az ise; (i) sorumlulu??u do??uran olaydan ??nceki 1 (bir) takvim ay?? i??inde Al??c?? taraf??ndan ???G??ven Online ??zerinden??? G??ven Hastanesi???ne ??denmi?? olan Hizmet Paketi bedelleri toplam??, veya (ii) 1.000 (bin) T??rk Liras?? ile s??n??rl??d??r.\n5.\tAl??c?????n??n mesafeli sat???? s??zle??mesini ihlal ederek ??????nc?? ki??ilerin herhangi bir zarar??na sebep olmas?? halinde Al??c??, bu zarardan G??ven Hastanesi???ni masun tutacakt??r. Al??c?????dan kaynaklanan herhangi bir sebeple G??ven Hastanesi???nin herhangi bir zarara u??ramas?? halinde bu zarar Al??c?? taraf??ndan derhal nakden ve defaten tazmin edilecektir.\nMADDE 7: D????ER H??K??MLER\n1.\tMesafeli sat???? s??zle??mesi taht??nda Taraflar aras??nda yap??lacak her t??rl?? yaz????ma, mevzuatta say??lan zorunlu haller d??????nda e-posta arac??l??????yla yap??l??r. Mevzuatta yaz??l?? hallerde Taraflar??n belirtmi?? oldu??u adresleri tebligat adresleri olarak kabul edilir. 15 (on be??) g??n i??erisinde kar???? Tarafa bildirilmeyen tebligat adresi de??i??ikliklerinde tebligat usul??ne uygun olarak yap??lm???? say??l??r.\n2.\tG??ven Hastanesi, kendi kontrol?? d??????nda meydana gelen, ??ng??r??lemeyen ve ??nlenemeyen do??al afetler, yang??n, patlamalar, i?? sava??lar, sava??lar, ayaklanmalar, halk hareketleri, seferberlik ilan??, grev, lokavt ve salg??n hastal??klar gibi m??cbir sebep hallerinden dolay?? olu??abilecek herhangi bir gecikme veya y??k??ml??l??klerin ifa edilememesinden kaynaklanabilecek zarar ve ziyandan sorumlu olmayacakt??r. M??cbir sebep halinin G??ven Hastanesi???nin mesafeli sat???? s??zle??mesinde yaz??l?? y??k??ml??l??klerini do??rudan etkilemesi durumunda G??ven Hastanesi???nin mesafeli sat???? s??zle??mesini tazminats??z ve tek tarafl?? feshetme hakk?? sakl??d??r.\n3.\tBu Bilgilendirme Formu???nun ve/veya mesafeli sat???? s??zle??mesinin herhangi bir madde veya k??sm??n??n ge??ersiz, h??k??ms??z veya ifa edilemez say??lmas?? halinde, o madde veya k??s??m, onun lafzi amac??na en yak??n ve ayn?? zamanda ifa edilebilir olan bir ??ekilde ve kapsamda yorumlanacak ve uygulanacakt??r; ancak bunun m??mk??n olmamas?? halinde, o madde veya k??s??m Bilgilendirme Formu???nda ve/veya mesafeli sat???? s??zle??mesinden ayr??lm???? ve ????kart??lm???? say??lacak ve bu durum, Bilgilendirme Formu???nun ve/veya mesafeli sat???? s??zle??mesinin kalan madde ve h??k??mlerini hi??bir ??ekilde etkilemeyecek veya ge??ersiz hale getirmeyecek ve Bilgilendirme Formu???nun ve mesafeli sat???? s??zle??mesinin di??er madde ve h??k??mleri tam ge??erli ve y??r??rl??kte kalmaya devam edecektir.\n4.\tHi??bir feragat yaz??l?? olarak ve Taraflarca yap??lmad??k??a ge??erli olmayacakt??r. Taraflardan herhangi birinin mesafeli sat???? s??zle??mesinin herhangi bir h??km??n??n veya ??art??n??n sa??lanmas??n?? talep etmemesi ya da herhangi bir Taraf??n mesafeli sat???? s??zle??mesinin herhangi bir ihlalinden do??an talep hakk??ndan feragat etmesi, s??z konusu h??k??m veya ??art??n bundan sonra uygulanmas??n?? engellemeyecektir ve bir sonraki ihlalden feragat olarak say??lmayacakt??r.\n5.\tG??ven Hastanesi, mesafeli sat???? s??zle??mesinden do??an hak ve y??k??ml??l??klerini hi??bir s??n??rlama olmaks??z??n ??????nc?? ??ah??slara devretmek hakk??n?? haizdir.\n6.\tTaraflar, Bilgilendirme Formu???nun ve mesafeli sat???? s??zle??mesinin ge??erlili??i, uygulanmas?? ve yorumlanmas?? konusunda kanunlar ihtilaf??na dair kurallar hari?? olmak ??zere m??nhas??r ??ekilde T??rkiye Cumhuriyeti yasalar?? ve ilgili mevzuat??n??n uygulanaca????n?? kabul ve beyan ederler.\n7.\tBilgilendirme Formu ve mesafeli sat???? s??zle??mesi ile ilgili ????kacak ihtilaflarda; her y??l Ticaret Bakanl?????? taraf??ndan ilan edilen de??ere kadar Al??c?????n??n yerle??im yerindeki Hizmet Paketi???ni sat??n ald?????? veya ikametg??h??n??n bulundu??u yerdeki ??l veya ??l??e T??ketici Sorunlar?? Hakem Heyetleri, s??z konusu de??erin ??zerindeki ihtilaflarda ise T??ketici Mahkemeleri yetkilidir.\n8.\tBilgilendirme Formu ve mesafeli sat???? s??zle??mesinden do??abilecek ihtilaflarda G??ven Hastanesi???nin resmi defter ve ticari kay??tlar??yla, kendi veritaban??nda, sunucular??nda tuttu??u elektronik bilgiler ve bilgisayar kay??tlar??, ba??lay??c??, kesin ve m??nhas??r delil te??kil eder. Bu madde Hukuk Muhakemeleri Kanunu???nun 193. maddesi anlam??nda delil s??zle??mesi niteli??indedir.  \n9.\tALICI, G??VEN ONLINE VE S??ZLE??ME KAPSAMINDAK?? H??ZMET??N N??TEL??KLER?? VE BEDEL?? ??LE EK-1: ONLINE DOKTOR VE E-KONS??LTASYON H??ZMET??N??N KAPSAMI HAKKINDA B??LG??LEND??RME VE AYDINLATILMI?? ONAM BELGES?????NDEK?? HUSUSLARA ??L????K??N OLARAK G??VEN HASTANES?? TARAFINDAN KEND??S??NE YAPILAN B??LG??LEND??RMELER?? VE KEND?? SORUMLULUKLARINI OKUYUP ANLADI??INI, ANLAMADI??I KISIMLARIN OLMASI HAL??NDE SORU SORDU??UNU, SORULARININ YETK??L?? K??????LERCE CEVAPLANDI??INI, EKS??KS??Z OLARAK B??LG??LEND??????N?? KABUL VE BEYAN EDER.\n7 (yedi) maddeden ve 1 (bir) adet ekten ibaret i??bu Bilgilendirme Formu, Al??c?? taraf??ndan elektronik ortamda okunup onaylanmak suretiyle akdedilmi?? ve derhal y??r??rl????e girmi??tir.\n\nEk-1: Online Doktor ve E-Kons??ltasyon Hizmetinin Kapsam?? Hakk??nda Bilgilendirme ve Ayd??nlat??lm???? Onam Belgesi\n\nALICI\t                          G??VEN HASTANES?? A.??.\n\n???\nEK-1:\nONLINE DOKTOR VE E-KONS??LTASYON\nH??ZMET??N??N KAPSAMI HAKKINDA B??LG??LEND??RME\nVE\nAYDINLATILMI?? ONAM BELGES??\nG??ncelleme: 03.04.2020\n\nG??ven Hastanesi A.??.???ye (???G??ven Hastanesi???) ait web sitesi ve telefon uygulamalar?? (???Online Platform???) ??zerinden sunulan ONLINE DOKTOR VE E-KONS??LTASYON H??ZMET?????nin (???Hizmet???) kapsam?? konusunda taraf??ma yaz??l?? bilgilendirme yap??lm????t??r. \n1.\tHizmet kapsam??nda, Online Platform ??zerinden G??ven Hastanesi hekimleri taraf??ndan dan????ma ve kons??ltasyon imkan?? sunulaca????; \n2.\tHizmet???in hasta ve hekimin bir arada bulunmas??n?? gerektiren durumlarda muayenenin muadili olmad??????; \n3.\tHer t??rl?? t??bbi tan?? ve tedavi ihtiya??lar??m i??in ??zg??r irademle se??ece??im hekimime ba??vuru yapmam ve fiziken muayene olmam gerekti??i, \n4.\tSa??l??????m?? ilgilendiren ve aciliyeti olan konularda, vakit kaybetmeden en yak??n acil servise m??racaat etmem gerekti??i, \n5.\tAksi halde ger??ekle??ebilecek olumsuz sonu??lardan G??ven Hastanesi???nin hi??bir ??ekilde sorumlu tutulamayaca????, \nkonular??nda yaz??l?? olarak ayd??nlat??ld??m. \nKonu hakk??nda sorum olmas?? halinde ula??abilece??im ileti??im numaralar?? taraf??mla payla????ld??. \nGelinen a??amada; \nTaraf??ma yap??lan t??m yaz??l?? bilgilendirmeleri okudu??umu, anlad??????m?? ve bu haliyle kabul etti??imi; ONLINE DOKTOR VE E-KONS??LTASYON H??ZMET?????nden bu bilgilendirmeler do??rultusunda yararlanaca????m?? kabul ve beyan ediyorum.\n(????bu Belge G??VEN HASTANES?? ile ALICI aras??ndaki MESAFEL?? SATI?? S??ZLE??ME???sinin tamamlay??c?? bir par??as?? olarak ALICI???ya imzalat??lm????t??r.)\n\n\n`
  String get preinformation_form_context {
    return Intl.message(
      '??N B??LG??LEND??RME FORMU\nG??ncelleme: 16.09.2021\nMADDE 1: TARAFLAR ve KONU\n1.\t????bu Mesafeli Sat???? S??zle??mesi ??n Bilgilendirme Formu???nun (???Bilgilendirme Formu???) taraflar?? a??a????daki gibidir: \nSATICI (???G??ven Hastanesi???) \nTicari Unvan??\t: G??ven Hastanesi A.??.\nAdresi\t\t: Remzi O??uz Ar??k Mahallesi Paris Cad. No:58 ??ankaya Ankara\nTelefon \t\t: 444 94 94\nE-mail \t\t: guven@guven.com.tr\nMERS??S No\t: 0451001685100012\nALICI (???Al??c?????)\nAd?? Soyad?? \t: <userName>\nAdresi \t\t: <adress>\nTelefon \t\t: <phoneNumber>\nE-mail \t\t: <email>\nAl??c?? ve G??ven Hastanesi bundan b??yle ayr?? ayr?? ???Taraf??? ve birlikte ???Taraflar??? olarak an??labilecektir.\n2.\tG??ven Hastanesi, 27166 say?? ve 11.03.2009 tarihli Resmi Gazete???de yay??mlanarak y??r??rl????e giren "??zel Hastaneler Y??netmeli??i" ve sair mevzuatta belirtilen ??artlar?? ta????yan, ??e??itli uzmanl??k dallar??nda hastalara ayakta ve yat??rarak muayene, te??his ve tedavi hizmeti sunan, Ankara???da Paris Caddesi No: 58 Kavakl??dere Ankara adresinde mukim ??zel bir hastanedir. \n3.\t????bu Bilgilendirme Formu 6502 Say??l?? T??keticinin Korunmas?? Hakk??nda Kanun (???Kanun???) ve Mesafeli S??zle??meler Y??netmeli??i???ne uygun olarak d??zenlenmi??tir. ????bu Bilgilendirme Formu, Al??c?????n??n G??ven Hastanesi???ne ait web sitesi ve telefon uygulamalar?? (???Online Platform???) ??zerinden i??bu Bilgilendirme Formu Madde 2.2???de belirtilen sa??l??k hizmeti paketini (???Hizmet Paketi???) sat??n almas??nda Taraflar??n kar????l??kl?? hak ve y??k??ml??l??klerini d??zenlemektedir.  \n4.\t????bu Bilgilendirme Formu???nun Taraflar?? i??bu Bilgilendirme Formu taht??nda Kanun???dan ve Mesafeli S??zle??meler Y??netmeli??i???nden kaynaklanan y??k??ml??l??k ve sorumluluklar??n?? bildiklerini ve anlad??klar??n?? kabul ve beyan ederler.\n5.\tAl??c??, i??bu Bilgilendirme Formu???nu elektronik ortamda teyit etmekle, mesafeli s??zle??melerin akdinden ??nce G??ven Hastanesi taraf??ndan Al??c?????ya verilmesi gereken adres, sipari??i verilen hizmete ait temel ??zellikler, hizmetin vergiler dahil fiyat?? ve ??deme bilgilerini de do??ru ve eksiksiz olarak edindi??ini teyit etmi?? olur.\nMADDE 2: S??ZLE??ME KONUSUNUN TEMEL N??TEL??KLER?? VE BEDEL?? \n1.\tHizmet Paketi???nin temel ??zellikleri Online Platform???da yer almaktad??r ve Online Platform???da incelenebilecektir. Hizmet Paketi???nin ???online g??r????me??? olmas?? halinde Hizmet Paketi, hasta ve hekimin bir arada bulunmas?? gereken durumlarda muayenenin bir muadili olmay??p, Al??c?????ya sadece Online Platform???da se??ilen hekime dan????ma ve kons??ltasyon imkan?? sunulacakt??r. \n2.\tAl??c?? taraf??ndan i??bu Bilgilendirme Formu kapsam??nda sat??n al??nacak olan Hizmet Paketi???ne ili??kin bilgiler a??a????daki ??ekildedir:\nHizmet Paketi A????klamas??\tAdet\tBirim Fiyat??\tAra Toplam\n(KDV Dahil)\n\t\t\t\n<packageName>\t\t\t\nToplam :\t\n\n??deme ??ekli ve Plan??\t: <paymentPlan>\nFatura Adresi\t\t: <adress>\nTeslimat Adresi\t\t: <adress>\nTeslim Edilecek Ki??i\t: <userName>\nSat??n Alma Tarihi\t: <currentDate>\n3.\tOnline Platform???da ilan edilen fiyatlar sat???? fiyat??d??r. ??lan edilen fiyatlar ve vaatler g??ncelleme yap??lana ve de??i??tirilene kadar ge??erlidir. S??reli olarak ilan edilen fiyatlar ise belirtilen s??re sonuna kadar ge??erlidir.\n4.\tG??ven Hastanesi, Al??c?????n??n Online Platform ??zerinden onaylayarak sat??n ald?????? Hizmet Paketi???ni en ge?? 24 saat i??inde i??leme alarak ilgili birimlerine iletir.\n5.\tHizmet, G??ven Hastanesi taraf??ndan m??mk??n olan en k??sa s??rede ve en ge?? 7 (yedi) i?? g??n?? i??inde Al??c?????ya sunulur. Hizmet Paketi???nin tek seferde kullan??lmakla t??kenecek bir hizmete ili??kin olmas?? halinde Hizmet Paketi???nin Al??c?? taraf??ndan <expirationDate> tarihine kadar kullan??lmas?? gerekmektedir. Hizmet Paketi???nin devaml??l?????? olan bir hizmete y??nelik, d??nemli bir hizmete ili??kin olmas?? halinde ise Al??c?? taraf??ndan Hizmet Paketi???nin kullan??m??na <currentDate> tarihine kadar ba??lan??lm???? olmas?? ve bu tarihten itibaren 3 (????) ay i??erisinde Hizmet Paketi???nin tamamen kullan??lmas?? gerekir. ????bu maddede belirtilen tarihlere kadar kullan??lmayan Hizmet Paketi belirtilen tarihlerden sonra kullan??lamaz ve bu hususta Al??c?????ya herhangi bir ??deme / geri ??deme yap??lmayaca???? gibi, Al??c?????n??n herhangi bir talep hakk?? da bulunmayacakt??r.\n6.\tG??ven Hastanesi???nden kaynaklanmayan sebeplerle gecikmelerin ya??anmas?? halinde G??ven Hastanesi durumu derhal Al??c?????ya bildirir. \n7.\tAl??c?????n??n sat??n ald?????? Hizmet Paketi???nin pe??in veya vadeli fiyat?? sipari?? formunda yer al??r, Al??c?? taraf??ndan onaylan??r ve sipari?? sonunda Al??c?????n??n e-posta adresine e-fatura olarak g??nderilir. Yap??lan indirimler ve promosyonlar sat???? fiyat??na yans??t??l??r.\n8.\tHizmet Paketi???nin Al??c?????ya fiziki teslimat gerektirmesi halinde, teslimat masraflar?? aksi G??ven Hastanesi taraf??ndan beyan edilmedi??i m??ddet??e Al??c?????ya aittir. Bu durumda G??ven Hastanesi Hizmet Paketi???ni sipari?? tarihinden itibaren 30 (otuz) g??n i??inde teslim eder. G??ven Hastanesi bu s??re i??inde yaz??l?? bildirimle ek 10 (on) g??nl??k s??re uzat??m hakk??n?? sakl?? tutar. Hizmet Paketi???nin arac?? posta veya kargo ??irketine teslim edilmesi ile hasardan sorumluluk Al??c?????ya ge??er.\n9.\tMesafeli sat???? s??zle??mesi Al??c?? taraf??ndan Online Platform ??zerinden onaylanmakla y??r??rl????e girer ve Al??c?????n??n G??ven Hastanesi???nden sat??n alm???? oldu??u Hizmet Paketi???nin Al??c?????ya online ve/veya fiziksel ortamda sunulmas?? ile ifa edilmi?? olur. \n10.\tHizmet Paketi, Al??c?????n??n sipari?? formunda ve mesafeli sat???? s??zle??mesinde belirtmi?? oldu??u adreste bulunan ki??i/ki??ilere teslim edilecektir.\nMADDE 3: ALICININ BEYAN VE TAAHH??TLER??\n1.\tAl??c??, Hizmet Paketi???nin nitelikleri, t??m vergiler dahil sat???? fiyat??, ??deme ??ekli, teslimat ve cayma hakk?? ile kullan??m ??artlar??na ili??kin olarak ??n bilgilerin taraf??na ula??t??????n??, G??ven Hastanesi taraf??ndan kendisine Online Platform ??zerinden sunulan bilgileri okudu??unu, anlad??????n??, eksiksiz olarak bilgilendi??ini, elektronik ortamda teyit etti??ini ve elektronik ortamda sat???? i??in gerekli onaylar?? verdi??ini beyan eder. \n2.\t????bu Bilgilendirme Formu???nu kabul etmekle Al??c??, s??zle??me konusu Hizmet Paketi???ni onaylad?????? takdirde Hizmet Paketi???nin bedeli ve vergi gibi belirtilen ek ??cretleri ??deme y??k??ml??l?????? alt??na girece??ini ve bu konuda bilgilendirildi??ini pe??inen kabul eder.\n3.\tAl??c??, se??mi?? oldu??u Hizmet Paketi???nin gereklerinin ifa edilebilmesi i??in 6698 say??l?? Ki??isel Verileri Koruma Kanunu uyar??nca ??zel nitelikli ki??isel veri say??lan sa??l??k verilerinin Hizmet Paketi kapsam??ndaki hizmetin ifas?? amac?? ile s??n??rl?? olmak kayd??yla i??lenmesine a????k olarak r??za g??stermektedir.  \n4.\tAl??c??, talep ve ??ik??yetlerini G??ven Hastanesi???nin yukar??da yer alan ileti??im kanallar??na ula??t??rabilir. G??ven Hastanesi, talep ve ??ik??yetleri de??erlendirerek Al??c?????ya en k??sa zamanda geri d??n???? yapar. \n5.\tAl??c??, herhangi bir nedenle s??zle??me konusu Hizmet Paketi???nin bedelinin ??denmemesi ve/veya banka kay??tlar??nda iptal edilmesi halinde, G??ven Hastanesi???nin s??zle??me konusu Hizmet Paketi???ni ifa ve/veya teslim y??k??ml??l??????n??n sona erece??ini kabul, beyan ve taahh??t eder.\n6.\tAl??c??, i??bu Bilgilendirme Formu???nu ve mesafeli sat???? s??zle??mesini kabul ederken en az 18 ya????nda oldu??unu veya ilgili ??lke mevzuat??na g??re i??bu Bilgilendirme Formu???nu ve mesafeli sat???? s??zle??mesini akdetmeye uygun ya??ta oldu??unu, k??s??tl?? olmad??????n?? ve i??bu Bilgilendirme Formu???nu ve mesafeli sat???? s??zle??mesini akdetmeye yetkili oldu??unu kabul ve beyan eder. Al??c?????n??n i??bu maddede belirtilen ya?? s??n??r??ndan daha k??????k oldu??unun, k??s??tl?? oldu??unun veya sair surette i??bu Bilgilendirme Formu???nu ve/veya mesafeli sat???? s??zle??mesini akdetmeye yetkili olmad??????n??n tespiti halinde mesafeli sat???? s??zle??mesi G??ven Hastanesi taraf??ndan derhal feshedilebilir ve Al??c?????ya veya yasal temsilcisine herhangi bir ??deme iadesi yap??lmaz.\n7.\tHizmet Paketi???nin ???online g??r????me??? olmas?? halinde Al??c?????n??n, randevu saatinden en ge?? 5 (be??) dakika ??nce G??ven Online uygulamas??na giri?? yapmas??, ba??lant??ya haz??r durumda olmas?? ve hekimle g??r????meyi ba??latm???? olmas?? gerekir. Al??c?????n??n bu maddede belirtilen ??ekilde haz??r olmamas?? ve/veya g??r????meye hi?? kat??lmamas?? halinde ilgili g??r????me yap??lm???? say??larak ??cretlendirmesi yap??l??r ve Al??c?????ya herhangi bir iade yap??lmaz.\n8.\tHizmet Paketi???nin ???online g??r????me??? olmas?? halinde Al??c?????n??n g??r??nt??l?? g??r????me yapabilmek i??in dikkat etmesi gereken hususlar ve hizmetin kullan??labilmesi i??in gereken donan??m ve yaz??l??mlara ili??kin bilgi ???https://www.guven.com.tr/online-doktor??? adresindeki ilgili b??l??mlerde yer almakta olup, bu hususlar zaman zaman G??ven Hastanesi taraf??ndan g??ncellenebilecektir. G??ncellemeleri takip etmek ve bu hususlara uymak Al??c?????n??n sorumlulu??undad??r.\n9.\tAl??c??, Ek-1: Online Doktor ve E-Kons??ltasyon Hizmetinin Kapsam?? Hakk??nda Bilgilendirme ve Ayd??nlat??lm???? Onam Belgesi???nde yer alan bilgileri okudu??unu, anlad??????n?? ve kabul etti??ini beyan ve taahh??t eder.\nMADDE 4: ??FADA SIRA, TEMERR??D HAL?? VE HUKUK?? SONU??LARI\n1.\tAl??c?????n??n ??demeyi ger??ekle??tirmesini takiben, mesafeli sat???? s??zle??mesi ko??ullar??na uygun olarak G??ven Hastanesi i??bu Bilgilendirme Formu???nda ve mesafeli sat???? s??zle??mesinde belirtilen Hizmet Paketi kapsam??ndaki hizmeti sunar. \n2.\tAl??c?? borcundan dolay?? temerr??de d????mesi halinde, borcun gecikmeli ifas??ndan dolay?? G??ven Hastanesi???nin olu??an zarar ve ziyan??n?? ??demeyi kabul eder.\nMADDE 5: CAYMA HAKKI\n1.\tAl??c??, hi??bir hukuki ve cezai sorumluluk ??stlenmeksizin ve hi??bir gerek??e g??stermeksizin, mal sat??????na ili??kin i??lemlerde teslimat tarihinden itibaren, hizmet sat??????na ili??kin i??lemlerde sat??n alma tarihinden itibaren 14 (on d??rt) g??n i??erisinde cayma hakk??n?? kullanabilir. Mal sat??????na ili??kin i??lemlerde Al??c??, mal??n teslimine kadar olan s??re i??inde de cayma hakk??n?? kullanabilir. \n2.\tHizmet Paketi kapsam??ndaki hizmetin Al??c?? taraf??ndan k??smen veya tamamen kullan??lm???? olmas?? halinde cayma hakk?? kullan??lamaz. Cayma hakk?? s??resi sona ermeden ??nce, Al??c?????n??n onay?? ile ifas??na ba??lanan hizmetler i??in de cayma hakk?? kullan??lamaz.\n3.\tAl??c?????n??n cayma hakk??n?? kullanmas??ndan itibaren 14 (on d??rt) g??n i??erisinde (mal sat??????na ili??kin i??lemlerde mal??n G??ven Hastanesi???nin iade i??in belirtti??i ta????y??c?? arac??l??????yla geri g??nderilmesi kayd??yla), Al??c?????n??n ilgili mal veya hizmete ili??kin G??ven Hastanesi???ne yapt?????? t??m ??demeler Al??c?????ya Hizmet Paketi???ni sat??n al??rken kulland?????? ??deme arac??na uygun bir ??ekilde ve Al??c?????ya herhangi bir masraf veya y??k??ml??l??k getirmeden ve tek seferde iade edilecektir.\n4.\tCayma hakk??na ili??kin bildirimler G??ven Hastanesi???ne ait <hospitalEmail> e-posta adresine yap??lacakt??r.\n5.\tCayma hakk??n??n kullan??m??ndan kaynaklanan masraflar G??ven Hastanesi???ne aittir. Al??c??, i??bu Bilgilendirme Formu???nu ve mesafeli sat???? s??zle??mesini kabul etmekle, cayma hakk?? konusunda bilgilendirildi??ini pe??inen kabul eder.\nMADDE 6: SORUMLULUK SINIRI \n1.\tAl??c?????n??n her durumda t??bbi tan??, tedavi ve hastal??klar??n ??nlenmesi i??in ??zg??r iradesiyle se??ece??i hekimine ba??vurmas??, kontrollerini aksatmamas?? ve her t??rl?? acil durumda vakit kaybetmeden en yak??n acil servise m??racaat etmesi gerekmektedir. Aksi halde G??ven Hastanesi???nin hi??bir sorumlulu??u bulunmamaktad??r.\n2.\t???Online g??r????me??? kapsam??nda G??ven Online???da yer alan hekimler taraf??ndan Al??c?????ya herhangi bir t??bbi i??lem (muayene, tan??, te??his, tedavi gibi) sunulmamakta ve vaat edilmemekte olup; G??ven Hastanesi???nin ve/veya G??ven Online???da yer alan hekimlerin t??bbi k??t?? uygulamadan (malpraktis) dolay?? herhangi bir sorumlulu??u bulunmayacakt??r.\n3.\t???Online g??r????me??? kapsam??nda G??ven Online???da yer alan hekimler, herhangi bir g??r????te bulunmu?? olmamaktad??r. ???Online g??r????me??? kapsam??nda sunulan herhangi bir bilgi veya verinin do??rulu??unu teyit etmek Al??c?????n??n y??k??ml??l?????? ve sorumlulu??undad??r. ???Online g??r????me??? kapsam??nda G??ven Hastanesi ve G??ven Online???da yer alan hekimler, G??ven Online?????n ve/veya ???online g??r????me??? ??zelli??inin kullan??lmas?? veya kullan??lmamas??, G??ven Online???da sunulan hizmetin aksamas?? veya kesintiye u??ramas?? ve mesafeli sat???? s??zle??mesindeki hizmetlerin ifas?? nedeniyle ortaya ????kabilecek herhangi bir yaralanma, bedensel zarar, maddi veya manevi zarar, k??r kayb??, i?? kayb?? veya sair her t??rl?? do??rudan ya da dolayl?? zararlardan hi??bir bi??imde sorumlu de??ildir.\n4.\tUygulanacak hukuk alt??nda izin verildi??i ??l????de, G??ven Hastanesi???nin Al??c?????n??n Hizmet Paketi ve mesafeli sat???? s??zle??mesi kapsam??ndaki herhangi bir zarar??na ili??kin sorumlulu??u, hangisi daha az ise; (i) sorumlulu??u do??uran olaydan ??nceki 1 (bir) takvim ay?? i??inde Al??c?? taraf??ndan ???G??ven Online ??zerinden??? G??ven Hastanesi???ne ??denmi?? olan Hizmet Paketi bedelleri toplam??, veya (ii) 1.000 (bin) T??rk Liras?? ile s??n??rl??d??r.\n5.\tAl??c?????n??n mesafeli sat???? s??zle??mesini ihlal ederek ??????nc?? ki??ilerin herhangi bir zarar??na sebep olmas?? halinde Al??c??, bu zarardan G??ven Hastanesi???ni masun tutacakt??r. Al??c?????dan kaynaklanan herhangi bir sebeple G??ven Hastanesi???nin herhangi bir zarara u??ramas?? halinde bu zarar Al??c?? taraf??ndan derhal nakden ve defaten tazmin edilecektir.\nMADDE 7: D????ER H??K??MLER\n1.\tMesafeli sat???? s??zle??mesi taht??nda Taraflar aras??nda yap??lacak her t??rl?? yaz????ma, mevzuatta say??lan zorunlu haller d??????nda e-posta arac??l??????yla yap??l??r. Mevzuatta yaz??l?? hallerde Taraflar??n belirtmi?? oldu??u adresleri tebligat adresleri olarak kabul edilir. 15 (on be??) g??n i??erisinde kar???? Tarafa bildirilmeyen tebligat adresi de??i??ikliklerinde tebligat usul??ne uygun olarak yap??lm???? say??l??r.\n2.\tG??ven Hastanesi, kendi kontrol?? d??????nda meydana gelen, ??ng??r??lemeyen ve ??nlenemeyen do??al afetler, yang??n, patlamalar, i?? sava??lar, sava??lar, ayaklanmalar, halk hareketleri, seferberlik ilan??, grev, lokavt ve salg??n hastal??klar gibi m??cbir sebep hallerinden dolay?? olu??abilecek herhangi bir gecikme veya y??k??ml??l??klerin ifa edilememesinden kaynaklanabilecek zarar ve ziyandan sorumlu olmayacakt??r. M??cbir sebep halinin G??ven Hastanesi???nin mesafeli sat???? s??zle??mesinde yaz??l?? y??k??ml??l??klerini do??rudan etkilemesi durumunda G??ven Hastanesi???nin mesafeli sat???? s??zle??mesini tazminats??z ve tek tarafl?? feshetme hakk?? sakl??d??r.\n3.\tBu Bilgilendirme Formu???nun ve/veya mesafeli sat???? s??zle??mesinin herhangi bir madde veya k??sm??n??n ge??ersiz, h??k??ms??z veya ifa edilemez say??lmas?? halinde, o madde veya k??s??m, onun lafzi amac??na en yak??n ve ayn?? zamanda ifa edilebilir olan bir ??ekilde ve kapsamda yorumlanacak ve uygulanacakt??r; ancak bunun m??mk??n olmamas?? halinde, o madde veya k??s??m Bilgilendirme Formu???nda ve/veya mesafeli sat???? s??zle??mesinden ayr??lm???? ve ????kart??lm???? say??lacak ve bu durum, Bilgilendirme Formu???nun ve/veya mesafeli sat???? s??zle??mesinin kalan madde ve h??k??mlerini hi??bir ??ekilde etkilemeyecek veya ge??ersiz hale getirmeyecek ve Bilgilendirme Formu???nun ve mesafeli sat???? s??zle??mesinin di??er madde ve h??k??mleri tam ge??erli ve y??r??rl??kte kalmaya devam edecektir.\n4.\tHi??bir feragat yaz??l?? olarak ve Taraflarca yap??lmad??k??a ge??erli olmayacakt??r. Taraflardan herhangi birinin mesafeli sat???? s??zle??mesinin herhangi bir h??km??n??n veya ??art??n??n sa??lanmas??n?? talep etmemesi ya da herhangi bir Taraf??n mesafeli sat???? s??zle??mesinin herhangi bir ihlalinden do??an talep hakk??ndan feragat etmesi, s??z konusu h??k??m veya ??art??n bundan sonra uygulanmas??n?? engellemeyecektir ve bir sonraki ihlalden feragat olarak say??lmayacakt??r.\n5.\tG??ven Hastanesi, mesafeli sat???? s??zle??mesinden do??an hak ve y??k??ml??l??klerini hi??bir s??n??rlama olmaks??z??n ??????nc?? ??ah??slara devretmek hakk??n?? haizdir.\n6.\tTaraflar, Bilgilendirme Formu???nun ve mesafeli sat???? s??zle??mesinin ge??erlili??i, uygulanmas?? ve yorumlanmas?? konusunda kanunlar ihtilaf??na dair kurallar hari?? olmak ??zere m??nhas??r ??ekilde T??rkiye Cumhuriyeti yasalar?? ve ilgili mevzuat??n??n uygulanaca????n?? kabul ve beyan ederler.\n7.\tBilgilendirme Formu ve mesafeli sat???? s??zle??mesi ile ilgili ????kacak ihtilaflarda; her y??l Ticaret Bakanl?????? taraf??ndan ilan edilen de??ere kadar Al??c?????n??n yerle??im yerindeki Hizmet Paketi???ni sat??n ald?????? veya ikametg??h??n??n bulundu??u yerdeki ??l veya ??l??e T??ketici Sorunlar?? Hakem Heyetleri, s??z konusu de??erin ??zerindeki ihtilaflarda ise T??ketici Mahkemeleri yetkilidir.\n8.\tBilgilendirme Formu ve mesafeli sat???? s??zle??mesinden do??abilecek ihtilaflarda G??ven Hastanesi???nin resmi defter ve ticari kay??tlar??yla, kendi veritaban??nda, sunucular??nda tuttu??u elektronik bilgiler ve bilgisayar kay??tlar??, ba??lay??c??, kesin ve m??nhas??r delil te??kil eder. Bu madde Hukuk Muhakemeleri Kanunu???nun 193. maddesi anlam??nda delil s??zle??mesi niteli??indedir.  \n9.\tALICI, G??VEN ONLINE VE S??ZLE??ME KAPSAMINDAK?? H??ZMET??N N??TEL??KLER?? VE BEDEL?? ??LE EK-1: ONLINE DOKTOR VE E-KONS??LTASYON H??ZMET??N??N KAPSAMI HAKKINDA B??LG??LEND??RME VE AYDINLATILMI?? ONAM BELGES?????NDEK?? HUSUSLARA ??L????K??N OLARAK G??VEN HASTANES?? TARAFINDAN KEND??S??NE YAPILAN B??LG??LEND??RMELER?? VE KEND?? SORUMLULUKLARINI OKUYUP ANLADI??INI, ANLAMADI??I KISIMLARIN OLMASI HAL??NDE SORU SORDU??UNU, SORULARININ YETK??L?? K??????LERCE CEVAPLANDI??INI, EKS??KS??Z OLARAK B??LG??LEND??????N?? KABUL VE BEYAN EDER.\n7 (yedi) maddeden ve 1 (bir) adet ekten ibaret i??bu Bilgilendirme Formu, Al??c?? taraf??ndan elektronik ortamda okunup onaylanmak suretiyle akdedilmi?? ve derhal y??r??rl????e girmi??tir.\n\nEk-1: Online Doktor ve E-Kons??ltasyon Hizmetinin Kapsam?? Hakk??nda Bilgilendirme ve Ayd??nlat??lm???? Onam Belgesi\n\nALICI\t                          G??VEN HASTANES?? A.??.\n\n???\nEK-1:\nONLINE DOKTOR VE E-KONS??LTASYON\nH??ZMET??N??N KAPSAMI HAKKINDA B??LG??LEND??RME\nVE\nAYDINLATILMI?? ONAM BELGES??\nG??ncelleme: 03.04.2020\n\nG??ven Hastanesi A.??.???ye (???G??ven Hastanesi???) ait web sitesi ve telefon uygulamalar?? (???Online Platform???) ??zerinden sunulan ONLINE DOKTOR VE E-KONS??LTASYON H??ZMET?????nin (???Hizmet???) kapsam?? konusunda taraf??ma yaz??l?? bilgilendirme yap??lm????t??r. \n1.\tHizmet kapsam??nda, Online Platform ??zerinden G??ven Hastanesi hekimleri taraf??ndan dan????ma ve kons??ltasyon imkan?? sunulaca????; \n2.\tHizmet???in hasta ve hekimin bir arada bulunmas??n?? gerektiren durumlarda muayenenin muadili olmad??????; \n3.\tHer t??rl?? t??bbi tan?? ve tedavi ihtiya??lar??m i??in ??zg??r irademle se??ece??im hekimime ba??vuru yapmam ve fiziken muayene olmam gerekti??i, \n4.\tSa??l??????m?? ilgilendiren ve aciliyeti olan konularda, vakit kaybetmeden en yak??n acil servise m??racaat etmem gerekti??i, \n5.\tAksi halde ger??ekle??ebilecek olumsuz sonu??lardan G??ven Hastanesi???nin hi??bir ??ekilde sorumlu tutulamayaca????, \nkonular??nda yaz??l?? olarak ayd??nlat??ld??m. \nKonu hakk??nda sorum olmas?? halinde ula??abilece??im ileti??im numaralar?? taraf??mla payla????ld??. \nGelinen a??amada; \nTaraf??ma yap??lan t??m yaz??l?? bilgilendirmeleri okudu??umu, anlad??????m?? ve bu haliyle kabul etti??imi; ONLINE DOKTOR VE E-KONS??LTASYON H??ZMET?????nden bu bilgilendirmeler do??rultusunda yararlanaca????m?? kabul ve beyan ediyorum.\n(????bu Belge G??VEN HASTANES?? ile ALICI aras??ndaki MESAFEL?? SATI?? S??ZLE??ME???sinin tamamlay??c?? bir par??as?? olarak ALICI???ya imzalat??lm????t??r.)\n\n\n',
      name: 'preinformation_form_context',
      desc: '',
      args: [],
    );
  }

  /// `DISTANCE SALES AGREEMENT\nUpdated as of: 16.09.2021\nARTICLE 1: PARTIES and SUBJECT MATTER\n1.\tThis Distance Sales Agreement (the ???Agreement???) has been entered into by the parties listed below: \nSELLER (???G??ven Hospital???) \nTrade Name\t: G??ven Hastanesi A.??.\nAddress\t\t: Remzi O??uz Ar??k Mahallesi Paris Cad. No:58 ??ankaya Ankara\nTelephone\t: 444 94 94\nE-mail \t\t: guven@guven.com.tr\nMERS??S No.\t: 0451001685100012\nBUYER (???Buyer???)\nFull Name \t: <userName>\nAddress \t\t:<adress>\nTelephone\t: <phoneNumber>\nE-mail \t\t: <email>\nThe Buyer and G??ven Hospital may be individually referred to as a ???Party??? and jointly as the ???Parties???. \n2.\tG??ven Hospital is a private hospital providing patients with ambulatory and in-patient medical examination, diagnosis and treatment services of various medical specialities and seated at the address of Paris Caddesi No: 58 Kavakl??dere Ankara, in the Ankara province, holding the qualifications prescribed for under the ???Private Hospitals Regulation??? published on the Official Gazette dated 11.03.2009 and numbered 27166 and other relevant legislation. \n3.\tThis Agreement has been prepared in accordance with the Consumer Protection Law No. 6502 (the ???Law???) and the Distance Agreements Regulation. This Agreement provides for the Parties??? mutual rights and obligations for the Buyer???s purchase of the healthcare service package as defined under Article 2.2 of this Agreement (the ???Service Package???) from the web site and mobile applications owned by G??ven Hospital (the ???Online Platform???). \n4.\tThe Parties to this Agreement accept and represent that they are informed of and understand their obligations and responsibilities arising out of the Law and the Distance Agreements Regulation within the context of this Agreement. \n5.\tBy way of approving this Agreement and the Preliminary Disclosure Form by electronic means, Buyer confirms the complete and accurate receipt of the information that must be provided by G??ven Hospital to the Buyer prior to the execution of a distance agreement, namely those on address, the essential features of the service that is ordered, the full price of the service including taxes and payment information. \nARTICLE 2: ESSENTIAL FEATURES OF THE SUBJECT MATTER OF THE AGREEMENT AND PRICE \n1.\tThe essential features of the Service Package are listed on the Online Platform and may likewise be reviewed on the Online Platform. Where the Service Package is an ???online meeting???, the Service Package is not a substitute for a medical examination in cases where the patient and the physician must be together and is solely for the purposes of the Buyer inquiring and consulting with the physician chosen on the Online Platform. \n2.\tInformation as to the Service Package purchased by the Buyer by this Agreement are as below:\nExplanation on the Service Package\tQuantity\tUnit Price\tSubtotal (VAT Inclusive)\n<packageName>\n\t\t\nTotal:\t\n\nPayment Method and Plan\t: <paymentPlan>\nInvoice Address\t\t\t: <adress>\nDelivery Address\t\t: <adress>\nRecipient\t\t\t: <userName>\nDate of Purchase\t\t: <currentDate>\n3.\tPrices published on the Online Platform are sales prices. Published prices and offers are valid until they are updated or changed. Prices published for a certain term are valid until the expiry of said term. \n4.\tThe Service Package approved and purchased by the Buyer over the Online Platform shall be processed no later than 24 hours by G??ven Hospital and relayed to its relevant units. \n5.\tService shall be provided by G??ven Hospital to the Buyer as soon as possible and in any event no later than 7 (seven) business days. In cases where the Service Package corresponds to a service that is for a single use only, the Buyer must use the Service Package by <expirationDate> at the latest. In cases where the Service Package corresponds to a service that is by nature continuous over a certain term, the Buyer must commence the use of the Service Package by <currentDate> at the latest and must then finish the use of all the Service Package in 3 (three) months starting from said date. Service Packages that are not used prior to the dates specified in this article shall not be usable after the expiry of said dates, no payment / repayment shall be made to the Buyer in this regard and the Buyer shall correspondingly have no rights of recourse. \n6.\tIn the event of any delays that are not attributable to G??ven Hospital, G??ven Hospital shall promptly notify the event to the Buyer. \n7.\tThe full or deferred price of the Service Package purchased by the Buyer shall be listed on the order form, shall be approved by the Buyer, and shall be sent to the Buyer???s e-mail address as an e-invoice following the completion of the order. Any discounts and promotion, if applied, shall be reflected on the sales price. \n8.\tWhere the Service Package requires a physical delivery to the Buyer, delivery charges are on the Buyer unless otherwise indicated by G??ven Hospital. In this case, G??ven Hospital shall deliver the Service Package in 30 (thirty) days following the order date. G??ven Hospital reserves its right to extend this term by an additional 10 (ten) days via written notice during this period. Upon the delivery of the Service Package to the post or to the courier company, the risk shall pass to the Buyer. \n9.\tThis Agreement shall come into effect upon its approval by the Buyer on the Online Platform and shall be deemed to have been performed by the delivery of the Service Package purchased by the Buyer from G??ven Hospital physically and/or via online means. \n10.\tThe Service Package shall be delivered to the person or persons present at the address indicated by the Buyer on the order form and in this Agreement. \nARTICLE 3: BUYER???S REPRESENTATIONS AND UNDERTAKINGS\n1.\tThe Buyer represents that it has duly received preliminary information on the features of the Service Package, its sales price inclusive of taxes, the payment method, delivery, its right of withdrawal and terms of use, and that it has read, understood, has been fully informed of, has electronically agreed to, and has electronically made all necessary approvals for the information provided to itself by G??ven Hospital over the Online Platform. \n2.\tBy way of accepting this Agreement, the Buyer agrees in advance that upon its approval of the Service Package subject matter to this Agreement, it is under the obligation to pay for the price of the Service Package and additional fees such as tax and that it has been informed in this regard. \n3.\tFor the intended performance of the chosen Service Package and limited with purpose of performing the service listed under the Service Package, the Buyer expressly consents to the processing of its medical data that is deemed as sensitive personal data by the Personal Data Protection Law No. 6698.\n4.\tThe Buyer may relay its requests and complaints to G??ven Hospital???s communication channels listed above. G??ven Hospital shall promptly revert to the Buyer following the evaluation of said requests and complaints. \n5.\tThe Buyer agrees, represents, and undertakes that in case of any failure to pay for the price of the Service Package subject matter to this Agreement and/or the cancellation of the payment over bank records, G??ven Hospital???s obligation to perform and/or deliver the Service Package subject matter to this Agreement shall expire. \n6.\tThe Buyer agrees and represents that in and while accepting this Agreement, the Buyer is at least 18 years of age or is at an age mandated by the relevant country???s laws to be legally capable of accepting this Agreement, that its capacity is not restricted and that it is authorized to accept this Agreement. If it is determined that the Buyer is younger than the age prescribed for in this article, is of restricted capacity or is not in any manner authorized to execute this Agreement, G??ven Hospital may immediately terminate this Agreement and no return payments shall be made to the Buyer or its legal representative. \n7.\tWhere the Service Package is an ???online meeting???, the Buyer is required to log in to the G??ven Online application no later than 5 (five) minutes before the appointment time, be ready for connection and commence the meeting with the physician. If the Buyer is not ready as prescribed for under this article and/or does not attend the meeting at all, the meeting shall be priced as if it were duly conducted, and no return payments shall be made to the Buyer. \n8.\tWhere the Service Package is an ???online meeting???, issues necessary for the Buyer???s consideration to conduct a video meeting and information on the software and hardware necessary for the utilization of the service are listed in the relevant sections of the web page ???https://www.guven.com.tr/online-doktor??? and may be updated from time to time by G??ven Hospital. The Buyer is under the obligation to abide by these as well as to keep track of any updates. \n9.\tThe Buyer represents and undertakes that it has read, understood, and accepted the information listed under Annex-1: Information on the Scope of the Online Doctor and E-Consultation Service and Informed Consent Document. \nARTICLE 4: SEQUENCE OF PERFORMANCE, DEFAULT, AND ITS LEGAL CONSEQUENCES\n1.\tFollowing payment by the Buyer, in compliance with the terms of this Agreement, G??ven Hospital shall provide the service prescribed under the Service Package specified in this Agreement. \n2.\tIn the event of any default on the side of the Buyer, the Buyer agrees to pay for any damages and costs incurred by G??ven Hospital due to the late performance of its obligation. \nARTICLE 5: RIGHT OF WITHDRAWAL\n1.\tThe Buyer, without any civil or criminal consequences and without providing for a cause, may use its right of withdrawal within 14 (fourteen) days, which starts from the date of delivery for the sale of goods, and starts from the date of purchase for the sale of services. For transactions on the sale of goods, the Buyer may also use its right of withdrawal until the delivery of the goods. \n2.\tThe right of withdrawal cannot be used by the Buyer if the service within the scope of the Service Package is used, in part or in full, by the Buyer. Similarly, the right of withdrawal may not be used for services that are being performed following the Buyer???s consent prior to the expiry of the term available for the right of withdrawal. \n3.\tWithin 14 (fourteen) days starting from the date of the Buyer???s use of its right of withdrawal (and on condition that for the sale of goods, the goods are returned through the courier specified for this purpose by G??ven Hospital), all payments made by the Buyer to G??ven Hospital for the relevant good or service shall be returned to or through the payment instrument used by the Buyer for the purchase of the Service Package, without any costs or obligations to the Buyer and in one payment. \n4.\tAny notifications for the right of withdrawal shall be made to the e-mail address of <hospitalEmail> operated by G??ven Hospital. \n5.\tAny costs arising out of the utilization of the right of withdrawal shall be borne by G??ven Hospital. The Buyer agrees in advance that by way of accepting this Agreement, it has been informed of its right of withdrawal. \nARTICLE 6: LIMITATION OF LIABILITY\n1.\tIn all cases, for medical diagnoses, treatments and disease prevention, Buyer is required to consult its physician freely chosen at its own ultimate discretion, not to skip any routine controls and in case of all emergencies, to apply to the closest emergency ward without any delay. G??ven Hospital shall have absolutely no liability for any acts or actions to the contrary. \n2.\tNo medical procedures (such as examinations, diagnoses, or treatments) are offered or provided by the physicians attending G??ven Online through the scope of the ???online meeting???, and G??ven Hospital and/or the physicians attending G??ven Online shall have absolutely no liability for any professed malpractice. \n3.\tThe physicians attending G??ven Online for an ???online meeting??? are not providing any advice. It is the Buyer???s responsibility and obligation to verify the correctness of any information or data provided during an ???online meeting???. G??ven Hospital and the physicians attending G??ven Online shall have absolutely no liability for the use or failure to use of G??ven Online and/or the ???online meeting??? feature, any disruption of the service provided over G??ven Online and any wounding, physical injuries, actual or moral damages, loss of profit, loss of employment opportunity and similar direct or indirect damages. \n4.\tTo the extent possible under the applicable law, G??ven Hospital???s liability for any damages incurred by the Buyer due to the Service Package and Agreement shall be limited by whichever is the lowest of (i) the sum total of the amounts paid by the Buyer to G??ven Hospital over G??ven Online within the 1 (one) calendar month before the occurrence of the event giving rise to liability, or (ii) 1,000 (one thousand) Turkish Liras. \n5.\tThe Buyer shall hold G??ven Hospital harmless in cases where the Buyer damages any third parties by its breach of this Agreement. If G??ven Hospital incurs any damages due to any reason attributable to the Buyer, said damages shall be compensated for by the Buyer promptly, in cash and in full. \nARTICLE 7: MISCELLANEOUS PROVISIONS\n1.\tAll correspondence related with this Agreement by and between the Parties shall be done so through e-mail, except in cases where the applicable legislation explicitly requires another form of communication. For these cases provided for in the applicable legislation, the Parties??? designated addresses shall be deemed as their service addresses. Unless any changes of address are notified to the other Party in 15 (fifteen) days, all notifications to the former address shall be deemed to have been duly served. \n2.\tG??ven Hospital shall bear no liability for any damages or losses arising out of or in connection with any delays or a failure to perform any obligations due to unforeseeable and unpreventable force majeure events out of its control, such as natural disasters, fires, explosions, civil wars, wars, uprisings, riots, mobilizations, strikes, lockouts, and pandemics. In cases where a force majeure event directly affects G??ven Hospital???s obligations provided for in this Agreement, G??ven Hospital reserves its right to unilaterally terminate this agreement without compensation. \n3.\tIf any of the articles or any part of this agreement is deemed as invalid, void or unenforceable, then said article or part shall be construed and performed in a manner and form that is enforceable and that is closest to its literal purpose; however, in cases where this is not possible, said article or part shall be deemed to have been severed and removed from this Agreement and such severance and removal shall in no manner affect or invalidate the remaining articles and terms of this Agreement, and the remaining articles and terms of this Agreement shall continue to remain valid and in full effect. \n4.\tNo waiver shall be valid unless it is in writing and is done so by the Parties. Any failure to request the performance of any of the terms and conditions of this Agreement by any Party, or the waiver of any Party???s rights of recourse due to the breach of this Agreement, shall not prevent the performance of said term or condition in the future or shall not be construed as a waiver of any potential future breach. \n5.\tG??ven Hospital reserves its right to assign any of its rights or liabilities arising out of this Agreement to third parties without any restriction. \n6.\tThe Parties agree and undertake that the laws and regulations of the Republic of Turkey, excluding its choice of law provisions, shall exclusively govern this Agreement, and shall be used to interpret the validity, performance, and construction of this Agreement. \n7.\tIn connection with any disputes arising out of this Agreement, for issues at or below the monetary limit announced annually by the Ministry of Commerce, the District or Provincial Consumer Issues Arbitration Tribunal seated at the registered address of the Buyer or at the location where the Buyer purchased the Service Package shall be authorized, and for any disputes above said monetary limit, Consumer Courts shall have jurisdiction. \n8.\tG??ven Hospital???s official books and commercial records, as well as the electronic information and computer data held in its servers and database, shall be binding, exclusive and definitive evidence. This article is a contract for evidence within the context of Article 193 of the Civil Procedural Law.\n9.\tTHE BUYER AGREES AND REPRESENTS THAT IT HAS READ AND UNDERSTOOD THE INFORMATION PROVIDED TO ITSELF BY G??VEN HOSPITAL ON THE FEATURES OF THE SERVICE THAT IS TO BE PROVIDED OVER G??VEN ONLINE AND THROUGH THIS AGREEMENT AND ITS OBLIGATIONS THEREFROM, THAT IT HAS POSED INQUIRIES ON ISSUES THAT IT DID NOT UNDERSTAND, THAT SUCH INQUIRIES WERE ANSWERED BY AUTHORIZED PERSONNEL AND THAT IT WAS INFORMED IN FULL. \nThis Agreement, being comprised of 7 (seven) articles and 1 (one) annex, has been executed by the Buyer by way of being read and approved electronically, and came into effect immediately. \n\nAnnex-1: Information on the Scope of the Online Doctor and E-Consultation Service and Informed Consent Document\n\nBUYER\t                          G??VEN HASTANES?? A.??.\n\n???\nANNEX-1:\nINFORMATION ON THE SCOPE OF THE ONLINE DOCTOR AND E-CONSULTATION SERVICE\n AND \nINFORMED CONSENT DOCUMENT\nUpdated as of: 03.04.2020\n\nI have been informed in writing of the scope of the ONLINE DOCTOR AND E-CONSULTATION SERVICE (the ???Service???) provided by the web site and mobile applications (the ???Online Platform???) owned by G??ven Hastanesi A.??. (???G??ven Hospital???).\nI have been clearly informed in writing that \n1.\tWithin the scope of the Service, through the Online Platform, the possibility of G??ven Hospital physicians??? advice and consultation is being offered, \n2.\tIn cases where the patient and the physician must be together, the Service is not a substitute for medical examination, \n3.\tFor all personal needs of medical diagnosis and treatment, I must apply to my physician freely chosen at my own ultimate discretion and that I must be physically examined, \n4.\tIn emergency cases that concern my health, I must apply to the nearest emergency ward without delay, and\n5.\tG??ven Hospital carries absolutely no liability for any adverse consequences due to any failure to abide by the above.\nI was provided with phone numbers that I may contact if I had any inquiries as to the above. \nAccordingly: \nI accept and represent that I have read, understood, and accepted all written information relayed to me as they are, and that I will utilize the ONLINE DOCTOR AND E-CONSULTATION SERVICE within the guidelines set forth in said information. \n(This Document has been signed by the BUYER as a supplementary part of the DISTANCE SALES AGREEMENT by and between G??VEN HOSPITAL and the BUYER.)\n\n\n`
  String get distance_sales_contract_context {
    return Intl.message(
      'DISTANCE SALES AGREEMENT\nUpdated as of: 16.09.2021\nARTICLE 1: PARTIES and SUBJECT MATTER\n1.\tThis Distance Sales Agreement (the ???Agreement???) has been entered into by the parties listed below: \nSELLER (???G??ven Hospital???) \nTrade Name\t: G??ven Hastanesi A.??.\nAddress\t\t: Remzi O??uz Ar??k Mahallesi Paris Cad. No:58 ??ankaya Ankara\nTelephone\t: 444 94 94\nE-mail \t\t: guven@guven.com.tr\nMERS??S No.\t: 0451001685100012\nBUYER (???Buyer???)\nFull Name \t: <userName>\nAddress \t\t:<adress>\nTelephone\t: <phoneNumber>\nE-mail \t\t: <email>\nThe Buyer and G??ven Hospital may be individually referred to as a ???Party??? and jointly as the ???Parties???. \n2.\tG??ven Hospital is a private hospital providing patients with ambulatory and in-patient medical examination, diagnosis and treatment services of various medical specialities and seated at the address of Paris Caddesi No: 58 Kavakl??dere Ankara, in the Ankara province, holding the qualifications prescribed for under the ???Private Hospitals Regulation??? published on the Official Gazette dated 11.03.2009 and numbered 27166 and other relevant legislation. \n3.\tThis Agreement has been prepared in accordance with the Consumer Protection Law No. 6502 (the ???Law???) and the Distance Agreements Regulation. This Agreement provides for the Parties??? mutual rights and obligations for the Buyer???s purchase of the healthcare service package as defined under Article 2.2 of this Agreement (the ???Service Package???) from the web site and mobile applications owned by G??ven Hospital (the ???Online Platform???). \n4.\tThe Parties to this Agreement accept and represent that they are informed of and understand their obligations and responsibilities arising out of the Law and the Distance Agreements Regulation within the context of this Agreement. \n5.\tBy way of approving this Agreement and the Preliminary Disclosure Form by electronic means, Buyer confirms the complete and accurate receipt of the information that must be provided by G??ven Hospital to the Buyer prior to the execution of a distance agreement, namely those on address, the essential features of the service that is ordered, the full price of the service including taxes and payment information. \nARTICLE 2: ESSENTIAL FEATURES OF THE SUBJECT MATTER OF THE AGREEMENT AND PRICE \n1.\tThe essential features of the Service Package are listed on the Online Platform and may likewise be reviewed on the Online Platform. Where the Service Package is an ???online meeting???, the Service Package is not a substitute for a medical examination in cases where the patient and the physician must be together and is solely for the purposes of the Buyer inquiring and consulting with the physician chosen on the Online Platform. \n2.\tInformation as to the Service Package purchased by the Buyer by this Agreement are as below:\nExplanation on the Service Package\tQuantity\tUnit Price\tSubtotal (VAT Inclusive)\n<packageName>\n\t\t\nTotal:\t\n\nPayment Method and Plan\t: <paymentPlan>\nInvoice Address\t\t\t: <adress>\nDelivery Address\t\t: <adress>\nRecipient\t\t\t: <userName>\nDate of Purchase\t\t: <currentDate>\n3.\tPrices published on the Online Platform are sales prices. Published prices and offers are valid until they are updated or changed. Prices published for a certain term are valid until the expiry of said term. \n4.\tThe Service Package approved and purchased by the Buyer over the Online Platform shall be processed no later than 24 hours by G??ven Hospital and relayed to its relevant units. \n5.\tService shall be provided by G??ven Hospital to the Buyer as soon as possible and in any event no later than 7 (seven) business days. In cases where the Service Package corresponds to a service that is for a single use only, the Buyer must use the Service Package by <expirationDate> at the latest. In cases where the Service Package corresponds to a service that is by nature continuous over a certain term, the Buyer must commence the use of the Service Package by <currentDate> at the latest and must then finish the use of all the Service Package in 3 (three) months starting from said date. Service Packages that are not used prior to the dates specified in this article shall not be usable after the expiry of said dates, no payment / repayment shall be made to the Buyer in this regard and the Buyer shall correspondingly have no rights of recourse. \n6.\tIn the event of any delays that are not attributable to G??ven Hospital, G??ven Hospital shall promptly notify the event to the Buyer. \n7.\tThe full or deferred price of the Service Package purchased by the Buyer shall be listed on the order form, shall be approved by the Buyer, and shall be sent to the Buyer???s e-mail address as an e-invoice following the completion of the order. Any discounts and promotion, if applied, shall be reflected on the sales price. \n8.\tWhere the Service Package requires a physical delivery to the Buyer, delivery charges are on the Buyer unless otherwise indicated by G??ven Hospital. In this case, G??ven Hospital shall deliver the Service Package in 30 (thirty) days following the order date. G??ven Hospital reserves its right to extend this term by an additional 10 (ten) days via written notice during this period. Upon the delivery of the Service Package to the post or to the courier company, the risk shall pass to the Buyer. \n9.\tThis Agreement shall come into effect upon its approval by the Buyer on the Online Platform and shall be deemed to have been performed by the delivery of the Service Package purchased by the Buyer from G??ven Hospital physically and/or via online means. \n10.\tThe Service Package shall be delivered to the person or persons present at the address indicated by the Buyer on the order form and in this Agreement. \nARTICLE 3: BUYER???S REPRESENTATIONS AND UNDERTAKINGS\n1.\tThe Buyer represents that it has duly received preliminary information on the features of the Service Package, its sales price inclusive of taxes, the payment method, delivery, its right of withdrawal and terms of use, and that it has read, understood, has been fully informed of, has electronically agreed to, and has electronically made all necessary approvals for the information provided to itself by G??ven Hospital over the Online Platform. \n2.\tBy way of accepting this Agreement, the Buyer agrees in advance that upon its approval of the Service Package subject matter to this Agreement, it is under the obligation to pay for the price of the Service Package and additional fees such as tax and that it has been informed in this regard. \n3.\tFor the intended performance of the chosen Service Package and limited with purpose of performing the service listed under the Service Package, the Buyer expressly consents to the processing of its medical data that is deemed as sensitive personal data by the Personal Data Protection Law No. 6698.\n4.\tThe Buyer may relay its requests and complaints to G??ven Hospital???s communication channels listed above. G??ven Hospital shall promptly revert to the Buyer following the evaluation of said requests and complaints. \n5.\tThe Buyer agrees, represents, and undertakes that in case of any failure to pay for the price of the Service Package subject matter to this Agreement and/or the cancellation of the payment over bank records, G??ven Hospital???s obligation to perform and/or deliver the Service Package subject matter to this Agreement shall expire. \n6.\tThe Buyer agrees and represents that in and while accepting this Agreement, the Buyer is at least 18 years of age or is at an age mandated by the relevant country???s laws to be legally capable of accepting this Agreement, that its capacity is not restricted and that it is authorized to accept this Agreement. If it is determined that the Buyer is younger than the age prescribed for in this article, is of restricted capacity or is not in any manner authorized to execute this Agreement, G??ven Hospital may immediately terminate this Agreement and no return payments shall be made to the Buyer or its legal representative. \n7.\tWhere the Service Package is an ???online meeting???, the Buyer is required to log in to the G??ven Online application no later than 5 (five) minutes before the appointment time, be ready for connection and commence the meeting with the physician. If the Buyer is not ready as prescribed for under this article and/or does not attend the meeting at all, the meeting shall be priced as if it were duly conducted, and no return payments shall be made to the Buyer. \n8.\tWhere the Service Package is an ???online meeting???, issues necessary for the Buyer???s consideration to conduct a video meeting and information on the software and hardware necessary for the utilization of the service are listed in the relevant sections of the web page ???https://www.guven.com.tr/online-doktor??? and may be updated from time to time by G??ven Hospital. The Buyer is under the obligation to abide by these as well as to keep track of any updates. \n9.\tThe Buyer represents and undertakes that it has read, understood, and accepted the information listed under Annex-1: Information on the Scope of the Online Doctor and E-Consultation Service and Informed Consent Document. \nARTICLE 4: SEQUENCE OF PERFORMANCE, DEFAULT, AND ITS LEGAL CONSEQUENCES\n1.\tFollowing payment by the Buyer, in compliance with the terms of this Agreement, G??ven Hospital shall provide the service prescribed under the Service Package specified in this Agreement. \n2.\tIn the event of any default on the side of the Buyer, the Buyer agrees to pay for any damages and costs incurred by G??ven Hospital due to the late performance of its obligation. \nARTICLE 5: RIGHT OF WITHDRAWAL\n1.\tThe Buyer, without any civil or criminal consequences and without providing for a cause, may use its right of withdrawal within 14 (fourteen) days, which starts from the date of delivery for the sale of goods, and starts from the date of purchase for the sale of services. For transactions on the sale of goods, the Buyer may also use its right of withdrawal until the delivery of the goods. \n2.\tThe right of withdrawal cannot be used by the Buyer if the service within the scope of the Service Package is used, in part or in full, by the Buyer. Similarly, the right of withdrawal may not be used for services that are being performed following the Buyer???s consent prior to the expiry of the term available for the right of withdrawal. \n3.\tWithin 14 (fourteen) days starting from the date of the Buyer???s use of its right of withdrawal (and on condition that for the sale of goods, the goods are returned through the courier specified for this purpose by G??ven Hospital), all payments made by the Buyer to G??ven Hospital for the relevant good or service shall be returned to or through the payment instrument used by the Buyer for the purchase of the Service Package, without any costs or obligations to the Buyer and in one payment. \n4.\tAny notifications for the right of withdrawal shall be made to the e-mail address of <hospitalEmail> operated by G??ven Hospital. \n5.\tAny costs arising out of the utilization of the right of withdrawal shall be borne by G??ven Hospital. The Buyer agrees in advance that by way of accepting this Agreement, it has been informed of its right of withdrawal. \nARTICLE 6: LIMITATION OF LIABILITY\n1.\tIn all cases, for medical diagnoses, treatments and disease prevention, Buyer is required to consult its physician freely chosen at its own ultimate discretion, not to skip any routine controls and in case of all emergencies, to apply to the closest emergency ward without any delay. G??ven Hospital shall have absolutely no liability for any acts or actions to the contrary. \n2.\tNo medical procedures (such as examinations, diagnoses, or treatments) are offered or provided by the physicians attending G??ven Online through the scope of the ???online meeting???, and G??ven Hospital and/or the physicians attending G??ven Online shall have absolutely no liability for any professed malpractice. \n3.\tThe physicians attending G??ven Online for an ???online meeting??? are not providing any advice. It is the Buyer???s responsibility and obligation to verify the correctness of any information or data provided during an ???online meeting???. G??ven Hospital and the physicians attending G??ven Online shall have absolutely no liability for the use or failure to use of G??ven Online and/or the ???online meeting??? feature, any disruption of the service provided over G??ven Online and any wounding, physical injuries, actual or moral damages, loss of profit, loss of employment opportunity and similar direct or indirect damages. \n4.\tTo the extent possible under the applicable law, G??ven Hospital???s liability for any damages incurred by the Buyer due to the Service Package and Agreement shall be limited by whichever is the lowest of (i) the sum total of the amounts paid by the Buyer to G??ven Hospital over G??ven Online within the 1 (one) calendar month before the occurrence of the event giving rise to liability, or (ii) 1,000 (one thousand) Turkish Liras. \n5.\tThe Buyer shall hold G??ven Hospital harmless in cases where the Buyer damages any third parties by its breach of this Agreement. If G??ven Hospital incurs any damages due to any reason attributable to the Buyer, said damages shall be compensated for by the Buyer promptly, in cash and in full. \nARTICLE 7: MISCELLANEOUS PROVISIONS\n1.\tAll correspondence related with this Agreement by and between the Parties shall be done so through e-mail, except in cases where the applicable legislation explicitly requires another form of communication. For these cases provided for in the applicable legislation, the Parties??? designated addresses shall be deemed as their service addresses. Unless any changes of address are notified to the other Party in 15 (fifteen) days, all notifications to the former address shall be deemed to have been duly served. \n2.\tG??ven Hospital shall bear no liability for any damages or losses arising out of or in connection with any delays or a failure to perform any obligations due to unforeseeable and unpreventable force majeure events out of its control, such as natural disasters, fires, explosions, civil wars, wars, uprisings, riots, mobilizations, strikes, lockouts, and pandemics. In cases where a force majeure event directly affects G??ven Hospital???s obligations provided for in this Agreement, G??ven Hospital reserves its right to unilaterally terminate this agreement without compensation. \n3.\tIf any of the articles or any part of this agreement is deemed as invalid, void or unenforceable, then said article or part shall be construed and performed in a manner and form that is enforceable and that is closest to its literal purpose; however, in cases where this is not possible, said article or part shall be deemed to have been severed and removed from this Agreement and such severance and removal shall in no manner affect or invalidate the remaining articles and terms of this Agreement, and the remaining articles and terms of this Agreement shall continue to remain valid and in full effect. \n4.\tNo waiver shall be valid unless it is in writing and is done so by the Parties. Any failure to request the performance of any of the terms and conditions of this Agreement by any Party, or the waiver of any Party???s rights of recourse due to the breach of this Agreement, shall not prevent the performance of said term or condition in the future or shall not be construed as a waiver of any potential future breach. \n5.\tG??ven Hospital reserves its right to assign any of its rights or liabilities arising out of this Agreement to third parties without any restriction. \n6.\tThe Parties agree and undertake that the laws and regulations of the Republic of Turkey, excluding its choice of law provisions, shall exclusively govern this Agreement, and shall be used to interpret the validity, performance, and construction of this Agreement. \n7.\tIn connection with any disputes arising out of this Agreement, for issues at or below the monetary limit announced annually by the Ministry of Commerce, the District or Provincial Consumer Issues Arbitration Tribunal seated at the registered address of the Buyer or at the location where the Buyer purchased the Service Package shall be authorized, and for any disputes above said monetary limit, Consumer Courts shall have jurisdiction. \n8.\tG??ven Hospital???s official books and commercial records, as well as the electronic information and computer data held in its servers and database, shall be binding, exclusive and definitive evidence. This article is a contract for evidence within the context of Article 193 of the Civil Procedural Law.\n9.\tTHE BUYER AGREES AND REPRESENTS THAT IT HAS READ AND UNDERSTOOD THE INFORMATION PROVIDED TO ITSELF BY G??VEN HOSPITAL ON THE FEATURES OF THE SERVICE THAT IS TO BE PROVIDED OVER G??VEN ONLINE AND THROUGH THIS AGREEMENT AND ITS OBLIGATIONS THEREFROM, THAT IT HAS POSED INQUIRIES ON ISSUES THAT IT DID NOT UNDERSTAND, THAT SUCH INQUIRIES WERE ANSWERED BY AUTHORIZED PERSONNEL AND THAT IT WAS INFORMED IN FULL. \nThis Agreement, being comprised of 7 (seven) articles and 1 (one) annex, has been executed by the Buyer by way of being read and approved electronically, and came into effect immediately. \n\nAnnex-1: Information on the Scope of the Online Doctor and E-Consultation Service and Informed Consent Document\n\nBUYER\t                          G??VEN HASTANES?? A.??.\n\n???\nANNEX-1:\nINFORMATION ON THE SCOPE OF THE ONLINE DOCTOR AND E-CONSULTATION SERVICE\n AND \nINFORMED CONSENT DOCUMENT\nUpdated as of: 03.04.2020\n\nI have been informed in writing of the scope of the ONLINE DOCTOR AND E-CONSULTATION SERVICE (the ???Service???) provided by the web site and mobile applications (the ???Online Platform???) owned by G??ven Hastanesi A.??. (???G??ven Hospital???).\nI have been clearly informed in writing that \n1.\tWithin the scope of the Service, through the Online Platform, the possibility of G??ven Hospital physicians??? advice and consultation is being offered, \n2.\tIn cases where the patient and the physician must be together, the Service is not a substitute for medical examination, \n3.\tFor all personal needs of medical diagnosis and treatment, I must apply to my physician freely chosen at my own ultimate discretion and that I must be physically examined, \n4.\tIn emergency cases that concern my health, I must apply to the nearest emergency ward without delay, and\n5.\tG??ven Hospital carries absolutely no liability for any adverse consequences due to any failure to abide by the above.\nI was provided with phone numbers that I may contact if I had any inquiries as to the above. \nAccordingly: \nI accept and represent that I have read, understood, and accepted all written information relayed to me as they are, and that I will utilize the ONLINE DOCTOR AND E-CONSULTATION SERVICE within the guidelines set forth in said information. \n(This Document has been signed by the BUYER as a supplementary part of the DISTANCE SALES AGREEMENT by and between G??VEN HOSPITAL and the BUYER.)\n\n\n',
      name: 'distance_sales_contract_context',
      desc: '',
      args: [],
    );
  }

  /// `Boy`
  String get boy {
    return Intl.message(
      'Boy',
      name: 'boy',
      desc: '',
      args: [],
    );
  }

  /// `Girl`
  String get girl {
    return Intl.message(
      'Girl',
      name: 'girl',
      desc: '',
      args: [],
    );
  }

  /// `Which department should I go to?`
  String get symptom_checker {
    return Intl.message(
      'Which department should I go to?',
      name: 'symptom_checker',
      desc: '',
      args: [],
    );
  }

  /// `In this section of the application, you are presented with an informative feature (???Symptom Checker???), which indicates which section you should refer to by ticking the areas of your body where you feel discomfort and the options appropriate for your symptoms. The Symptom Checker is a feature that has been produced for you to get support while identifying the potentially relevant section(s) that you only need to apply according to the symptoms marked by you; The Symptom Checker does not guarantee or warrant a precise, accurate, complete and flawless result. If, following the examination of the relevant physician, it is determined that the department(s) applied using the Symptom Controller is irrelevant and/or it is determined that another department(s) should be consulted, no fault can be attributed to us, nor is any liability for compensation for any damages or payments accepted. The Symptom Controller cannot be considered to have made any referrals. No medical procedure (such as examination, diagnosis, diagnosis, treatment) is offered or promised to you with the Symptom Controller; The services provided by the Symptom Controller cannot be interpreted as creating liability for medical malpractice. You are solely responsible for your health and any decisions, actions and practices related to your health. Based on the service provided by the Symptom Controller, you should never stop receiving medical care, delay receiving medical care, refuse medical advice, or terminate your ongoing treatment. The Symptom Controller is not a substitute for physician examination and/or treatment of the patient or monitoring of the patient's health status by a physician. Information presented with the Symptom Controller cannot be considered a medical opinion. In any case, you should consult your doctor for medical diagnosis, treatment and prevention of diseases, do not delay your controls, and apply to the nearest emergency service without losing time in any emergency. Otherwise, we have no responsibility. The Symptom Controller is provided as is (as is) and no representation, commitment or warranty is given to you. No warranty or commitment is made that the Symptom Checker is flawless, error-free, perfect, and will fully meet all your particular needs.`
  String get symptom_checker_consent_form_text {
    return Intl.message(
      'In this section of the application, you are presented with an informative feature (???Symptom Checker???), which indicates which section you should refer to by ticking the areas of your body where you feel discomfort and the options appropriate for your symptoms. The Symptom Checker is a feature that has been produced for you to get support while identifying the potentially relevant section(s) that you only need to apply according to the symptoms marked by you; The Symptom Checker does not guarantee or warrant a precise, accurate, complete and flawless result. If, following the examination of the relevant physician, it is determined that the department(s) applied using the Symptom Controller is irrelevant and/or it is determined that another department(s) should be consulted, no fault can be attributed to us, nor is any liability for compensation for any damages or payments accepted. The Symptom Controller cannot be considered to have made any referrals. No medical procedure (such as examination, diagnosis, diagnosis, treatment) is offered or promised to you with the Symptom Controller; The services provided by the Symptom Controller cannot be interpreted as creating liability for medical malpractice. You are solely responsible for your health and any decisions, actions and practices related to your health. Based on the service provided by the Symptom Controller, you should never stop receiving medical care, delay receiving medical care, refuse medical advice, or terminate your ongoing treatment. The Symptom Controller is not a substitute for physician examination and/or treatment of the patient or monitoring of the patient\'s health status by a physician. Information presented with the Symptom Controller cannot be considered a medical opinion. In any case, you should consult your doctor for medical diagnosis, treatment and prevention of diseases, do not delay your controls, and apply to the nearest emergency service without losing time in any emergency. Otherwise, we have no responsibility. The Symptom Controller is provided as is (as is) and no representation, commitment or warranty is given to you. No warranty or commitment is made that the Symptom Checker is flawless, error-free, perfect, and will fully meet all your particular needs.',
      name: 'symptom_checker_consent_form_text',
      desc: '',
      args: [],
    );
  }

  /// `Add Symptom`
  String get add_symptom {
    return Intl.message(
      'Add Symptom',
      name: 'add_symptom',
      desc: '',
      args: [],
    );
  }

  /// `Department Analysis`
  String get analyze_department {
    return Intl.message(
      'Department Analysis',
      name: 'analyze_department',
      desc: '',
      args: [],
    );
  }

  /// `Your complaints:`
  String get your_complaints {
    return Intl.message(
      'Your complaints:',
      name: 'your_complaints',
      desc: '',
      args: [],
    );
  }

  /// `Choose your birth year:`
  String get select_birth_year {
    return Intl.message(
      'Choose your birth year:',
      name: 'select_birth_year',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_lbl {
    return Intl.message(
      'Continue',
      name: 'continue_lbl',
      desc: '',
      args: [],
    );
  }

  /// `Your Choice : `
  String get choice {
    return Intl.message(
      'Your Choice : ',
      name: 'choice',
      desc: '',
      args: [],
    );
  }

  /// `No results were found for the specified symptoms.`
  String get no_symptom_result {
    return Intl.message(
      'No results were found for the specified symptoms.',
      name: 'no_symptom_result',
      desc: '',
      args: [],
    );
  }

  /// `My Symptoms`
  String get my_symptoms {
    return Intl.message(
      'My Symptoms',
      name: 'my_symptoms',
      desc: '',
      args: [],
    );
  }

  /// `Free Health Counseling`
  String get free_counseling {
    return Intl.message(
      'Free Health Counseling',
      name: 'free_counseling',
      desc: '',
      args: [],
    );
  }

  /// `Do you have one of the following symptoms?`
  String get proposed_symptom {
    return Intl.message(
      'Do you have one of the following symptoms?',
      name: 'proposed_symptom',
      desc: '',
      args: [],
    );
  }

  /// `You have chosen a critical symptom, you need to see a doctor urgently!`
  String get emergency {
    return Intl.message(
      'You have chosen a critical symptom, you need to see a doctor urgently!',
      name: 'emergency',
      desc: '',
      args: [],
    );
  }

  /// `Emergency`
  String get emergency_lbl {
    return Intl.message(
      'Emergency',
      name: 'emergency_lbl',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close_lbl {
    return Intl.message(
      'Close',
      name: 'close_lbl',
      desc: '',
      args: [],
    );
  }

  /// `Detailed Health Check`
  String get detailed_check {
    return Intl.message(
      'Detailed Health Check',
      name: 'detailed_check',
      desc: '',
      args: [],
    );
  }

  /// `In which part of your body is your complaint located?`
  String get complaint_body_part {
    return Intl.message(
      'In which part of your body is your complaint located?',
      name: 'complaint_body_part',
      desc: '',
      args: [],
    );
  }

  /// `Choose your preselection:`
  String get preselection {
    return Intl.message(
      'Choose your preselection:',
      name: 'preselection',
      desc: '',
      args: [],
    );
  }

  /// `Search Appointment`
  String get create_appo {
    return Intl.message(
      'Search Appointment',
      name: 'create_appo',
      desc: '',
      args: [],
    );
  }

  /// `G??ven Hospital Ayranc??`
  String get mars_hosp {
    return Intl.message(
      'G??ven Hospital Ayranc??',
      name: 'mars_hosp',
      desc: '',
      args: [],
    );
  }

  /// `G??ven ??ayyolu Campus`
  String get neptune_hosp {
    return Intl.message(
      'G??ven ??ayyolu Campus',
      name: 'neptune_hosp',
      desc: '',
      args: [],
    );
  }

  /// `Digital Checkup`
  String get digitalcheckup {
    return Intl.message(
      'Digital Checkup',
      name: 'digitalcheckup',
      desc: '',
      args: [],
    );
  }

  /// `Complaint Declaration`
  String get info_report {
    return Intl.message(
      'Complaint Declaration',
      name: 'info_report',
      desc: '',
      args: [],
    );
  }

  /// `Detayl?? Sa??l??k Kontrol??ne ho??geldiniz, l??tfen cinsiyetinizi ve do??um y??l??n??z?? sesli bir ??ekilde s??yler misiniz? ??rne??in, Erkek, 1980`
  String get symptom_checker_welcome {
    return Intl.message(
      'Detayl?? Sa??l??k Kontrol??ne ho??geldiniz, l??tfen cinsiyetinizi ve do??um y??l??n??z?? sesli bir ??ekilde s??yler misiniz? ??rne??in, Erkek, 1980',
      name: 'symptom_checker_welcome',
      desc: '',
      args: [],
    );
  }

  /// `Voice Health Assistant`
  String get voice_nlp {
    return Intl.message(
      'Voice Health Assistant',
      name: 'voice_nlp',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Person to make an appointment :`
  String get appo_for {
    return Intl.message(
      'Person to make an appointment :',
      name: 'appo_for',
      desc: '',
      args: [],
    );
  }

  /// `Please select a person`
  String get pls_select_person {
    return Intl.message(
      'Please select a person',
      name: 'pls_select_person',
      desc: '',
      args: [],
    );
  }

  /// `Patient Name :`
  String get patient_name {
    return Intl.message(
      'Patient Name :',
      name: 'patient_name',
      desc: '',
      args: [],
    );
  }

  /// `Patient Name`
  String get patient_name_2 {
    return Intl.message(
      'Patient Name',
      name: 'patient_name_2',
      desc: '',
      args: [],
    );
  }

  /// `Hospital Name :`
  String get tenant_name {
    return Intl.message(
      'Hospital Name :',
      name: 'tenant_name',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Name :`
  String get doctor_name {
    return Intl.message(
      'Doctor Name :',
      name: 'doctor_name',
      desc: '',
      args: [],
    );
  }

  /// `Department :`
  String get depart_name {
    return Intl.message(
      'Department :',
      name: 'depart_name',
      desc: '',
      args: [],
    );
  }

  /// `Hospital selection :`
  String get hosp_selection {
    return Intl.message(
      'Hospital selection :',
      name: 'hosp_selection',
      desc: '',
      args: [],
    );
  }

  /// `Please select hospital`
  String get pls_select_hosp {
    return Intl.message(
      'Please select hospital',
      name: 'pls_select_hosp',
      desc: '',
      args: [],
    );
  }

  /// `Department selection :`
  String get depart_selection {
    return Intl.message(
      'Department selection :',
      name: 'depart_selection',
      desc: '',
      args: [],
    );
  }

  /// `Please select department`
  String get pls_select_depart {
    return Intl.message(
      'Please select department',
      name: 'pls_select_depart',
      desc: '',
      args: [],
    );
  }

  /// `Doctor selection :`
  String get doctor_selection {
    return Intl.message(
      'Doctor selection :',
      name: 'doctor_selection',
      desc: '',
      args: [],
    );
  }

  /// `Please select doctor`
  String get pls_select_doctor {
    return Intl.message(
      'Please select doctor',
      name: 'pls_select_doctor',
      desc: '',
      args: [],
    );
  }

  /// `Department finder`
  String get which_depart_i_go {
    return Intl.message(
      'Department finder',
      name: 'which_depart_i_go',
      desc: '',
      args: [],
    );
  }

  /// `Department analyze`
  String get depart_analyse {
    return Intl.message(
      'Department analyze',
      name: 'depart_analyse',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get pls_select {
    return Intl.message(
      'Choose',
      name: 'pls_select',
      desc: '',
      args: [],
    );
  }

  /// `Update Information`
  String get update_information {
    return Intl.message(
      'Update Information',
      name: 'update_information',
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

  /// `Fri`
  String get weekdays_friday_short {
    return Intl.message(
      'Fri',
      name: 'weekdays_friday_short',
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

  /// `Apple credential error`
  String get apple_credential_error {
    return Intl.message(
      'Apple credential error',
      name: 'apple_credential_error',
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

  /// `Blood Glucose Measurement Reminder`
  String get blood_glucose_measurement {
    return Intl.message(
      'Blood Glucose Measurement Reminder',
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

  /// `Blood Glucose Tracking`
  String get bg_graph {
    return Intl.message(
      'Blood Glucose Tracking',
      name: 'bg_graph',
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

  /// `Change Graph`
  String get change_graph_type {
    return Intl.message(
      'Change Graph',
      name: 'change_graph_type',
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

  /// `MD Hotline`
  String get consultation {
    return Intl.message(
      'MD Hotline',
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

  /// `Date of birth`
  String get date_of_birth {
    return Intl.message(
      'Date of birth',
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

  /// `Do you want to delete selected reminder?`
  String get delete_medicine_confirm_message {
    return Intl.message(
      'Do you want to delete selected reminder?',
      name: 'delete_medicine_confirm_message',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete all reminders?`
  String get delete_medicine_confirm_all_message {
    return Intl.message(
      'Do you want to delete all reminders?',
      name: 'delete_medicine_confirm_all_message',
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

  /// `Diabet type`
  String get diabet_type {
    return Intl.message(
      'Diabet type',
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

  /// `Please select at least one day.`
  String get error_empty_specific_day_selected {
    return Intl.message(
      'Please select at least one day.',
      name: 'error_empty_specific_day_selected',
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

  /// `One time`
  String get one_time {
    return Intl.message(
      'One time',
      name: 'one_time',
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

  /// `HbA1c Measurement Reminder`
  String get hbA1c_measurement {
    return Intl.message(
      'HbA1c Measurement Reminder',
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

  /// `How many reminders you need?`
  String get how_many_reminder_is_needed {
    return Intl.message(
      'How many reminders you need?',
      name: 'how_many_reminder_is_needed',
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

  /// `TC / Passport no`
  String get identity_passport {
    return Intl.message(
      'TC / Passport no',
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

  /// `Last test value`
  String get last_result {
    return Intl.message(
      'Last test value',
      name: 'last_result',
      desc: '',
      args: [],
    );
  }

  /// `Last test date`
  String get last_test_date {
    return Intl.message(
      'Last test date',
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

  /// `Normal range`
  String get normal_range {
    return Intl.message(
      'Normal range',
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

  /// `Pair Steps:`
  String get pair_steps {
    return Intl.message(
      'Pair Steps:',
      name: 'pair_steps',
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

  /// `MyBloodGlucoseReport.pdf`
  String get pdf_filename {
    return Intl.message(
      'MyBloodGlucoseReport.pdf',
      name: 'pdf_filename',
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

  /// `Reminder date`
  String get reminder_date {
    return Intl.message(
      'Reminder date',
      name: 'reminder_date',
      desc: '',
      args: [],
    );
  }

  /// `Reminder hour`
  String get reminder_hour {
    return Intl.message(
      'Reminder hour',
      name: 'reminder_hour',
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

  /// `Specific`
  String get specific {
    return Intl.message(
      'Specific',
      name: 'specific',
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

  /// `Strip number`
  String get strip_number_2 {
    return Intl.message(
      'Strip number',
      name: 'strip_number_2',
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

  /// `Strip Reminder`
  String get strip_tracker {
    return Intl.message(
      'Strip Reminder',
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

  /// `2 Week`
  String get two_Week {
    return Intl.message(
      '2 Week',
      name: 'two_Week',
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

  /// `We're currently facing unexpected issue. Please try again later...`
  String get we_have_an_error {
    return Intl.message(
      'We\'re currently facing unexpected issue. Please try again later...',
      name: 'we_have_an_error',
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

  /// `Mon`
  String get weekdays_monday_short {
    return Intl.message(
      'Mon',
      name: 'weekdays_monday_short',
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

  /// `Sat`
  String get weekdays_saturday_short {
    return Intl.message(
      'Sat',
      name: 'weekdays_saturday_short',
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

  /// `Sun`
  String get weekdays_sunday_short {
    return Intl.message(
      'Sun',
      name: 'weekdays_sunday_short',
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

  /// `Thu`
  String get weekdays_thursday_short {
    return Intl.message(
      'Thu',
      name: 'weekdays_thursday_short',
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

  /// `Tue`
  String get weekdays_tuesday_short {
    return Intl.message(
      'Tue',
      name: 'weekdays_tuesday_short',
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

  /// `Wed`
  String get weekdays_wednesday_short {
    return Intl.message(
      'Wed',
      name: 'weekdays_wednesday_short',
      desc: '',
      args: [],
    );
  }

  /// `Your payment is successful `
  String get payment_successful {
    return Intl.message(
      'Your payment is successful ',
      name: 'payment_successful',
      desc: '',
      args: [],
    );
  }

  /// `Your payment is not successful.\nPlease call 444 25 25`
  String get payment_not_successful {
    return Intl.message(
      'Your payment is not successful.\nPlease call 444 25 25',
      name: 'payment_not_successful',
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

  /// `Year of diagnosis`
  String get year_of_diagnosis {
    return Intl.message(
      'Year of diagnosis',
      name: 'year_of_diagnosis',
      desc: '',
      args: [],
    );
  }

  /// `Test stribini cihaza yerle??tirin.`
  String get accu_check_step1 {
    return Intl.message(
      'Test stribini cihaza yerle??tirin.',
      name: 'accu_check_step1',
      desc: '',
      args: [],
    );
  }

  /// `Bir kan damlas?? ????kartmak i??in parma????n??z?? parmak delme cihaz?? kullan??n.`
  String get accu_check_step2 {
    return Intl.message(
      'Bir kan damlas?? ????kartmak i??in parma????n??z?? parmak delme cihaz?? kullan??n.',
      name: 'accu_check_step2',
      desc: '',
      args: [],
    );
  }

  /// `Kan damlas??n?? test stribinin sar?? u??lu alan??na dikkatlice dokundurun.`
  String get accu_check_step3 {
    return Intl.message(
      'Kan damlas??n?? test stribinin sar?? u??lu alan??na dikkatlice dokundurun.',
      name: 'accu_check_step3',
      desc: '',
      args: [],
    );
  }

  /// `Kan ??ekeri sonucunu g??r??nt??leyin.`
  String get accu_check_step4 {
    return Intl.message(
      'Kan ??ekeri sonucunu g??r??nt??leyin.',
      name: 'accu_check_step4',
      desc: '',
      args: [],
    );
  }

  /// `Test stribini cihaza yerle??tirin.`
  String get contour_plus_blood_step1 {
    return Intl.message(
      'Test stribini cihaza yerle??tirin.',
      name: 'contour_plus_blood_step1',
      desc: '',
      args: [],
    );
  }

  /// `Bir kan damlas?? ????kartmak i??in parma????n??z?? parmak delme cihaz?? kullan??n.`
  String get contour_plus_blood_step2 {
    return Intl.message(
      'Bir kan damlas?? ????kartmak i??in parma????n??z?? parmak delme cihaz?? kullan??n.',
      name: 'contour_plus_blood_step2',
      desc: '',
      args: [],
    );
  }

  /// `Kan damlas??n?? test stribinin sar?? u??lu alan??na dikkatlice dokundurun.`
  String get contour_plus_blood_step3 {
    return Intl.message(
      'Kan damlas??n?? test stribinin sar?? u??lu alan??na dikkatlice dokundurun.',
      name: 'contour_plus_blood_step3',
      desc: '',
      args: [],
    );
  }

  /// `Kan ??ekeri sonucunu g??r??nt??leyin.`
  String get contour_plus_blood_step4 {
    return Intl.message(
      'Kan ??ekeri sonucunu g??r??nt??leyin.',
      name: 'contour_plus_blood_step4',
      desc: '',
      args: [],
    );
  }

  /// `Cihaz??n band??n?? dirse??inizin hemen ??zerinden ba??lay??n`
  String get omron_arm_step1 {
    return Intl.message(
      'Cihaz??n band??n?? dirse??inizin hemen ??zerinden ba??lay??n',
      name: 'omron_arm_step1',
      desc: '',
      args: [],
    );
  }

  /// `Kolunuzu serbest b??rak??n`
  String get omron_arm_step2 {
    return Intl.message(
      'Kolunuzu serbest b??rak??n',
      name: 'omron_arm_step2',
      desc: '',
      args: [],
    );
  }

  /// `Cihaz ??zerinde bulunan start d????mesine bas??n`
  String get omron_arm_step3 {
    return Intl.message(
      'Cihaz ??zerinde bulunan start d????mesine bas??n',
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

  /// `Cihaz ??l????m yaparken rahat ve hareketsiz bekled??inizden emin olun.`
  String get omron_arm_step5 {
    return Intl.message(
      'Cihaz ??l????m yaparken rahat ve hareketsiz bekled??inizden emin olun.',
      name: 'omron_arm_step5',
      desc: '',
      args: [],
    );
  }

  /// `Cihaz??n band??n?? el bile??inize ba??lay??n`
  String get omron_wrist_step1 {
    return Intl.message(
      'Cihaz??n band??n?? el bile??inize ba??lay??n',
      name: 'omron_wrist_step1',
      desc: '',
      args: [],
    );
  }

  /// `Kolunuzu serbest b??rak??n`
  String get omron_wrist_step2 {
    return Intl.message(
      'Kolunuzu serbest b??rak??n',
      name: 'omron_wrist_step2',
      desc: '',
      args: [],
    );
  }

  /// `Cihaz ??zerinde bulunan start d????mesine bas??n`
  String get omron_wrist_step3 {
    return Intl.message(
      'Cihaz ??zerinde bulunan start d????mesine bas??n',
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

  /// `Cihaz ??l????m yaparken rahat ve hareketsiz bekled??inizden emin olun.`
  String get omron_wrist_step5 {
    return Intl.message(
      'Cihaz ??l????m yaparken rahat ve hareketsiz bekled??inizden emin olun.',
      name: 'omron_wrist_step5',
      desc: '',
      args: [],
    );
  }

  /// `Tart??n??z?? d??z bir zemine yerle??tirin.`
  String get omron_scale_step1 {
    return Intl.message(
      'Tart??n??z?? d??z bir zemine yerle??tirin.',
      name: 'omron_scale_step1',
      desc: '',
      args: [],
    );
  }

  /// `Kan bas??nc?? ve detayl?? ya?? ??l????m?? i??in yal??n ayak ??ekilde cihaz??n ??zerine ????k??n.`
  String get omron_scale_step2 {
    return Intl.message(
      'Kan bas??nc?? ve detayl?? ya?? ??l????m?? i??in yal??n ayak ??ekilde cihaz??n ??zerine ????k??n.',
      name: 'omron_scale_step2',
      desc: '',
      args: [],
    );
  }

  /// `Parmak u??lar??n??zda veya topuklar??n??z ??zerinde durmad??????n??zdan emin olun.`
  String get omron_scale_step3 {
    return Intl.message(
      'Parmak u??lar??n??zda veya topuklar??n??z ??zerinde durmad??????n??zdan emin olun.',
      name: 'omron_scale_step3',
      desc: '',
      args: [],
    );
  }

  /// `Cihaz ??zerinde 4 saniye stabil olarak bekleyin.`
  String get omron_scale_step4 {
    return Intl.message(
      'Cihaz ??zerinde 4 saniye stabil olarak bekleyin.',
      name: 'omron_scale_step4',
      desc: '',
      args: [],
    );
  }

  /// `Ekranda ??l????m??n??z?? g??rebilirsiniz.`
  String get omron_scale_step5 {
    return Intl.message(
      'Ekranda ??l????m??n??z?? g??rebilirsiniz.',
      name: 'omron_scale_step5',
      desc: '',
      args: [],
    );
  }

  /// `Tart??n??z?? d??z bir zemine yerle??tirin.`
  String get mi_scale_step1 {
    return Intl.message(
      'Tart??n??z?? d??z bir zemine yerle??tirin.',
      name: 'mi_scale_step1',
      desc: '',
      args: [],
    );
  }

  /// `Kan bas??nc?? ve detayl?? ya?? ??l????m?? i??in yal??n ayak ??ekilde cihaz??n ??zerine ????k??n.`
  String get mi_scale_step2 {
    return Intl.message(
      'Kan bas??nc?? ve detayl?? ya?? ??l????m?? i??in yal??n ayak ??ekilde cihaz??n ??zerine ????k??n.',
      name: 'mi_scale_step2',
      desc: '',
      args: [],
    );
  }

  /// `Parmak u??lar??n??zda veya topuklar??n??z ??zerinde durmad??????n??zdan emin olun.`
  String get mi_scale_step3 {
    return Intl.message(
      'Parmak u??lar??n??zda veya topuklar??n??z ??zerinde durmad??????n??zdan emin olun.',
      name: 'mi_scale_step3',
      desc: '',
      args: [],
    );
  }

  /// `Cihaz ??zerinde 4 saniye stabil olarak bekleyin.`
  String get mi_scale_step4 {
    return Intl.message(
      'Cihaz ??zerinde 4 saniye stabil olarak bekleyin.',
      name: 'mi_scale_step4',
      desc: '',
      args: [],
    );
  }

  /// `Ekranda ??l????m??n??z?? g??rebilirsiniz.`
  String get mi_scale_step5 {
    return Intl.message(
      'Ekranda ??l????m??n??z?? g??rebilirsiniz.',
      name: 'mi_scale_step5',
      desc: '',
      args: [],
    );
  }

  /// `Diagnosis Date`
  String get diagnosisDate {
    return Intl.message(
      'Diagnosis Date',
      name: 'diagnosisDate',
      desc: '',
      args: [],
    );
  }

  /// `High Range`
  String get high_range {
    return Intl.message(
      'High Range',
      name: 'high_range',
      desc: '',
      args: [],
    );
  }

  /// `Low Range`
  String get low_range {
    return Intl.message(
      'Low Range',
      name: 'low_range',
      desc: '',
      args: [],
    );
  }

  /// `Do you smoke?`
  String get do_you_smoke {
    return Intl.message(
      'Do you smoke?',
      name: 'do_you_smoke',
      desc: '',
      args: [],
    );
  }

  /// `Strip count is low`
  String get strip_count_low {
    return Intl.message(
      'Strip count is low',
      name: 'strip_count_low',
      desc: '',
      args: [],
    );
  }

  /// `You have <stripCount> strips left`
  String get you_have_strip {
    return Intl.message(
      'You have <stripCount> strips left',
      name: 'you_have_strip',
      desc: '',
      args: [],
    );
  }

  /// `<stripCount>`
  String get strpCnt {
    return Intl.message(
      '<stripCount>',
      name: 'strpCnt',
      desc: '',
      args: [],
    );
  }

  /// `T.C. no / Passport no`
  String get sign_in_keys {
    return Intl.message(
      'T.C. no / Passport no',
      name: 'sign_in_keys',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `The future of healthcare!`
  String get login_page_text {
    return Intl.message(
      'The future of healthcare!',
      name: 'login_page_text',
      desc: '',
      args: [],
    );
  }

  /// `Let's know you better!`
  String get sign_up_text {
    return Intl.message(
      'Let\'s know you better!',
      name: 'sign_up_text',
      desc: '',
      args: [],
    );
  }

  /// `I am a Turkish citizen`
  String get tr_citizen {
    return Intl.message(
      'I am a Turkish citizen',
      name: 'tr_citizen',
      desc: '',
      args: [],
    );
  }

  /// `Camera permission is not granted`
  String get no_permission {
    return Intl.message(
      'Camera permission is not granted',
      name: 'no_permission',
      desc: '',
      args: [],
    );
  }

  /// `Discount Code`
  String get discount_code {
    return Intl.message(
      'Discount Code',
      name: 'discount_code',
      desc: '',
      args: [],
    );
  }

  /// `Fee`
  String get price {
    return Intl.message(
      'Fee',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Make Payment`
  String get pay {
    return Intl.message(
      'Make Payment',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Add discount code`
  String get add_discount_code {
    return Intl.message(
      'Add discount code',
      name: 'add_discount_code',
      desc: '',
      args: [],
    );
  }

  /// `Apply discount`
  String get apply_discount {
    return Intl.message(
      'Apply discount',
      name: 'apply_discount',
      desc: '',
      args: [],
    );
  }

  /// `Cancel discount`
  String get cancel_discount {
    return Intl.message(
      'Cancel discount',
      name: 'cancel_discount',
      desc: '',
      args: [],
    );
  }

  /// `Device not found!`
  String get device_not_found {
    return Intl.message(
      'Device not found!',
      name: 'device_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Not Found`
  String get not_found {
    return Intl.message(
      'Not Found',
      name: 'not_found',
      desc: '',
      args: [],
    );
  }

  /// `Oops. Something went wrong!`
  String get something_went_wrong {
    return Intl.message(
      'Oops. Something went wrong!',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Turn Back`
  String get turn_back {
    return Intl.message(
      'Turn Back',
      name: 'turn_back',
      desc: '',
      args: [],
    );
  }

  /// `Waiting`
  String get waiting {
    return Intl.message(
      'Waiting',
      name: 'waiting',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Blood Glucose Tracking`
  String get bg_measurement_tracking {
    return Intl.message(
      'Blood Glucose Tracking',
      name: 'bg_measurement_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Body Scale Tracking`
  String get bmi_tracking {
    return Intl.message(
      'Body Scale Tracking',
      name: 'bmi_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Blood Pressure Tracking`
  String get bp_tracking {
    return Intl.message(
      'Blood Pressure Tracking',
      name: 'bp_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Blood Pressure Tracking`
  String get blood_pressure_tracking {
    return Intl.message(
      'Blood Pressure Tracking',
      name: 'blood_pressure_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Treatment Process`
  String get treatment_process {
    return Intl.message(
      'Treatment Process',
      name: 'treatment_process',
      desc: '',
      args: [],
    );
  }

  /// `Critical metrics`
  String get critical_metrics {
    return Intl.message(
      'Critical metrics',
      name: 'critical_metrics',
      desc: '',
      args: [],
    );
  }

  /// `Diastolic Blood Pressure`
  String get dia {
    return Intl.message(
      'Diastolic Blood Pressure',
      name: 'dia',
      desc: '',
      args: [],
    );
  }

  /// `Systolic Blood Pressure`
  String get sys {
    return Intl.message(
      'Systolic Blood Pressure',
      name: 'sys',
      desc: '',
      args: [],
    );
  }

  /// `Pulse`
  String get pulse {
    return Intl.message(
      'Pulse',
      name: 'pulse',
      desc: '',
      args: [],
    );
  }

  /// `Video Call`
  String get video_call {
    return Intl.message(
      'Video Call',
      name: 'video_call',
      desc: '',
      args: [],
    );
  }

  /// `From newest`
  String get from_newest {
    return Intl.message(
      'From newest',
      name: 'from_newest',
      desc: '',
      args: [],
    );
  }

  /// `From oldest`
  String get from_oldest {
    return Intl.message(
      'From oldest',
      name: 'from_oldest',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get sort_by {
    return Intl.message(
      'Sort by',
      name: 'sort_by',
      desc: '',
      args: [],
    );
  }

  /// `Appointment has expired. No Translator Can Be Requested!`
  String get expired_interpreter_request {
    return Intl.message(
      'Appointment has expired. No Translator Can Be Requested!',
      name: 'expired_interpreter_request',
      desc: '',
      args: [],
    );
  }

  /// `The passwords entered do not match.`
  String get passwords_not_match {
    return Intl.message(
      'The passwords entered do not match.',
      name: 'passwords_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Select day`
  String get select_day_from {
    return Intl.message(
      'Select day',
      name: 'select_day_from',
      desc: '',
      args: [],
    );
  }

  /// `Select another day`
  String get select_day_to {
    return Intl.message(
      'Select another day',
      name: 'select_day_to',
      desc: '',
      args: [],
    );
  }

  /// `Healthcare Employee`
  String get healthcare_employee {
    return Intl.message(
      'Healthcare Employee',
      name: 'healthcare_employee',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Please register a device`
  String get device_register {
    return Intl.message(
      'Please register a device',
      name: 'device_register',
      desc: '',
      args: [],
    );
  }

  /// `Detailed Symptom Checker`
  String get detailed_symptom {
    return Intl.message(
      'Detailed Symptom Checker',
      name: 'detailed_symptom',
      desc: '',
      args: [],
    );
  }

  /// `You have 7 widgets currently in use. Remove one of them to add new widget`
  String get widgets_add_message {
    return Intl.message(
      'You have 7 widgets currently in use. Remove one of them to add new widget',
      name: 'widgets_add_message',
      desc: '',
      args: [],
    );
  }

  /// `Show Graph`
  String get open_chart {
    return Intl.message(
      'Show Graph',
      name: 'open_chart',
      desc: '',
      args: [],
    );
  }

  /// `Hide Graph`
  String get close_chart {
    return Intl.message(
      'Hide Graph',
      name: 'close_chart',
      desc: '',
      args: [],
    );
  }

  /// `Recent Appointments`
  String get recent_appointments {
    return Intl.message(
      'Recent Appointments',
      name: 'recent_appointments',
      desc: '',
      args: [],
    );
  }

  /// `Recover your password`
  String get recover_your_password {
    return Intl.message(
      'Recover your password',
      name: 'recover_your_password',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any notifications yet`
  String get notification_inbox_empty {
    return Intl.message(
      'You don\'t have any notifications yet',
      name: 'notification_inbox_empty',
      desc: '',
      args: [],
    );
  }

  /// `Select tag`
  String get select_tag {
    return Intl.message(
      'Select tag',
      name: 'select_tag',
      desc: '',
      args: [],
    );
  }

  /// `After Meal`
  String get after_meal {
    return Intl.message(
      'After Meal',
      name: 'after_meal',
      desc: '',
      args: [],
    );
  }

  /// `Before Meal`
  String get before_meal {
    return Intl.message(
      'Before Meal',
      name: 'before_meal',
      desc: '',
      args: [],
    );
  }

  /// `How often`
  String get how_often {
    return Intl.message(
      'How often',
      name: 'how_often',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get alert {
    return Intl.message(
      'Alert',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `How many times a day?`
  String get how_many_times_a_day {
    return Intl.message(
      'How many times a day?',
      name: 'how_many_times_a_day',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Since you did not select a day, the date has not changed.`
  String get appointment_datepicker_warning {
    return Intl.message(
      'Since you did not select a day, the date has not changed.',
      name: 'appointment_datepicker_warning',
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
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
