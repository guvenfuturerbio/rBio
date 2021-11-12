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

  static LocaleProvider _current;

  static LocaleProvider get current {
    assert(_current != null,
        'No instance of LocaleProvider was loaded. Try to initialize the LocaleProvider delegate before accessing LocaleProvider.current.');
    return _current;
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
    return instance;
  }

  static LocaleProvider maybeOf(BuildContext context) {
    return Localizations.of<LocaleProvider>(context, LocaleProvider);
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

  /// `SIGN IN`
  String get btn_sign_in {
    return Intl.message(
      'SIGN IN',
      name: 'btn_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `SIGN UP`
  String get btn_sign_up {
    return Intl.message(
      'SIGN UP',
      name: 'btn_sign_up',
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

  /// `FEMALE`
  String get gender_female {
    return Intl.message(
      'FEMALE',
      name: 'gender_female',
      desc: '',
      args: [],
    );
  }

  /// `MALE`
  String get gender_male {
    return Intl.message(
      'MALE',
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

  /// `new password`
  String get new_password {
    return Intl.message(
      'new password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `new password again`
  String get new_password_again {
    return Intl.message(
      'new password again',
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

  /// `Checking for updates...`
  String get check_for_updates {
    return Intl.message(
      'Checking for updates...',
      name: 'check_for_updates',
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

  /// `Informed consent forṁ`
  String get informed_consent_form {
    return Intl.message(
      'Informed consent forṁ',
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

  /// `GÜVENin`
  String get guven_journal {
    return Intl.message(
      'GÜVENin',
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

  /// `Seçilen tarihler için sonuç bulunamadı. Tarih aralığınızı değiştirebilirsiniz.`
  String get no_result_selected_date {
    return Intl.message(
      'Seçilen tarihler için sonuç bulunamadı. Tarih aralığınızı değiştirebilirsiniz.',
      name: 'no_result_selected_date',
      desc: '',
      args: [],
    );
  }

  /// `Değer`
  String get value {
    return Intl.message(
      'Değer',
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

  /// `Güven Hospital Ayrancı`
  String get guven_hospital_ayranci {
    return Intl.message(
      'Güven Hospital Ayrancı',
      name: 'guven_hospital_ayranci',
      desc: '',
      args: [],
    );
  }

  /// `Güven Çayyolu Campus`
  String get guven_cayyolu_campus {
    return Intl.message(
      'Güven Çayyolu Campus',
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

  /// `(Bad 1 … 5 Very Good)`
  String get video_call_legand {
    return Intl.message(
      '(Bad 1 … 5 Very Good)',
      name: 'video_call_legand',
      desc: '',
      args: [],
    );
  }

  /// `(Not Satisfied 1 … 5 Very Satisfied)`
  String get doctor_legand {
    return Intl.message(
      '(Not Satisfied 1 … 5 Very Satisfied)',
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

  /// `This Form; In order to provide you with a better service, it has been prepared for you to report the problems / suggestions you have experienced and observed in ANKARA GUVEN HOSPITAL and your thanks. Your notification will be examined by the Hospital Management as soon as possible, and you will be informed about the measures taken and the arrangements to be made. Thank you for your interest and contribution.`
  String get request_and_suggestions_text {
    return Intl.message(
      'This Form; In order to provide you with a better service, it has been prepared for you to report the problems / suggestions you have experienced and observed in ANKARA GUVEN HOSPITAL and your thanks. Your notification will be examined by the Hospital Management as soon as possible, and you will be informed about the measures taken and the arrangements to be made. Thank you for your interest and contribution.',
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

  /// `ONLINE DOKTOR VE E-KONSÜLTASYON KİŞİSEL VERİLERİN KORUNMASI HUKUKU AYDINLATMA METNİ`
  String get kvkk_title {
    return Intl.message(
      'ONLINE DOKTOR VE E-KONSÜLTASYON KİŞİSEL VERİLERİN KORUNMASI HUKUKU AYDINLATMA METNİ',
      name: 'kvkk_title',
      desc: '',
      args: [],
    );
  }

  /// `Remzi Oğuz Arık Mahallesi Paris Cad. No:58 Çankaya Ankara adresinde mukim Güven Hastanesi A.Ş. olarak kişisel verilerinizin gizliğine ve korunmasına büyük önem veriyoruz. 6698 sayılı Kişisel Verilerin Korunması Kanunu (KVKK) kapsamında kişisel veri politikalarımız hakkında sizleri bilgilendirmek isteriz. \n\nYürüttüğümüz faaliyet sırasında sizden aldığımız kişisel bilgileriniz bakımından Veri Sorumlusu olarak addedilmekteyiz. Veri Sorumlusu olarak, kişisel bilgileriniz aşağıda açıklandığı çerçevede sözlü, yazılı veya elektronik ortamda kaydedilebilecek, saklanabilecek, güncellenebilecek, sınıflandırılabilecek, mevzuatın izin verdiği hallerde 3. kişilere ve/veya yurt dışına açıklanabilecek ve/veya devredilebilecek ve KVKK’da sayılan diğer şekillerde işlenebilecektir.\n\nKişisel verilerin işlenme amaçları ve hukuki sebepleri; elektronik veya kâğıt ortamında işleme dayanak olacak tüm kayıt ve belgeleri düzenlemek; mevzuat ve ilgili otoritelerce öngörülen bilgi saklama, raporlama, bilgilendirme yükümlülüklerine uymak; talep edilen ürün ve hizmetlerini sunabilmek ve akdettiğiniz sözleşmenin gereğini alacağınız ürün veya hizmetleri yerine getirmektir.\n\nMüşterilerimize daha iyi hizmet verebilmek amacıyla bazı kişisel bilgilerinizi (isim, yaş, ilgi alanlarınız, e-posta vb.) sizlerden talep etmekteyiz. Sunucularımızda toplanan bu bilgiler, dönemsel kampanya çalışmaları, müşteri profillerine yönelik özel promosyon faaliyetlerinin kurgulanması ve istenmeyen e-postaların iletilmemesine yönelik müşteri “sınıflandırma” ve kişisel bilgiler vasıtasıyla oluşturulacak reklam, tanıtım, pazarlama faaliyetlerinin devam etmesi amacıyla saklanmakta ve bu amaçlarla kullanılmaktadır.\n\nWeb sitesi ve mobil uygulamalar üzerinden alışveriş yapanın/yaptıranın kimlik bilgilerini teyit etmek, iletişim için adres ve diğer gerekli bilgileri kaydetmek, mesafeli satış sözleşmesi ve Tüketicinin Korunması Hakkında Kanunun ilgili maddeleri tahtında akdettiğimiz sözleşmelerin koşulları, güncel durumu ve güncellemeler ile ilgili müşterilerimiz ile iletişime geçmek, gerekli bilgilendirmeleri yapabilmek, elektronik (internet/mobil vs.) veya kağıt ortamında işleme dayanak olacak tüm kayıt ve belgeleri düzenlemek, mesafeli satış sözleşmesi ve Tüketicinin Korunması Hakkında Kanunun ilgili maddeleri tahtında akdettiğimiz sözleşmeler uyarınca üstlenilen yükümlülükleri ifa etmek, Kamu güvenliğine ilişkin hususlarda talep halinde ve mevzuat gereği kamu görevlilerine bilgi verebilmek, Müşterilerimize daha iyi bir alışveriş deneyimini sağlamak, müşterilerimizin ilgi alanlarını dikkate alarak müşterilerimizin ilgilenebileceği ürünlerimiz hakkında müşterilerimize bilgi verebilmek, kampanyaları aktarmak, Müşteri memnuniyetini artırmak, web sitesi ve/veya mobil uygulamalardan alışveriş yapan müşterilerimizi tanıyabilmek ve müşteri çevresi analizinde kullanabilmek, çeşitli pazarlama ve reklam faaliyetlerinde kullanabilmek ve bu kapsamda anlaşmalı kuruluşlar aracılığıyla elektronik ortamda ve/veya fiziki ortamda anketler düzenlemek, Anlaşmalı kurumlarımız ve çözüm ortaklarımız tarafından müşterilerimize öneri sunabilmek, hizmetlerimizle ilgili müşterilerimizi bilgilendirebilmek, Hizmetlerimiz ile ilgili müşteri şikayet ve önerilerini değerlendirebilmek,  Yasal yükümlülüklerimizi yerine getirebilmek ve yürürlükteki mevzuattan doğan haklarımızı kullanabilmek amacıyla kişisel verilerinizi işleyebilmekte ve saklamaktayız. \n\nYukarıda belirtilen amaçlarla, kişisel verilerin aktarılabileceği kişi ya da kuruluşlar;  ana hissedarımız, doğrudan ve/veya dolaylı yurtiçi ya da yurtdışı iştiraklerimiz; faaliyetlerimizi yürütmek üzere hizmet aldığımız, işbirliği yaptığımız, iş ortağı kuruluşlar, Gizlilik Sözleşmesi uyarınca onay vereceğiniz ortaklar ve diğer 3. kişilerdir. \n\nKVKK’nın 11. maddesi gereği Güven Hastanesi A.Ş. ne başvurarak, kişisel verilerinizin; a) işlenip işlenmediğini öğrenme, b) işlenmişse bilgi talep etme, c) işlenme amacını ve amacına uygun kullanılıp kullanılmadığını öğrenme, d) yurt içinde ya da yurt dışında aktarıldığı 3. kişileri bilme, e) eksik ya da yanlış işlenmişse düzeltilmesini isteme, f) KVKK’nın 7. maddesinde öngörülen şartlar çerçevesinde silinmesini ya da yok edilmesini isteme, g) aktarıldığı 3. kişilere yukarıda sayılan (e) ve (f) bentleri uyarınca yapılan işlemlerin bildirilmesini isteme, h) münhasıran otomatik sistemler ile analiz edilmesi nedeniyle aleyhinize bir sonucun ortaya çıkmasına itiraz etme, i) kanuna aykırı olarak işlenmesi sebebiyle zarara uğramanız halinde zararın giderilmesini talep etme hakkına sahipsiniz. \n\n \n\nHak kullanım talebinizi iletebileceğiniz e-posta adresi ve posta adresi bilgilerimiz aşağıdaki gibidir: \n\n \n\n \n\n\nguven@guven.com.tr\n\nRemzi Oğuz Arık Mahallesi Paris Cad. No:58 Çankaya Ankara \n\n \n\n6698 sayılı Kanun ve ilgili diğer hükümlerine uygun olarak işlenmiş olmasına rağmen, işlenmesini gerektiren sebeplerin ortadan kalkması halinde kişisel veriler, şirketimiz tarafından veya talebiniz üzerine silinir, yok edilir veya anonim hale getirilir. Ancak 6563 Sayılı Elektronik Ticaretin Düzenlenmesi Hakkında Kanun uyarınca; onayın geri alındığına ilişkin kayıtlar bu tarihten itibaren 1 yıl; ticari elektronik iletinin içeriği ve gönderiye ilişkin diğer her türlü kayıt ise gerektiğinde ilgili Bakanlığa sunulmak üzere 3 yıl saklanacaktır. Süre geçtikten sonra kişisel verileriniz şirketimiz tarafından veya talebiniz üzerine silinir, yok edilir veya anonim hale getirilir.\n\nSaygılarımızla bilgilerinize sunarız. \n\nGÜVEN HASTANESİ A.Ş.`
  String get kvkk_url_text {
    return Intl.message(
      'Remzi Oğuz Arık Mahallesi Paris Cad. No:58 Çankaya Ankara adresinde mukim Güven Hastanesi A.Ş. olarak kişisel verilerinizin gizliğine ve korunmasına büyük önem veriyoruz. 6698 sayılı Kişisel Verilerin Korunması Kanunu (KVKK) kapsamında kişisel veri politikalarımız hakkında sizleri bilgilendirmek isteriz. \n\nYürüttüğümüz faaliyet sırasında sizden aldığımız kişisel bilgileriniz bakımından Veri Sorumlusu olarak addedilmekteyiz. Veri Sorumlusu olarak, kişisel bilgileriniz aşağıda açıklandığı çerçevede sözlü, yazılı veya elektronik ortamda kaydedilebilecek, saklanabilecek, güncellenebilecek, sınıflandırılabilecek, mevzuatın izin verdiği hallerde 3. kişilere ve/veya yurt dışına açıklanabilecek ve/veya devredilebilecek ve KVKK’da sayılan diğer şekillerde işlenebilecektir.\n\nKişisel verilerin işlenme amaçları ve hukuki sebepleri; elektronik veya kâğıt ortamında işleme dayanak olacak tüm kayıt ve belgeleri düzenlemek; mevzuat ve ilgili otoritelerce öngörülen bilgi saklama, raporlama, bilgilendirme yükümlülüklerine uymak; talep edilen ürün ve hizmetlerini sunabilmek ve akdettiğiniz sözleşmenin gereğini alacağınız ürün veya hizmetleri yerine getirmektir.\n\nMüşterilerimize daha iyi hizmet verebilmek amacıyla bazı kişisel bilgilerinizi (isim, yaş, ilgi alanlarınız, e-posta vb.) sizlerden talep etmekteyiz. Sunucularımızda toplanan bu bilgiler, dönemsel kampanya çalışmaları, müşteri profillerine yönelik özel promosyon faaliyetlerinin kurgulanması ve istenmeyen e-postaların iletilmemesine yönelik müşteri “sınıflandırma” ve kişisel bilgiler vasıtasıyla oluşturulacak reklam, tanıtım, pazarlama faaliyetlerinin devam etmesi amacıyla saklanmakta ve bu amaçlarla kullanılmaktadır.\n\nWeb sitesi ve mobil uygulamalar üzerinden alışveriş yapanın/yaptıranın kimlik bilgilerini teyit etmek, iletişim için adres ve diğer gerekli bilgileri kaydetmek, mesafeli satış sözleşmesi ve Tüketicinin Korunması Hakkında Kanunun ilgili maddeleri tahtında akdettiğimiz sözleşmelerin koşulları, güncel durumu ve güncellemeler ile ilgili müşterilerimiz ile iletişime geçmek, gerekli bilgilendirmeleri yapabilmek, elektronik (internet/mobil vs.) veya kağıt ortamında işleme dayanak olacak tüm kayıt ve belgeleri düzenlemek, mesafeli satış sözleşmesi ve Tüketicinin Korunması Hakkında Kanunun ilgili maddeleri tahtında akdettiğimiz sözleşmeler uyarınca üstlenilen yükümlülükleri ifa etmek, Kamu güvenliğine ilişkin hususlarda talep halinde ve mevzuat gereği kamu görevlilerine bilgi verebilmek, Müşterilerimize daha iyi bir alışveriş deneyimini sağlamak, müşterilerimizin ilgi alanlarını dikkate alarak müşterilerimizin ilgilenebileceği ürünlerimiz hakkında müşterilerimize bilgi verebilmek, kampanyaları aktarmak, Müşteri memnuniyetini artırmak, web sitesi ve/veya mobil uygulamalardan alışveriş yapan müşterilerimizi tanıyabilmek ve müşteri çevresi analizinde kullanabilmek, çeşitli pazarlama ve reklam faaliyetlerinde kullanabilmek ve bu kapsamda anlaşmalı kuruluşlar aracılığıyla elektronik ortamda ve/veya fiziki ortamda anketler düzenlemek, Anlaşmalı kurumlarımız ve çözüm ortaklarımız tarafından müşterilerimize öneri sunabilmek, hizmetlerimizle ilgili müşterilerimizi bilgilendirebilmek, Hizmetlerimiz ile ilgili müşteri şikayet ve önerilerini değerlendirebilmek,  Yasal yükümlülüklerimizi yerine getirebilmek ve yürürlükteki mevzuattan doğan haklarımızı kullanabilmek amacıyla kişisel verilerinizi işleyebilmekte ve saklamaktayız. \n\nYukarıda belirtilen amaçlarla, kişisel verilerin aktarılabileceği kişi ya da kuruluşlar;  ana hissedarımız, doğrudan ve/veya dolaylı yurtiçi ya da yurtdışı iştiraklerimiz; faaliyetlerimizi yürütmek üzere hizmet aldığımız, işbirliği yaptığımız, iş ortağı kuruluşlar, Gizlilik Sözleşmesi uyarınca onay vereceğiniz ortaklar ve diğer 3. kişilerdir. \n\nKVKK’nın 11. maddesi gereği Güven Hastanesi A.Ş. ne başvurarak, kişisel verilerinizin; a) işlenip işlenmediğini öğrenme, b) işlenmişse bilgi talep etme, c) işlenme amacını ve amacına uygun kullanılıp kullanılmadığını öğrenme, d) yurt içinde ya da yurt dışında aktarıldığı 3. kişileri bilme, e) eksik ya da yanlış işlenmişse düzeltilmesini isteme, f) KVKK’nın 7. maddesinde öngörülen şartlar çerçevesinde silinmesini ya da yok edilmesini isteme, g) aktarıldığı 3. kişilere yukarıda sayılan (e) ve (f) bentleri uyarınca yapılan işlemlerin bildirilmesini isteme, h) münhasıran otomatik sistemler ile analiz edilmesi nedeniyle aleyhinize bir sonucun ortaya çıkmasına itiraz etme, i) kanuna aykırı olarak işlenmesi sebebiyle zarara uğramanız halinde zararın giderilmesini talep etme hakkına sahipsiniz. \n\n \n\nHak kullanım talebinizi iletebileceğiniz e-posta adresi ve posta adresi bilgilerimiz aşağıdaki gibidir: \n\n \n\n \n\n\nguven@guven.com.tr\n\nRemzi Oğuz Arık Mahallesi Paris Cad. No:58 Çankaya Ankara \n\n \n\n6698 sayılı Kanun ve ilgili diğer hükümlerine uygun olarak işlenmiş olmasına rağmen, işlenmesini gerektiren sebeplerin ortadan kalkması halinde kişisel veriler, şirketimiz tarafından veya talebiniz üzerine silinir, yok edilir veya anonim hale getirilir. Ancak 6563 Sayılı Elektronik Ticaretin Düzenlenmesi Hakkında Kanun uyarınca; onayın geri alındığına ilişkin kayıtlar bu tarihten itibaren 1 yıl; ticari elektronik iletinin içeriği ve gönderiye ilişkin diğer her türlü kayıt ise gerektiğinde ilgili Bakanlığa sunulmak üzere 3 yıl saklanacaktır. Süre geçtikten sonra kişisel verileriniz şirketimiz tarafından veya talebiniz üzerine silinir, yok edilir veya anonim hale getirilir.\n\nSaygılarımızla bilgilerinize sunarız. \n\nGÜVEN HASTANESİ A.Ş.',
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

  /// `ÖN BİLGİLENDİRME FORMU\nGüncelleme: 16.09.2021\nMADDE 1: TARAFLAR ve KONU\n1.\tİşbu Mesafeli Satış Sözleşmesi Ön Bilgilendirme Formu’nun (“Bilgilendirme Formu”) tarafları aşağıdaki gibidir: \nSATICI (“Güven Hastanesi”) \nTicari Unvanı\t: Güven Hastanesi A.Ş.\nAdresi\t\t: Remzi Oğuz Arık Mahallesi Paris Cad. No:58 Çankaya Ankara\nTelefon \t\t: 444 94 94\nE-mail \t\t: guven@guven.com.tr\nMERSİS No\t: 0451001685100012\nALICI (“Alıcı”)\nAdı Soyadı \t: <userName>\nAdresi \t\t: <adress>\nTelefon \t\t: <phoneNumber>\nE-mail \t\t: <email>\nAlıcı ve Güven Hastanesi bundan böyle ayrı ayrı “Taraf” ve birlikte “Taraflar” olarak anılabilecektir.\n2.\tGüven Hastanesi, 27166 sayı ve 11.03.2009 tarihli Resmi Gazete’de yayımlanarak yürürlüğe giren "Özel Hastaneler Yönetmeliği" ve sair mevzuatta belirtilen şartları taşıyan, çeşitli uzmanlık dallarında hastalara ayakta ve yatırarak muayene, teşhis ve tedavi hizmeti sunan, Ankara’da Paris Caddesi No: 58 Kavaklıdere Ankara adresinde mukim özel bir hastanedir. \n3.\tİşbu Bilgilendirme Formu 6502 Sayılı Tüketicinin Korunması Hakkında Kanun (“Kanun”) ve Mesafeli Sözleşmeler Yönetmeliği’ne uygun olarak düzenlenmiştir. İşbu Bilgilendirme Formu, Alıcı’nın Güven Hastanesi’ne ait web sitesi ve telefon uygulamaları (“Online Platform”) üzerinden işbu Bilgilendirme Formu Madde 2.2’de belirtilen sağlık hizmeti paketini (“Hizmet Paketi”) satın almasında Tarafların karşılıklı hak ve yükümlülüklerini düzenlemektedir.  \n4.\tİşbu Bilgilendirme Formu’nun Tarafları işbu Bilgilendirme Formu tahtında Kanun’dan ve Mesafeli Sözleşmeler Yönetmeliği’nden kaynaklanan yükümlülük ve sorumluluklarını bildiklerini ve anladıklarını kabul ve beyan ederler.\n5.\tAlıcı, işbu Bilgilendirme Formu’nu elektronik ortamda teyit etmekle, mesafeli sözleşmelerin akdinden önce Güven Hastanesi tarafından Alıcı’ya verilmesi gereken adres, siparişi verilen hizmete ait temel özellikler, hizmetin vergiler dahil fiyatı ve ödeme bilgilerini de doğru ve eksiksiz olarak edindiğini teyit etmiş olur.\nMADDE 2: SÖZLEŞME KONUSUNUN TEMEL NİTELİKLERİ VE BEDELİ \n1.\tHizmet Paketi’nin temel özellikleri Online Platform’da yer almaktadır ve Online Platform’da incelenebilecektir. Hizmet Paketi’nin “online görüşme” olması halinde Hizmet Paketi, hasta ve hekimin bir arada bulunması gereken durumlarda muayenenin bir muadili olmayıp, Alıcı’ya sadece Online Platform’da seçilen hekime danışma ve konsültasyon imkanı sunulacaktır. \n2.\tAlıcı tarafından işbu Bilgilendirme Formu kapsamında satın alınacak olan Hizmet Paketi’ne ilişkin bilgiler aşağıdaki şekildedir:\nHizmet Paketi Açıklaması\tAdet\tBirim Fiyatı\tAra Toplam\n(KDV Dahil)\n\t\t\t\n<packageName>\t\t\t\nToplam :\t\n\nÖdeme Şekli ve Planı\t: <paymentPlan>\nFatura Adresi\t\t: <adress>\nTeslimat Adresi\t\t: <adress>\nTeslim Edilecek Kişi\t: <userName>\nSatın Alma Tarihi\t: <currentDate>\n3.\tOnline Platform’da ilan edilen fiyatlar satış fiyatıdır. İlan edilen fiyatlar ve vaatler güncelleme yapılana ve değiştirilene kadar geçerlidir. Süreli olarak ilan edilen fiyatlar ise belirtilen süre sonuna kadar geçerlidir.\n4.\tGüven Hastanesi, Alıcı’nın Online Platform üzerinden onaylayarak satın aldığı Hizmet Paketi’ni en geç 24 saat içinde işleme alarak ilgili birimlerine iletir.\n5.\tHizmet, Güven Hastanesi tarafından mümkün olan en kısa sürede ve en geç 7 (yedi) iş günü içinde Alıcı’ya sunulur. Hizmet Paketi’nin tek seferde kullanılmakla tükenecek bir hizmete ilişkin olması halinde Hizmet Paketi’nin Alıcı tarafından <expirationDate> tarihine kadar kullanılması gerekmektedir. Hizmet Paketi’nin devamlılığı olan bir hizmete yönelik, dönemli bir hizmete ilişkin olması halinde ise Alıcı tarafından Hizmet Paketi’nin kullanımına <currentDate> tarihine kadar başlanılmış olması ve bu tarihten itibaren 3 (üç) ay içerisinde Hizmet Paketi’nin tamamen kullanılması gerekir. İşbu maddede belirtilen tarihlere kadar kullanılmayan Hizmet Paketi belirtilen tarihlerden sonra kullanılamaz ve bu hususta Alıcı’ya herhangi bir ödeme / geri ödeme yapılmayacağı gibi, Alıcı’nın herhangi bir talep hakkı da bulunmayacaktır.\n6.\tGüven Hastanesi’nden kaynaklanmayan sebeplerle gecikmelerin yaşanması halinde Güven Hastanesi durumu derhal Alıcı’ya bildirir. \n7.\tAlıcı’nın satın aldığı Hizmet Paketi’nin peşin veya vadeli fiyatı sipariş formunda yer alır, Alıcı tarafından onaylanır ve sipariş sonunda Alıcı’nın e-posta adresine e-fatura olarak gönderilir. Yapılan indirimler ve promosyonlar satış fiyatına yansıtılır.\n8.\tHizmet Paketi’nin Alıcı’ya fiziki teslimat gerektirmesi halinde, teslimat masrafları aksi Güven Hastanesi tarafından beyan edilmediği müddetçe Alıcı’ya aittir. Bu durumda Güven Hastanesi Hizmet Paketi’ni sipariş tarihinden itibaren 30 (otuz) gün içinde teslim eder. Güven Hastanesi bu süre içinde yazılı bildirimle ek 10 (on) günlük süre uzatım hakkını saklı tutar. Hizmet Paketi’nin aracı posta veya kargo şirketine teslim edilmesi ile hasardan sorumluluk Alıcı’ya geçer.\n9.\tMesafeli satış sözleşmesi Alıcı tarafından Online Platform üzerinden onaylanmakla yürürlüğe girer ve Alıcı’nın Güven Hastanesi’nden satın almış olduğu Hizmet Paketi’nin Alıcı’ya online ve/veya fiziksel ortamda sunulması ile ifa edilmiş olur. \n10.\tHizmet Paketi, Alıcı’nın sipariş formunda ve mesafeli satış sözleşmesinde belirtmiş olduğu adreste bulunan kişi/kişilere teslim edilecektir.\nMADDE 3: ALICININ BEYAN VE TAAHHÜTLERİ\n1.\tAlıcı, Hizmet Paketi’nin nitelikleri, tüm vergiler dahil satış fiyatı, ödeme şekli, teslimat ve cayma hakkı ile kullanım şartlarına ilişkin olarak ön bilgilerin tarafına ulaştığını, Güven Hastanesi tarafından kendisine Online Platform üzerinden sunulan bilgileri okuduğunu, anladığını, eksiksiz olarak bilgilendiğini, elektronik ortamda teyit ettiğini ve elektronik ortamda satış için gerekli onayları verdiğini beyan eder. \n2.\tİşbu Bilgilendirme Formu’nu kabul etmekle Alıcı, sözleşme konusu Hizmet Paketi’ni onayladığı takdirde Hizmet Paketi’nin bedeli ve vergi gibi belirtilen ek ücretleri ödeme yükümlülüğü altına gireceğini ve bu konuda bilgilendirildiğini peşinen kabul eder.\n3.\tAlıcı, seçmiş olduğu Hizmet Paketi’nin gereklerinin ifa edilebilmesi için 6698 sayılı Kişisel Verileri Koruma Kanunu uyarınca özel nitelikli kişisel veri sayılan sağlık verilerinin Hizmet Paketi kapsamındaki hizmetin ifası amacı ile sınırlı olmak kaydıyla işlenmesine açık olarak rıza göstermektedir.  \n4.\tAlıcı, talep ve şikâyetlerini Güven Hastanesi’nin yukarıda yer alan iletişim kanallarına ulaştırabilir. Güven Hastanesi, talep ve şikâyetleri değerlendirerek Alıcı’ya en kısa zamanda geri dönüş yapar. \n5.\tAlıcı, herhangi bir nedenle sözleşme konusu Hizmet Paketi’nin bedelinin ödenmemesi ve/veya banka kayıtlarında iptal edilmesi halinde, Güven Hastanesi’nin sözleşme konusu Hizmet Paketi’ni ifa ve/veya teslim yükümlülüğünün sona ereceğini kabul, beyan ve taahhüt eder.\n6.\tAlıcı, işbu Bilgilendirme Formu’nu ve mesafeli satış sözleşmesini kabul ederken en az 18 yaşında olduğunu veya ilgili ülke mevzuatına göre işbu Bilgilendirme Formu’nu ve mesafeli satış sözleşmesini akdetmeye uygun yaşta olduğunu, kısıtlı olmadığını ve işbu Bilgilendirme Formu’nu ve mesafeli satış sözleşmesini akdetmeye yetkili olduğunu kabul ve beyan eder. Alıcı’nın işbu maddede belirtilen yaş sınırından daha küçük olduğunun, kısıtlı olduğunun veya sair surette işbu Bilgilendirme Formu’nu ve/veya mesafeli satış sözleşmesini akdetmeye yetkili olmadığının tespiti halinde mesafeli satış sözleşmesi Güven Hastanesi tarafından derhal feshedilebilir ve Alıcı’ya veya yasal temsilcisine herhangi bir ödeme iadesi yapılmaz.\n7.\tHizmet Paketi’nin “online görüşme” olması halinde Alıcı’nın, randevu saatinden en geç 5 (beş) dakika önce Güven Online uygulamasına giriş yapması, bağlantıya hazır durumda olması ve hekimle görüşmeyi başlatmış olması gerekir. Alıcı’nın bu maddede belirtilen şekilde hazır olmaması ve/veya görüşmeye hiç katılmaması halinde ilgili görüşme yapılmış sayılarak ücretlendirmesi yapılır ve Alıcı’ya herhangi bir iade yapılmaz.\n8.\tHizmet Paketi’nin “online görüşme” olması halinde Alıcı’nın görüntülü görüşme yapabilmek için dikkat etmesi gereken hususlar ve hizmetin kullanılabilmesi için gereken donanım ve yazılımlara ilişkin bilgi “https://www.guven.com.tr/online-doktor” adresindeki ilgili bölümlerde yer almakta olup, bu hususlar zaman zaman Güven Hastanesi tarafından güncellenebilecektir. Güncellemeleri takip etmek ve bu hususlara uymak Alıcı’nın sorumluluğundadır.\n9.\tAlıcı, Ek-1: Online Doktor ve E-Konsültasyon Hizmetinin Kapsamı Hakkında Bilgilendirme ve Aydınlatılmış Onam Belgesi’nde yer alan bilgileri okuduğunu, anladığını ve kabul ettiğini beyan ve taahhüt eder.\nMADDE 4: İFADA SIRA, TEMERRÜD HALİ VE HUKUKİ SONUÇLARI\n1.\tAlıcı’nın ödemeyi gerçekleştirmesini takiben, mesafeli satış sözleşmesi koşullarına uygun olarak Güven Hastanesi işbu Bilgilendirme Formu’nda ve mesafeli satış sözleşmesinde belirtilen Hizmet Paketi kapsamındaki hizmeti sunar. \n2.\tAlıcı borcundan dolayı temerrüde düşmesi halinde, borcun gecikmeli ifasından dolayı Güven Hastanesi’nin oluşan zarar ve ziyanını ödemeyi kabul eder.\nMADDE 5: CAYMA HAKKI\n1.\tAlıcı, hiçbir hukuki ve cezai sorumluluk üstlenmeksizin ve hiçbir gerekçe göstermeksizin, mal satışına ilişkin işlemlerde teslimat tarihinden itibaren, hizmet satışına ilişkin işlemlerde satın alma tarihinden itibaren 14 (on dört) gün içerisinde cayma hakkını kullanabilir. Mal satışına ilişkin işlemlerde Alıcı, malın teslimine kadar olan süre içinde de cayma hakkını kullanabilir. \n2.\tHizmet Paketi kapsamındaki hizmetin Alıcı tarafından kısmen veya tamamen kullanılmış olması halinde cayma hakkı kullanılamaz. Cayma hakkı süresi sona ermeden önce, Alıcı’nın onayı ile ifasına başlanan hizmetler için de cayma hakkı kullanılamaz.\n3.\tAlıcı’nın cayma hakkını kullanmasından itibaren 14 (on dört) gün içerisinde (mal satışına ilişkin işlemlerde malın Güven Hastanesi’nin iade için belirttiği taşıyıcı aracılığıyla geri gönderilmesi kaydıyla), Alıcı’nın ilgili mal veya hizmete ilişkin Güven Hastanesi’ne yaptığı tüm ödemeler Alıcı’ya Hizmet Paketi’ni satın alırken kullandığı ödeme aracına uygun bir şekilde ve Alıcı’ya herhangi bir masraf veya yükümlülük getirmeden ve tek seferde iade edilecektir.\n4.\tCayma hakkına ilişkin bildirimler Güven Hastanesi’ne ait <hospitalEmail> e-posta adresine yapılacaktır.\n5.\tCayma hakkının kullanımından kaynaklanan masraflar Güven Hastanesi’ne aittir. Alıcı, işbu Bilgilendirme Formu’nu ve mesafeli satış sözleşmesini kabul etmekle, cayma hakkı konusunda bilgilendirildiğini peşinen kabul eder.\nMADDE 6: SORUMLULUK SINIRI \n1.\tAlıcı’nın her durumda tıbbi tanı, tedavi ve hastalıkların önlenmesi için özgür iradesiyle seçeceği hekimine başvurması, kontrollerini aksatmaması ve her türlü acil durumda vakit kaybetmeden en yakın acil servise müracaat etmesi gerekmektedir. Aksi halde Güven Hastanesi’nin hiçbir sorumluluğu bulunmamaktadır.\n2.\t“Online görüşme” kapsamında Güven Online’da yer alan hekimler tarafından Alıcı’ya herhangi bir tıbbi işlem (muayene, tanı, teşhis, tedavi gibi) sunulmamakta ve vaat edilmemekte olup; Güven Hastanesi’nin ve/veya Güven Online’da yer alan hekimlerin tıbbi kötü uygulamadan (malpraktis) dolayı herhangi bir sorumluluğu bulunmayacaktır.\n3.\t“Online görüşme” kapsamında Güven Online’da yer alan hekimler, herhangi bir görüşte bulunmuş olmamaktadır. “Online görüşme” kapsamında sunulan herhangi bir bilgi veya verinin doğruluğunu teyit etmek Alıcı’nın yükümlülüğü ve sorumluluğundadır. “Online görüşme” kapsamında Güven Hastanesi ve Güven Online’da yer alan hekimler, Güven Online’ın ve/veya “online görüşme” özelliğinin kullanılması veya kullanılmaması, Güven Online’da sunulan hizmetin aksaması veya kesintiye uğraması ve mesafeli satış sözleşmesindeki hizmetlerin ifası nedeniyle ortaya çıkabilecek herhangi bir yaralanma, bedensel zarar, maddi veya manevi zarar, kâr kaybı, iş kaybı veya sair her türlü doğrudan ya da dolaylı zararlardan hiçbir biçimde sorumlu değildir.\n4.\tUygulanacak hukuk altında izin verildiği ölçüde, Güven Hastanesi’nin Alıcı’nın Hizmet Paketi ve mesafeli satış sözleşmesi kapsamındaki herhangi bir zararına ilişkin sorumluluğu, hangisi daha az ise; (i) sorumluluğu doğuran olaydan önceki 1 (bir) takvim ayı içinde Alıcı tarafından “Güven Online üzerinden” Güven Hastanesi’ne ödenmiş olan Hizmet Paketi bedelleri toplamı, veya (ii) 1.000 (bin) Türk Lirası ile sınırlıdır.\n5.\tAlıcı’nın mesafeli satış sözleşmesini ihlal ederek üçüncü kişilerin herhangi bir zararına sebep olması halinde Alıcı, bu zarardan Güven Hastanesi’ni masun tutacaktır. Alıcı’dan kaynaklanan herhangi bir sebeple Güven Hastanesi’nin herhangi bir zarara uğraması halinde bu zarar Alıcı tarafından derhal nakden ve defaten tazmin edilecektir.\nMADDE 7: DİĞER HÜKÜMLER\n1.\tMesafeli satış sözleşmesi tahtında Taraflar arasında yapılacak her türlü yazışma, mevzuatta sayılan zorunlu haller dışında e-posta aracılığıyla yapılır. Mevzuatta yazılı hallerde Tarafların belirtmiş olduğu adresleri tebligat adresleri olarak kabul edilir. 15 (on beş) gün içerisinde karşı Tarafa bildirilmeyen tebligat adresi değişikliklerinde tebligat usulüne uygun olarak yapılmış sayılır.\n2.\tGüven Hastanesi, kendi kontrolü dışında meydana gelen, öngörülemeyen ve önlenemeyen doğal afetler, yangın, patlamalar, iç savaşlar, savaşlar, ayaklanmalar, halk hareketleri, seferberlik ilanı, grev, lokavt ve salgın hastalıklar gibi mücbir sebep hallerinden dolayı oluşabilecek herhangi bir gecikme veya yükümlülüklerin ifa edilememesinden kaynaklanabilecek zarar ve ziyandan sorumlu olmayacaktır. Mücbir sebep halinin Güven Hastanesi’nin mesafeli satış sözleşmesinde yazılı yükümlülüklerini doğrudan etkilemesi durumunda Güven Hastanesi’nin mesafeli satış sözleşmesini tazminatsız ve tek taraflı feshetme hakkı saklıdır.\n3.\tBu Bilgilendirme Formu’nun ve/veya mesafeli satış sözleşmesinin herhangi bir madde veya kısmının geçersiz, hükümsüz veya ifa edilemez sayılması halinde, o madde veya kısım, onun lafzi amacına en yakın ve aynı zamanda ifa edilebilir olan bir şekilde ve kapsamda yorumlanacak ve uygulanacaktır; ancak bunun mümkün olmaması halinde, o madde veya kısım Bilgilendirme Formu’nda ve/veya mesafeli satış sözleşmesinden ayrılmış ve çıkartılmış sayılacak ve bu durum, Bilgilendirme Formu’nun ve/veya mesafeli satış sözleşmesinin kalan madde ve hükümlerini hiçbir şekilde etkilemeyecek veya geçersiz hale getirmeyecek ve Bilgilendirme Formu’nun ve mesafeli satış sözleşmesinin diğer madde ve hükümleri tam geçerli ve yürürlükte kalmaya devam edecektir.\n4.\tHiçbir feragat yazılı olarak ve Taraflarca yapılmadıkça geçerli olmayacaktır. Taraflardan herhangi birinin mesafeli satış sözleşmesinin herhangi bir hükmünün veya şartının sağlanmasını talep etmemesi ya da herhangi bir Tarafın mesafeli satış sözleşmesinin herhangi bir ihlalinden doğan talep hakkından feragat etmesi, söz konusu hüküm veya şartın bundan sonra uygulanmasını engellemeyecektir ve bir sonraki ihlalden feragat olarak sayılmayacaktır.\n5.\tGüven Hastanesi, mesafeli satış sözleşmesinden doğan hak ve yükümlülüklerini hiçbir sınırlama olmaksızın üçüncü şahıslara devretmek hakkını haizdir.\n6.\tTaraflar, Bilgilendirme Formu’nun ve mesafeli satış sözleşmesinin geçerliliği, uygulanması ve yorumlanması konusunda kanunlar ihtilafına dair kurallar hariç olmak üzere münhasır şekilde Türkiye Cumhuriyeti yasaları ve ilgili mevzuatının uygulanacağını kabul ve beyan ederler.\n7.\tBilgilendirme Formu ve mesafeli satış sözleşmesi ile ilgili çıkacak ihtilaflarda; her yıl Ticaret Bakanlığı tarafından ilan edilen değere kadar Alıcı’nın yerleşim yerindeki Hizmet Paketi’ni satın aldığı veya ikametgâhının bulunduğu yerdeki İl veya İlçe Tüketici Sorunları Hakem Heyetleri, söz konusu değerin üzerindeki ihtilaflarda ise Tüketici Mahkemeleri yetkilidir.\n8.\tBilgilendirme Formu ve mesafeli satış sözleşmesinden doğabilecek ihtilaflarda Güven Hastanesi’nin resmi defter ve ticari kayıtlarıyla, kendi veritabanında, sunucularında tuttuğu elektronik bilgiler ve bilgisayar kayıtları, bağlayıcı, kesin ve münhasır delil teşkil eder. Bu madde Hukuk Muhakemeleri Kanunu’nun 193. maddesi anlamında delil sözleşmesi niteliğindedir.  \n9.\tALICI, GÜVEN ONLINE VE SÖZLEŞME KAPSAMINDAKİ HİZMETİN NİTELİKLERİ VE BEDELİ İLE EK-1: ONLINE DOKTOR VE E-KONSÜLTASYON HİZMETİNİN KAPSAMI HAKKINDA BİLGİLENDİRME VE AYDINLATILMIŞ ONAM BELGESİ’NDEKİ HUSUSLARA İLİŞKİN OLARAK GÜVEN HASTANESİ TARAFINDAN KENDİSİNE YAPILAN BİLGİLENDİRMELERİ VE KENDİ SORUMLULUKLARINI OKUYUP ANLADIĞINI, ANLAMADIĞI KISIMLARIN OLMASI HALİNDE SORU SORDUĞUNU, SORULARININ YETKİLİ KİŞİLERCE CEVAPLANDIĞINI, EKSİKSİZ OLARAK BİLGİLENDİĞİNİ KABUL VE BEYAN EDER.\n7 (yedi) maddeden ve 1 (bir) adet ekten ibaret işbu Bilgilendirme Formu, Alıcı tarafından elektronik ortamda okunup onaylanmak suretiyle akdedilmiş ve derhal yürürlüğe girmiştir.\n\nEk-1: Online Doktor ve E-Konsültasyon Hizmetinin Kapsamı Hakkında Bilgilendirme ve Aydınlatılmış Onam Belgesi\n\nALICI\t                          GÜVEN HASTANESİ A.Ş.\n\n \nEK-1:\nONLINE DOKTOR VE E-KONSÜLTASYON\nHİZMETİNİN KAPSAMI HAKKINDA BİLGİLENDİRME\nVE\nAYDINLATILMIŞ ONAM BELGESİ\nGüncelleme: 03.04.2020\n\nGüven Hastanesi A.Ş.’ye (“Güven Hastanesi”) ait web sitesi ve telefon uygulamaları (“Online Platform”) üzerinden sunulan ONLINE DOKTOR VE E-KONSÜLTASYON HİZMETİ’nin (“Hizmet”) kapsamı konusunda tarafıma yazılı bilgilendirme yapılmıştır. \n1.\tHizmet kapsamında, Online Platform üzerinden Güven Hastanesi hekimleri tarafından danışma ve konsültasyon imkanı sunulacağı; \n2.\tHizmet’in hasta ve hekimin bir arada bulunmasını gerektiren durumlarda muayenenin muadili olmadığı; \n3.\tHer türlü tıbbi tanı ve tedavi ihtiyaçlarım için özgür irademle seçeceğim hekimime başvuru yapmam ve fiziken muayene olmam gerektiği, \n4.\tSağlığımı ilgilendiren ve aciliyeti olan konularda, vakit kaybetmeden en yakın acil servise müracaat etmem gerektiği, \n5.\tAksi halde gerçekleşebilecek olumsuz sonuçlardan Güven Hastanesi’nin hiçbir şekilde sorumlu tutulamayacağı, \nkonularında yazılı olarak aydınlatıldım. \nKonu hakkında sorum olması halinde ulaşabileceğim iletişim numaraları tarafımla paylaşıldı. \nGelinen aşamada; \nTarafıma yapılan tüm yazılı bilgilendirmeleri okuduğumu, anladığımı ve bu haliyle kabul ettiğimi; ONLINE DOKTOR VE E-KONSÜLTASYON HİZMETİ’nden bu bilgilendirmeler doğrultusunda yararlanacağımı kabul ve beyan ediyorum.\n(İşbu Belge GÜVEN HASTANESİ ile ALICI arasındaki MESAFELİ SATIŞ SÖZLEŞME’sinin tamamlayıcı bir parçası olarak ALICI’ya imzalatılmıştır.)\n\n\n`
  String get preinformation_form_context {
    return Intl.message(
      'ÖN BİLGİLENDİRME FORMU\nGüncelleme: 16.09.2021\nMADDE 1: TARAFLAR ve KONU\n1.\tİşbu Mesafeli Satış Sözleşmesi Ön Bilgilendirme Formu’nun (“Bilgilendirme Formu”) tarafları aşağıdaki gibidir: \nSATICI (“Güven Hastanesi”) \nTicari Unvanı\t: Güven Hastanesi A.Ş.\nAdresi\t\t: Remzi Oğuz Arık Mahallesi Paris Cad. No:58 Çankaya Ankara\nTelefon \t\t: 444 94 94\nE-mail \t\t: guven@guven.com.tr\nMERSİS No\t: 0451001685100012\nALICI (“Alıcı”)\nAdı Soyadı \t: <userName>\nAdresi \t\t: <adress>\nTelefon \t\t: <phoneNumber>\nE-mail \t\t: <email>\nAlıcı ve Güven Hastanesi bundan böyle ayrı ayrı “Taraf” ve birlikte “Taraflar” olarak anılabilecektir.\n2.\tGüven Hastanesi, 27166 sayı ve 11.03.2009 tarihli Resmi Gazete’de yayımlanarak yürürlüğe giren "Özel Hastaneler Yönetmeliği" ve sair mevzuatta belirtilen şartları taşıyan, çeşitli uzmanlık dallarında hastalara ayakta ve yatırarak muayene, teşhis ve tedavi hizmeti sunan, Ankara’da Paris Caddesi No: 58 Kavaklıdere Ankara adresinde mukim özel bir hastanedir. \n3.\tİşbu Bilgilendirme Formu 6502 Sayılı Tüketicinin Korunması Hakkında Kanun (“Kanun”) ve Mesafeli Sözleşmeler Yönetmeliği’ne uygun olarak düzenlenmiştir. İşbu Bilgilendirme Formu, Alıcı’nın Güven Hastanesi’ne ait web sitesi ve telefon uygulamaları (“Online Platform”) üzerinden işbu Bilgilendirme Formu Madde 2.2’de belirtilen sağlık hizmeti paketini (“Hizmet Paketi”) satın almasında Tarafların karşılıklı hak ve yükümlülüklerini düzenlemektedir.  \n4.\tİşbu Bilgilendirme Formu’nun Tarafları işbu Bilgilendirme Formu tahtında Kanun’dan ve Mesafeli Sözleşmeler Yönetmeliği’nden kaynaklanan yükümlülük ve sorumluluklarını bildiklerini ve anladıklarını kabul ve beyan ederler.\n5.\tAlıcı, işbu Bilgilendirme Formu’nu elektronik ortamda teyit etmekle, mesafeli sözleşmelerin akdinden önce Güven Hastanesi tarafından Alıcı’ya verilmesi gereken adres, siparişi verilen hizmete ait temel özellikler, hizmetin vergiler dahil fiyatı ve ödeme bilgilerini de doğru ve eksiksiz olarak edindiğini teyit etmiş olur.\nMADDE 2: SÖZLEŞME KONUSUNUN TEMEL NİTELİKLERİ VE BEDELİ \n1.\tHizmet Paketi’nin temel özellikleri Online Platform’da yer almaktadır ve Online Platform’da incelenebilecektir. Hizmet Paketi’nin “online görüşme” olması halinde Hizmet Paketi, hasta ve hekimin bir arada bulunması gereken durumlarda muayenenin bir muadili olmayıp, Alıcı’ya sadece Online Platform’da seçilen hekime danışma ve konsültasyon imkanı sunulacaktır. \n2.\tAlıcı tarafından işbu Bilgilendirme Formu kapsamında satın alınacak olan Hizmet Paketi’ne ilişkin bilgiler aşağıdaki şekildedir:\nHizmet Paketi Açıklaması\tAdet\tBirim Fiyatı\tAra Toplam\n(KDV Dahil)\n\t\t\t\n<packageName>\t\t\t\nToplam :\t\n\nÖdeme Şekli ve Planı\t: <paymentPlan>\nFatura Adresi\t\t: <adress>\nTeslimat Adresi\t\t: <adress>\nTeslim Edilecek Kişi\t: <userName>\nSatın Alma Tarihi\t: <currentDate>\n3.\tOnline Platform’da ilan edilen fiyatlar satış fiyatıdır. İlan edilen fiyatlar ve vaatler güncelleme yapılana ve değiştirilene kadar geçerlidir. Süreli olarak ilan edilen fiyatlar ise belirtilen süre sonuna kadar geçerlidir.\n4.\tGüven Hastanesi, Alıcı’nın Online Platform üzerinden onaylayarak satın aldığı Hizmet Paketi’ni en geç 24 saat içinde işleme alarak ilgili birimlerine iletir.\n5.\tHizmet, Güven Hastanesi tarafından mümkün olan en kısa sürede ve en geç 7 (yedi) iş günü içinde Alıcı’ya sunulur. Hizmet Paketi’nin tek seferde kullanılmakla tükenecek bir hizmete ilişkin olması halinde Hizmet Paketi’nin Alıcı tarafından <expirationDate> tarihine kadar kullanılması gerekmektedir. Hizmet Paketi’nin devamlılığı olan bir hizmete yönelik, dönemli bir hizmete ilişkin olması halinde ise Alıcı tarafından Hizmet Paketi’nin kullanımına <currentDate> tarihine kadar başlanılmış olması ve bu tarihten itibaren 3 (üç) ay içerisinde Hizmet Paketi’nin tamamen kullanılması gerekir. İşbu maddede belirtilen tarihlere kadar kullanılmayan Hizmet Paketi belirtilen tarihlerden sonra kullanılamaz ve bu hususta Alıcı’ya herhangi bir ödeme / geri ödeme yapılmayacağı gibi, Alıcı’nın herhangi bir talep hakkı da bulunmayacaktır.\n6.\tGüven Hastanesi’nden kaynaklanmayan sebeplerle gecikmelerin yaşanması halinde Güven Hastanesi durumu derhal Alıcı’ya bildirir. \n7.\tAlıcı’nın satın aldığı Hizmet Paketi’nin peşin veya vadeli fiyatı sipariş formunda yer alır, Alıcı tarafından onaylanır ve sipariş sonunda Alıcı’nın e-posta adresine e-fatura olarak gönderilir. Yapılan indirimler ve promosyonlar satış fiyatına yansıtılır.\n8.\tHizmet Paketi’nin Alıcı’ya fiziki teslimat gerektirmesi halinde, teslimat masrafları aksi Güven Hastanesi tarafından beyan edilmediği müddetçe Alıcı’ya aittir. Bu durumda Güven Hastanesi Hizmet Paketi’ni sipariş tarihinden itibaren 30 (otuz) gün içinde teslim eder. Güven Hastanesi bu süre içinde yazılı bildirimle ek 10 (on) günlük süre uzatım hakkını saklı tutar. Hizmet Paketi’nin aracı posta veya kargo şirketine teslim edilmesi ile hasardan sorumluluk Alıcı’ya geçer.\n9.\tMesafeli satış sözleşmesi Alıcı tarafından Online Platform üzerinden onaylanmakla yürürlüğe girer ve Alıcı’nın Güven Hastanesi’nden satın almış olduğu Hizmet Paketi’nin Alıcı’ya online ve/veya fiziksel ortamda sunulması ile ifa edilmiş olur. \n10.\tHizmet Paketi, Alıcı’nın sipariş formunda ve mesafeli satış sözleşmesinde belirtmiş olduğu adreste bulunan kişi/kişilere teslim edilecektir.\nMADDE 3: ALICININ BEYAN VE TAAHHÜTLERİ\n1.\tAlıcı, Hizmet Paketi’nin nitelikleri, tüm vergiler dahil satış fiyatı, ödeme şekli, teslimat ve cayma hakkı ile kullanım şartlarına ilişkin olarak ön bilgilerin tarafına ulaştığını, Güven Hastanesi tarafından kendisine Online Platform üzerinden sunulan bilgileri okuduğunu, anladığını, eksiksiz olarak bilgilendiğini, elektronik ortamda teyit ettiğini ve elektronik ortamda satış için gerekli onayları verdiğini beyan eder. \n2.\tİşbu Bilgilendirme Formu’nu kabul etmekle Alıcı, sözleşme konusu Hizmet Paketi’ni onayladığı takdirde Hizmet Paketi’nin bedeli ve vergi gibi belirtilen ek ücretleri ödeme yükümlülüğü altına gireceğini ve bu konuda bilgilendirildiğini peşinen kabul eder.\n3.\tAlıcı, seçmiş olduğu Hizmet Paketi’nin gereklerinin ifa edilebilmesi için 6698 sayılı Kişisel Verileri Koruma Kanunu uyarınca özel nitelikli kişisel veri sayılan sağlık verilerinin Hizmet Paketi kapsamındaki hizmetin ifası amacı ile sınırlı olmak kaydıyla işlenmesine açık olarak rıza göstermektedir.  \n4.\tAlıcı, talep ve şikâyetlerini Güven Hastanesi’nin yukarıda yer alan iletişim kanallarına ulaştırabilir. Güven Hastanesi, talep ve şikâyetleri değerlendirerek Alıcı’ya en kısa zamanda geri dönüş yapar. \n5.\tAlıcı, herhangi bir nedenle sözleşme konusu Hizmet Paketi’nin bedelinin ödenmemesi ve/veya banka kayıtlarında iptal edilmesi halinde, Güven Hastanesi’nin sözleşme konusu Hizmet Paketi’ni ifa ve/veya teslim yükümlülüğünün sona ereceğini kabul, beyan ve taahhüt eder.\n6.\tAlıcı, işbu Bilgilendirme Formu’nu ve mesafeli satış sözleşmesini kabul ederken en az 18 yaşında olduğunu veya ilgili ülke mevzuatına göre işbu Bilgilendirme Formu’nu ve mesafeli satış sözleşmesini akdetmeye uygun yaşta olduğunu, kısıtlı olmadığını ve işbu Bilgilendirme Formu’nu ve mesafeli satış sözleşmesini akdetmeye yetkili olduğunu kabul ve beyan eder. Alıcı’nın işbu maddede belirtilen yaş sınırından daha küçük olduğunun, kısıtlı olduğunun veya sair surette işbu Bilgilendirme Formu’nu ve/veya mesafeli satış sözleşmesini akdetmeye yetkili olmadığının tespiti halinde mesafeli satış sözleşmesi Güven Hastanesi tarafından derhal feshedilebilir ve Alıcı’ya veya yasal temsilcisine herhangi bir ödeme iadesi yapılmaz.\n7.\tHizmet Paketi’nin “online görüşme” olması halinde Alıcı’nın, randevu saatinden en geç 5 (beş) dakika önce Güven Online uygulamasına giriş yapması, bağlantıya hazır durumda olması ve hekimle görüşmeyi başlatmış olması gerekir. Alıcı’nın bu maddede belirtilen şekilde hazır olmaması ve/veya görüşmeye hiç katılmaması halinde ilgili görüşme yapılmış sayılarak ücretlendirmesi yapılır ve Alıcı’ya herhangi bir iade yapılmaz.\n8.\tHizmet Paketi’nin “online görüşme” olması halinde Alıcı’nın görüntülü görüşme yapabilmek için dikkat etmesi gereken hususlar ve hizmetin kullanılabilmesi için gereken donanım ve yazılımlara ilişkin bilgi “https://www.guven.com.tr/online-doktor” adresindeki ilgili bölümlerde yer almakta olup, bu hususlar zaman zaman Güven Hastanesi tarafından güncellenebilecektir. Güncellemeleri takip etmek ve bu hususlara uymak Alıcı’nın sorumluluğundadır.\n9.\tAlıcı, Ek-1: Online Doktor ve E-Konsültasyon Hizmetinin Kapsamı Hakkında Bilgilendirme ve Aydınlatılmış Onam Belgesi’nde yer alan bilgileri okuduğunu, anladığını ve kabul ettiğini beyan ve taahhüt eder.\nMADDE 4: İFADA SIRA, TEMERRÜD HALİ VE HUKUKİ SONUÇLARI\n1.\tAlıcı’nın ödemeyi gerçekleştirmesini takiben, mesafeli satış sözleşmesi koşullarına uygun olarak Güven Hastanesi işbu Bilgilendirme Formu’nda ve mesafeli satış sözleşmesinde belirtilen Hizmet Paketi kapsamındaki hizmeti sunar. \n2.\tAlıcı borcundan dolayı temerrüde düşmesi halinde, borcun gecikmeli ifasından dolayı Güven Hastanesi’nin oluşan zarar ve ziyanını ödemeyi kabul eder.\nMADDE 5: CAYMA HAKKI\n1.\tAlıcı, hiçbir hukuki ve cezai sorumluluk üstlenmeksizin ve hiçbir gerekçe göstermeksizin, mal satışına ilişkin işlemlerde teslimat tarihinden itibaren, hizmet satışına ilişkin işlemlerde satın alma tarihinden itibaren 14 (on dört) gün içerisinde cayma hakkını kullanabilir. Mal satışına ilişkin işlemlerde Alıcı, malın teslimine kadar olan süre içinde de cayma hakkını kullanabilir. \n2.\tHizmet Paketi kapsamındaki hizmetin Alıcı tarafından kısmen veya tamamen kullanılmış olması halinde cayma hakkı kullanılamaz. Cayma hakkı süresi sona ermeden önce, Alıcı’nın onayı ile ifasına başlanan hizmetler için de cayma hakkı kullanılamaz.\n3.\tAlıcı’nın cayma hakkını kullanmasından itibaren 14 (on dört) gün içerisinde (mal satışına ilişkin işlemlerde malın Güven Hastanesi’nin iade için belirttiği taşıyıcı aracılığıyla geri gönderilmesi kaydıyla), Alıcı’nın ilgili mal veya hizmete ilişkin Güven Hastanesi’ne yaptığı tüm ödemeler Alıcı’ya Hizmet Paketi’ni satın alırken kullandığı ödeme aracına uygun bir şekilde ve Alıcı’ya herhangi bir masraf veya yükümlülük getirmeden ve tek seferde iade edilecektir.\n4.\tCayma hakkına ilişkin bildirimler Güven Hastanesi’ne ait <hospitalEmail> e-posta adresine yapılacaktır.\n5.\tCayma hakkının kullanımından kaynaklanan masraflar Güven Hastanesi’ne aittir. Alıcı, işbu Bilgilendirme Formu’nu ve mesafeli satış sözleşmesini kabul etmekle, cayma hakkı konusunda bilgilendirildiğini peşinen kabul eder.\nMADDE 6: SORUMLULUK SINIRI \n1.\tAlıcı’nın her durumda tıbbi tanı, tedavi ve hastalıkların önlenmesi için özgür iradesiyle seçeceği hekimine başvurması, kontrollerini aksatmaması ve her türlü acil durumda vakit kaybetmeden en yakın acil servise müracaat etmesi gerekmektedir. Aksi halde Güven Hastanesi’nin hiçbir sorumluluğu bulunmamaktadır.\n2.\t“Online görüşme” kapsamında Güven Online’da yer alan hekimler tarafından Alıcı’ya herhangi bir tıbbi işlem (muayene, tanı, teşhis, tedavi gibi) sunulmamakta ve vaat edilmemekte olup; Güven Hastanesi’nin ve/veya Güven Online’da yer alan hekimlerin tıbbi kötü uygulamadan (malpraktis) dolayı herhangi bir sorumluluğu bulunmayacaktır.\n3.\t“Online görüşme” kapsamında Güven Online’da yer alan hekimler, herhangi bir görüşte bulunmuş olmamaktadır. “Online görüşme” kapsamında sunulan herhangi bir bilgi veya verinin doğruluğunu teyit etmek Alıcı’nın yükümlülüğü ve sorumluluğundadır. “Online görüşme” kapsamında Güven Hastanesi ve Güven Online’da yer alan hekimler, Güven Online’ın ve/veya “online görüşme” özelliğinin kullanılması veya kullanılmaması, Güven Online’da sunulan hizmetin aksaması veya kesintiye uğraması ve mesafeli satış sözleşmesindeki hizmetlerin ifası nedeniyle ortaya çıkabilecek herhangi bir yaralanma, bedensel zarar, maddi veya manevi zarar, kâr kaybı, iş kaybı veya sair her türlü doğrudan ya da dolaylı zararlardan hiçbir biçimde sorumlu değildir.\n4.\tUygulanacak hukuk altında izin verildiği ölçüde, Güven Hastanesi’nin Alıcı’nın Hizmet Paketi ve mesafeli satış sözleşmesi kapsamındaki herhangi bir zararına ilişkin sorumluluğu, hangisi daha az ise; (i) sorumluluğu doğuran olaydan önceki 1 (bir) takvim ayı içinde Alıcı tarafından “Güven Online üzerinden” Güven Hastanesi’ne ödenmiş olan Hizmet Paketi bedelleri toplamı, veya (ii) 1.000 (bin) Türk Lirası ile sınırlıdır.\n5.\tAlıcı’nın mesafeli satış sözleşmesini ihlal ederek üçüncü kişilerin herhangi bir zararına sebep olması halinde Alıcı, bu zarardan Güven Hastanesi’ni masun tutacaktır. Alıcı’dan kaynaklanan herhangi bir sebeple Güven Hastanesi’nin herhangi bir zarara uğraması halinde bu zarar Alıcı tarafından derhal nakden ve defaten tazmin edilecektir.\nMADDE 7: DİĞER HÜKÜMLER\n1.\tMesafeli satış sözleşmesi tahtında Taraflar arasında yapılacak her türlü yazışma, mevzuatta sayılan zorunlu haller dışında e-posta aracılığıyla yapılır. Mevzuatta yazılı hallerde Tarafların belirtmiş olduğu adresleri tebligat adresleri olarak kabul edilir. 15 (on beş) gün içerisinde karşı Tarafa bildirilmeyen tebligat adresi değişikliklerinde tebligat usulüne uygun olarak yapılmış sayılır.\n2.\tGüven Hastanesi, kendi kontrolü dışında meydana gelen, öngörülemeyen ve önlenemeyen doğal afetler, yangın, patlamalar, iç savaşlar, savaşlar, ayaklanmalar, halk hareketleri, seferberlik ilanı, grev, lokavt ve salgın hastalıklar gibi mücbir sebep hallerinden dolayı oluşabilecek herhangi bir gecikme veya yükümlülüklerin ifa edilememesinden kaynaklanabilecek zarar ve ziyandan sorumlu olmayacaktır. Mücbir sebep halinin Güven Hastanesi’nin mesafeli satış sözleşmesinde yazılı yükümlülüklerini doğrudan etkilemesi durumunda Güven Hastanesi’nin mesafeli satış sözleşmesini tazminatsız ve tek taraflı feshetme hakkı saklıdır.\n3.\tBu Bilgilendirme Formu’nun ve/veya mesafeli satış sözleşmesinin herhangi bir madde veya kısmının geçersiz, hükümsüz veya ifa edilemez sayılması halinde, o madde veya kısım, onun lafzi amacına en yakın ve aynı zamanda ifa edilebilir olan bir şekilde ve kapsamda yorumlanacak ve uygulanacaktır; ancak bunun mümkün olmaması halinde, o madde veya kısım Bilgilendirme Formu’nda ve/veya mesafeli satış sözleşmesinden ayrılmış ve çıkartılmış sayılacak ve bu durum, Bilgilendirme Formu’nun ve/veya mesafeli satış sözleşmesinin kalan madde ve hükümlerini hiçbir şekilde etkilemeyecek veya geçersiz hale getirmeyecek ve Bilgilendirme Formu’nun ve mesafeli satış sözleşmesinin diğer madde ve hükümleri tam geçerli ve yürürlükte kalmaya devam edecektir.\n4.\tHiçbir feragat yazılı olarak ve Taraflarca yapılmadıkça geçerli olmayacaktır. Taraflardan herhangi birinin mesafeli satış sözleşmesinin herhangi bir hükmünün veya şartının sağlanmasını talep etmemesi ya da herhangi bir Tarafın mesafeli satış sözleşmesinin herhangi bir ihlalinden doğan talep hakkından feragat etmesi, söz konusu hüküm veya şartın bundan sonra uygulanmasını engellemeyecektir ve bir sonraki ihlalden feragat olarak sayılmayacaktır.\n5.\tGüven Hastanesi, mesafeli satış sözleşmesinden doğan hak ve yükümlülüklerini hiçbir sınırlama olmaksızın üçüncü şahıslara devretmek hakkını haizdir.\n6.\tTaraflar, Bilgilendirme Formu’nun ve mesafeli satış sözleşmesinin geçerliliği, uygulanması ve yorumlanması konusunda kanunlar ihtilafına dair kurallar hariç olmak üzere münhasır şekilde Türkiye Cumhuriyeti yasaları ve ilgili mevzuatının uygulanacağını kabul ve beyan ederler.\n7.\tBilgilendirme Formu ve mesafeli satış sözleşmesi ile ilgili çıkacak ihtilaflarda; her yıl Ticaret Bakanlığı tarafından ilan edilen değere kadar Alıcı’nın yerleşim yerindeki Hizmet Paketi’ni satın aldığı veya ikametgâhının bulunduğu yerdeki İl veya İlçe Tüketici Sorunları Hakem Heyetleri, söz konusu değerin üzerindeki ihtilaflarda ise Tüketici Mahkemeleri yetkilidir.\n8.\tBilgilendirme Formu ve mesafeli satış sözleşmesinden doğabilecek ihtilaflarda Güven Hastanesi’nin resmi defter ve ticari kayıtlarıyla, kendi veritabanında, sunucularında tuttuğu elektronik bilgiler ve bilgisayar kayıtları, bağlayıcı, kesin ve münhasır delil teşkil eder. Bu madde Hukuk Muhakemeleri Kanunu’nun 193. maddesi anlamında delil sözleşmesi niteliğindedir.  \n9.\tALICI, GÜVEN ONLINE VE SÖZLEŞME KAPSAMINDAKİ HİZMETİN NİTELİKLERİ VE BEDELİ İLE EK-1: ONLINE DOKTOR VE E-KONSÜLTASYON HİZMETİNİN KAPSAMI HAKKINDA BİLGİLENDİRME VE AYDINLATILMIŞ ONAM BELGESİ’NDEKİ HUSUSLARA İLİŞKİN OLARAK GÜVEN HASTANESİ TARAFINDAN KENDİSİNE YAPILAN BİLGİLENDİRMELERİ VE KENDİ SORUMLULUKLARINI OKUYUP ANLADIĞINI, ANLAMADIĞI KISIMLARIN OLMASI HALİNDE SORU SORDUĞUNU, SORULARININ YETKİLİ KİŞİLERCE CEVAPLANDIĞINI, EKSİKSİZ OLARAK BİLGİLENDİĞİNİ KABUL VE BEYAN EDER.\n7 (yedi) maddeden ve 1 (bir) adet ekten ibaret işbu Bilgilendirme Formu, Alıcı tarafından elektronik ortamda okunup onaylanmak suretiyle akdedilmiş ve derhal yürürlüğe girmiştir.\n\nEk-1: Online Doktor ve E-Konsültasyon Hizmetinin Kapsamı Hakkında Bilgilendirme ve Aydınlatılmış Onam Belgesi\n\nALICI\t                          GÜVEN HASTANESİ A.Ş.\n\n \nEK-1:\nONLINE DOKTOR VE E-KONSÜLTASYON\nHİZMETİNİN KAPSAMI HAKKINDA BİLGİLENDİRME\nVE\nAYDINLATILMIŞ ONAM BELGESİ\nGüncelleme: 03.04.2020\n\nGüven Hastanesi A.Ş.’ye (“Güven Hastanesi”) ait web sitesi ve telefon uygulamaları (“Online Platform”) üzerinden sunulan ONLINE DOKTOR VE E-KONSÜLTASYON HİZMETİ’nin (“Hizmet”) kapsamı konusunda tarafıma yazılı bilgilendirme yapılmıştır. \n1.\tHizmet kapsamında, Online Platform üzerinden Güven Hastanesi hekimleri tarafından danışma ve konsültasyon imkanı sunulacağı; \n2.\tHizmet’in hasta ve hekimin bir arada bulunmasını gerektiren durumlarda muayenenin muadili olmadığı; \n3.\tHer türlü tıbbi tanı ve tedavi ihtiyaçlarım için özgür irademle seçeceğim hekimime başvuru yapmam ve fiziken muayene olmam gerektiği, \n4.\tSağlığımı ilgilendiren ve aciliyeti olan konularda, vakit kaybetmeden en yakın acil servise müracaat etmem gerektiği, \n5.\tAksi halde gerçekleşebilecek olumsuz sonuçlardan Güven Hastanesi’nin hiçbir şekilde sorumlu tutulamayacağı, \nkonularında yazılı olarak aydınlatıldım. \nKonu hakkında sorum olması halinde ulaşabileceğim iletişim numaraları tarafımla paylaşıldı. \nGelinen aşamada; \nTarafıma yapılan tüm yazılı bilgilendirmeleri okuduğumu, anladığımı ve bu haliyle kabul ettiğimi; ONLINE DOKTOR VE E-KONSÜLTASYON HİZMETİ’nden bu bilgilendirmeler doğrultusunda yararlanacağımı kabul ve beyan ediyorum.\n(İşbu Belge GÜVEN HASTANESİ ile ALICI arasındaki MESAFELİ SATIŞ SÖZLEŞME’sinin tamamlayıcı bir parçası olarak ALICI’ya imzalatılmıştır.)\n\n\n',
      name: 'preinformation_form_context',
      desc: '',
      args: [],
    );
  }

  /// `DISTANCE SALES AGREEMENT\nUpdated as of: 16.09.2021\nARTICLE 1: PARTIES and SUBJECT MATTER\n1.\tThis Distance Sales Agreement (the “Agreement”) has been entered into by the parties listed below: \nSELLER (“Güven Hospital”) \nTrade Name\t: Güven Hastanesi A.Ş.\nAddress\t\t: Remzi Oğuz Arık Mahallesi Paris Cad. No:58 Çankaya Ankara\nTelephone\t: 444 94 94\nE-mail \t\t: guven@guven.com.tr\nMERSİS No.\t: 0451001685100012\nBUYER (“Buyer”)\nFull Name \t: <userName>\nAddress \t\t:<adress>\nTelephone\t: <phoneNumber>\nE-mail \t\t: <email>\nThe Buyer and Güven Hospital may be individually referred to as a “Party” and jointly as the “Parties”. \n2.\tGüven Hospital is a private hospital providing patients with ambulatory and in-patient medical examination, diagnosis and treatment services of various medical specialities and seated at the address of Paris Caddesi No: 58 Kavaklıdere Ankara, in the Ankara province, holding the qualifications prescribed for under the “Private Hospitals Regulation” published on the Official Gazette dated 11.03.2009 and numbered 27166 and other relevant legislation. \n3.\tThis Agreement has been prepared in accordance with the Consumer Protection Law No. 6502 (the “Law”) and the Distance Agreements Regulation. This Agreement provides for the Parties’ mutual rights and obligations for the Buyer’s purchase of the healthcare service package as defined under Article 2.2 of this Agreement (the “Service Package”) from the web site and mobile applications owned by Güven Hospital (the “Online Platform”). \n4.\tThe Parties to this Agreement accept and represent that they are informed of and understand their obligations and responsibilities arising out of the Law and the Distance Agreements Regulation within the context of this Agreement. \n5.\tBy way of approving this Agreement and the Preliminary Disclosure Form by electronic means, Buyer confirms the complete and accurate receipt of the information that must be provided by Güven Hospital to the Buyer prior to the execution of a distance agreement, namely those on address, the essential features of the service that is ordered, the full price of the service including taxes and payment information. \nARTICLE 2: ESSENTIAL FEATURES OF THE SUBJECT MATTER OF THE AGREEMENT AND PRICE \n1.\tThe essential features of the Service Package are listed on the Online Platform and may likewise be reviewed on the Online Platform. Where the Service Package is an “online meeting”, the Service Package is not a substitute for a medical examination in cases where the patient and the physician must be together and is solely for the purposes of the Buyer inquiring and consulting with the physician chosen on the Online Platform. \n2.\tInformation as to the Service Package purchased by the Buyer by this Agreement are as below:\nExplanation on the Service Package\tQuantity\tUnit Price\tSubtotal (VAT Inclusive)\n<packageName>\n\t\t\nTotal:\t\n\nPayment Method and Plan\t: <paymentPlan>\nInvoice Address\t\t\t: <adress>\nDelivery Address\t\t: <adress>\nRecipient\t\t\t: <userName>\nDate of Purchase\t\t: <currentDate>\n3.\tPrices published on the Online Platform are sales prices. Published prices and offers are valid until they are updated or changed. Prices published for a certain term are valid until the expiry of said term. \n4.\tThe Service Package approved and purchased by the Buyer over the Online Platform shall be processed no later than 24 hours by Güven Hospital and relayed to its relevant units. \n5.\tService shall be provided by Güven Hospital to the Buyer as soon as possible and in any event no later than 7 (seven) business days. In cases where the Service Package corresponds to a service that is for a single use only, the Buyer must use the Service Package by <expirationDate> at the latest. In cases where the Service Package corresponds to a service that is by nature continuous over a certain term, the Buyer must commence the use of the Service Package by <currentDate> at the latest and must then finish the use of all the Service Package in 3 (three) months starting from said date. Service Packages that are not used prior to the dates specified in this article shall not be usable after the expiry of said dates, no payment / repayment shall be made to the Buyer in this regard and the Buyer shall correspondingly have no rights of recourse. \n6.\tIn the event of any delays that are not attributable to Güven Hospital, Güven Hospital shall promptly notify the event to the Buyer. \n7.\tThe full or deferred price of the Service Package purchased by the Buyer shall be listed on the order form, shall be approved by the Buyer, and shall be sent to the Buyer’s e-mail address as an e-invoice following the completion of the order. Any discounts and promotion, if applied, shall be reflected on the sales price. \n8.\tWhere the Service Package requires a physical delivery to the Buyer, delivery charges are on the Buyer unless otherwise indicated by Güven Hospital. In this case, Güven Hospital shall deliver the Service Package in 30 (thirty) days following the order date. Güven Hospital reserves its right to extend this term by an additional 10 (ten) days via written notice during this period. Upon the delivery of the Service Package to the post or to the courier company, the risk shall pass to the Buyer. \n9.\tThis Agreement shall come into effect upon its approval by the Buyer on the Online Platform and shall be deemed to have been performed by the delivery of the Service Package purchased by the Buyer from Güven Hospital physically and/or via online means. \n10.\tThe Service Package shall be delivered to the person or persons present at the address indicated by the Buyer on the order form and in this Agreement. \nARTICLE 3: BUYER’S REPRESENTATIONS AND UNDERTAKINGS\n1.\tThe Buyer represents that it has duly received preliminary information on the features of the Service Package, its sales price inclusive of taxes, the payment method, delivery, its right of withdrawal and terms of use, and that it has read, understood, has been fully informed of, has electronically agreed to, and has electronically made all necessary approvals for the information provided to itself by Güven Hospital over the Online Platform. \n2.\tBy way of accepting this Agreement, the Buyer agrees in advance that upon its approval of the Service Package subject matter to this Agreement, it is under the obligation to pay for the price of the Service Package and additional fees such as tax and that it has been informed in this regard. \n3.\tFor the intended performance of the chosen Service Package and limited with purpose of performing the service listed under the Service Package, the Buyer expressly consents to the processing of its medical data that is deemed as sensitive personal data by the Personal Data Protection Law No. 6698.\n4.\tThe Buyer may relay its requests and complaints to Güven Hospital’s communication channels listed above. Güven Hospital shall promptly revert to the Buyer following the evaluation of said requests and complaints. \n5.\tThe Buyer agrees, represents, and undertakes that in case of any failure to pay for the price of the Service Package subject matter to this Agreement and/or the cancellation of the payment over bank records, Güven Hospital’s obligation to perform and/or deliver the Service Package subject matter to this Agreement shall expire. \n6.\tThe Buyer agrees and represents that in and while accepting this Agreement, the Buyer is at least 18 years of age or is at an age mandated by the relevant country’s laws to be legally capable of accepting this Agreement, that its capacity is not restricted and that it is authorized to accept this Agreement. If it is determined that the Buyer is younger than the age prescribed for in this article, is of restricted capacity or is not in any manner authorized to execute this Agreement, Güven Hospital may immediately terminate this Agreement and no return payments shall be made to the Buyer or its legal representative. \n7.\tWhere the Service Package is an “online meeting”, the Buyer is required to log in to the Güven Online application no later than 5 (five) minutes before the appointment time, be ready for connection and commence the meeting with the physician. If the Buyer is not ready as prescribed for under this article and/or does not attend the meeting at all, the meeting shall be priced as if it were duly conducted, and no return payments shall be made to the Buyer. \n8.\tWhere the Service Package is an “online meeting”, issues necessary for the Buyer’s consideration to conduct a video meeting and information on the software and hardware necessary for the utilization of the service are listed in the relevant sections of the web page “https://www.guven.com.tr/online-doktor” and may be updated from time to time by Güven Hospital. The Buyer is under the obligation to abide by these as well as to keep track of any updates. \n9.\tThe Buyer represents and undertakes that it has read, understood, and accepted the information listed under Annex-1: Information on the Scope of the Online Doctor and E-Consultation Service and Informed Consent Document. \nARTICLE 4: SEQUENCE OF PERFORMANCE, DEFAULT, AND ITS LEGAL CONSEQUENCES\n1.\tFollowing payment by the Buyer, in compliance with the terms of this Agreement, Güven Hospital shall provide the service prescribed under the Service Package specified in this Agreement. \n2.\tIn the event of any default on the side of the Buyer, the Buyer agrees to pay for any damages and costs incurred by Güven Hospital due to the late performance of its obligation. \nARTICLE 5: RIGHT OF WITHDRAWAL\n1.\tThe Buyer, without any civil or criminal consequences and without providing for a cause, may use its right of withdrawal within 14 (fourteen) days, which starts from the date of delivery for the sale of goods, and starts from the date of purchase for the sale of services. For transactions on the sale of goods, the Buyer may also use its right of withdrawal until the delivery of the goods. \n2.\tThe right of withdrawal cannot be used by the Buyer if the service within the scope of the Service Package is used, in part or in full, by the Buyer. Similarly, the right of withdrawal may not be used for services that are being performed following the Buyer’s consent prior to the expiry of the term available for the right of withdrawal. \n3.\tWithin 14 (fourteen) days starting from the date of the Buyer’s use of its right of withdrawal (and on condition that for the sale of goods, the goods are returned through the courier specified for this purpose by Güven Hospital), all payments made by the Buyer to Güven Hospital for the relevant good or service shall be returned to or through the payment instrument used by the Buyer for the purchase of the Service Package, without any costs or obligations to the Buyer and in one payment. \n4.\tAny notifications for the right of withdrawal shall be made to the e-mail address of <hospitalEmail> operated by Güven Hospital. \n5.\tAny costs arising out of the utilization of the right of withdrawal shall be borne by Güven Hospital. The Buyer agrees in advance that by way of accepting this Agreement, it has been informed of its right of withdrawal. \nARTICLE 6: LIMITATION OF LIABILITY\n1.\tIn all cases, for medical diagnoses, treatments and disease prevention, Buyer is required to consult its physician freely chosen at its own ultimate discretion, not to skip any routine controls and in case of all emergencies, to apply to the closest emergency ward without any delay. Güven Hospital shall have absolutely no liability for any acts or actions to the contrary. \n2.\tNo medical procedures (such as examinations, diagnoses, or treatments) are offered or provided by the physicians attending Güven Online through the scope of the “online meeting”, and Güven Hospital and/or the physicians attending Güven Online shall have absolutely no liability for any professed malpractice. \n3.\tThe physicians attending Güven Online for an “online meeting” are not providing any advice. It is the Buyer’s responsibility and obligation to verify the correctness of any information or data provided during an “online meeting”. Güven Hospital and the physicians attending Güven Online shall have absolutely no liability for the use or failure to use of Güven Online and/or the “online meeting” feature, any disruption of the service provided over Güven Online and any wounding, physical injuries, actual or moral damages, loss of profit, loss of employment opportunity and similar direct or indirect damages. \n4.\tTo the extent possible under the applicable law, Güven Hospital’s liability for any damages incurred by the Buyer due to the Service Package and Agreement shall be limited by whichever is the lowest of (i) the sum total of the amounts paid by the Buyer to Güven Hospital over Güven Online within the 1 (one) calendar month before the occurrence of the event giving rise to liability, or (ii) 1,000 (one thousand) Turkish Liras. \n5.\tThe Buyer shall hold Güven Hospital harmless in cases where the Buyer damages any third parties by its breach of this Agreement. If Güven Hospital incurs any damages due to any reason attributable to the Buyer, said damages shall be compensated for by the Buyer promptly, in cash and in full. \nARTICLE 7: MISCELLANEOUS PROVISIONS\n1.\tAll correspondence related with this Agreement by and between the Parties shall be done so through e-mail, except in cases where the applicable legislation explicitly requires another form of communication. For these cases provided for in the applicable legislation, the Parties’ designated addresses shall be deemed as their service addresses. Unless any changes of address are notified to the other Party in 15 (fifteen) days, all notifications to the former address shall be deemed to have been duly served. \n2.\tGüven Hospital shall bear no liability for any damages or losses arising out of or in connection with any delays or a failure to perform any obligations due to unforeseeable and unpreventable force majeure events out of its control, such as natural disasters, fires, explosions, civil wars, wars, uprisings, riots, mobilizations, strikes, lockouts, and pandemics. In cases where a force majeure event directly affects Güven Hospital’s obligations provided for in this Agreement, Güven Hospital reserves its right to unilaterally terminate this agreement without compensation. \n3.\tIf any of the articles or any part of this agreement is deemed as invalid, void or unenforceable, then said article or part shall be construed and performed in a manner and form that is enforceable and that is closest to its literal purpose; however, in cases where this is not possible, said article or part shall be deemed to have been severed and removed from this Agreement and such severance and removal shall in no manner affect or invalidate the remaining articles and terms of this Agreement, and the remaining articles and terms of this Agreement shall continue to remain valid and in full effect. \n4.\tNo waiver shall be valid unless it is in writing and is done so by the Parties. Any failure to request the performance of any of the terms and conditions of this Agreement by any Party, or the waiver of any Party’s rights of recourse due to the breach of this Agreement, shall not prevent the performance of said term or condition in the future or shall not be construed as a waiver of any potential future breach. \n5.\tGüven Hospital reserves its right to assign any of its rights or liabilities arising out of this Agreement to third parties without any restriction. \n6.\tThe Parties agree and undertake that the laws and regulations of the Republic of Turkey, excluding its choice of law provisions, shall exclusively govern this Agreement, and shall be used to interpret the validity, performance, and construction of this Agreement. \n7.\tIn connection with any disputes arising out of this Agreement, for issues at or below the monetary limit announced annually by the Ministry of Commerce, the District or Provincial Consumer Issues Arbitration Tribunal seated at the registered address of the Buyer or at the location where the Buyer purchased the Service Package shall be authorized, and for any disputes above said monetary limit, Consumer Courts shall have jurisdiction. \n8.\tGüven Hospital’s official books and commercial records, as well as the electronic information and computer data held in its servers and database, shall be binding, exclusive and definitive evidence. This article is a contract for evidence within the context of Article 193 of the Civil Procedural Law.\n9.\tTHE BUYER AGREES AND REPRESENTS THAT IT HAS READ AND UNDERSTOOD THE INFORMATION PROVIDED TO ITSELF BY GÜVEN HOSPITAL ON THE FEATURES OF THE SERVICE THAT IS TO BE PROVIDED OVER GÜVEN ONLINE AND THROUGH THIS AGREEMENT AND ITS OBLIGATIONS THEREFROM, THAT IT HAS POSED INQUIRIES ON ISSUES THAT IT DID NOT UNDERSTAND, THAT SUCH INQUIRIES WERE ANSWERED BY AUTHORIZED PERSONNEL AND THAT IT WAS INFORMED IN FULL. \nThis Agreement, being comprised of 7 (seven) articles and 1 (one) annex, has been executed by the Buyer by way of being read and approved electronically, and came into effect immediately. \n\nAnnex-1: Information on the Scope of the Online Doctor and E-Consultation Service and Informed Consent Document\n\nBUYER\t                          GÜVEN HASTANESİ A.Ş.\n\n \nANNEX-1:\nINFORMATION ON THE SCOPE OF THE ONLINE DOCTOR AND E-CONSULTATION SERVICE\n AND \nINFORMED CONSENT DOCUMENT\nUpdated as of: 03.04.2020\n\nI have been informed in writing of the scope of the ONLINE DOCTOR AND E-CONSULTATION SERVICE (the “Service”) provided by the web site and mobile applications (the “Online Platform”) owned by Güven Hastanesi A.Ş. (“Güven Hospital”).\nI have been clearly informed in writing that \n1.\tWithin the scope of the Service, through the Online Platform, the possibility of Güven Hospital physicians’ advice and consultation is being offered, \n2.\tIn cases where the patient and the physician must be together, the Service is not a substitute for medical examination, \n3.\tFor all personal needs of medical diagnosis and treatment, I must apply to my physician freely chosen at my own ultimate discretion and that I must be physically examined, \n4.\tIn emergency cases that concern my health, I must apply to the nearest emergency ward without delay, and\n5.\tGüven Hospital carries absolutely no liability for any adverse consequences due to any failure to abide by the above.\nI was provided with phone numbers that I may contact if I had any inquiries as to the above. \nAccordingly: \nI accept and represent that I have read, understood, and accepted all written information relayed to me as they are, and that I will utilize the ONLINE DOCTOR AND E-CONSULTATION SERVICE within the guidelines set forth in said information. \n(This Document has been signed by the BUYER as a supplementary part of the DISTANCE SALES AGREEMENT by and between GÜVEN HOSPITAL and the BUYER.)\n\n\n`
  String get distance_sales_contract_context {
    return Intl.message(
      'DISTANCE SALES AGREEMENT\nUpdated as of: 16.09.2021\nARTICLE 1: PARTIES and SUBJECT MATTER\n1.\tThis Distance Sales Agreement (the “Agreement”) has been entered into by the parties listed below: \nSELLER (“Güven Hospital”) \nTrade Name\t: Güven Hastanesi A.Ş.\nAddress\t\t: Remzi Oğuz Arık Mahallesi Paris Cad. No:58 Çankaya Ankara\nTelephone\t: 444 94 94\nE-mail \t\t: guven@guven.com.tr\nMERSİS No.\t: 0451001685100012\nBUYER (“Buyer”)\nFull Name \t: <userName>\nAddress \t\t:<adress>\nTelephone\t: <phoneNumber>\nE-mail \t\t: <email>\nThe Buyer and Güven Hospital may be individually referred to as a “Party” and jointly as the “Parties”. \n2.\tGüven Hospital is a private hospital providing patients with ambulatory and in-patient medical examination, diagnosis and treatment services of various medical specialities and seated at the address of Paris Caddesi No: 58 Kavaklıdere Ankara, in the Ankara province, holding the qualifications prescribed for under the “Private Hospitals Regulation” published on the Official Gazette dated 11.03.2009 and numbered 27166 and other relevant legislation. \n3.\tThis Agreement has been prepared in accordance with the Consumer Protection Law No. 6502 (the “Law”) and the Distance Agreements Regulation. This Agreement provides for the Parties’ mutual rights and obligations for the Buyer’s purchase of the healthcare service package as defined under Article 2.2 of this Agreement (the “Service Package”) from the web site and mobile applications owned by Güven Hospital (the “Online Platform”). \n4.\tThe Parties to this Agreement accept and represent that they are informed of and understand their obligations and responsibilities arising out of the Law and the Distance Agreements Regulation within the context of this Agreement. \n5.\tBy way of approving this Agreement and the Preliminary Disclosure Form by electronic means, Buyer confirms the complete and accurate receipt of the information that must be provided by Güven Hospital to the Buyer prior to the execution of a distance agreement, namely those on address, the essential features of the service that is ordered, the full price of the service including taxes and payment information. \nARTICLE 2: ESSENTIAL FEATURES OF THE SUBJECT MATTER OF THE AGREEMENT AND PRICE \n1.\tThe essential features of the Service Package are listed on the Online Platform and may likewise be reviewed on the Online Platform. Where the Service Package is an “online meeting”, the Service Package is not a substitute for a medical examination in cases where the patient and the physician must be together and is solely for the purposes of the Buyer inquiring and consulting with the physician chosen on the Online Platform. \n2.\tInformation as to the Service Package purchased by the Buyer by this Agreement are as below:\nExplanation on the Service Package\tQuantity\tUnit Price\tSubtotal (VAT Inclusive)\n<packageName>\n\t\t\nTotal:\t\n\nPayment Method and Plan\t: <paymentPlan>\nInvoice Address\t\t\t: <adress>\nDelivery Address\t\t: <adress>\nRecipient\t\t\t: <userName>\nDate of Purchase\t\t: <currentDate>\n3.\tPrices published on the Online Platform are sales prices. Published prices and offers are valid until they are updated or changed. Prices published for a certain term are valid until the expiry of said term. \n4.\tThe Service Package approved and purchased by the Buyer over the Online Platform shall be processed no later than 24 hours by Güven Hospital and relayed to its relevant units. \n5.\tService shall be provided by Güven Hospital to the Buyer as soon as possible and in any event no later than 7 (seven) business days. In cases where the Service Package corresponds to a service that is for a single use only, the Buyer must use the Service Package by <expirationDate> at the latest. In cases where the Service Package corresponds to a service that is by nature continuous over a certain term, the Buyer must commence the use of the Service Package by <currentDate> at the latest and must then finish the use of all the Service Package in 3 (three) months starting from said date. Service Packages that are not used prior to the dates specified in this article shall not be usable after the expiry of said dates, no payment / repayment shall be made to the Buyer in this regard and the Buyer shall correspondingly have no rights of recourse. \n6.\tIn the event of any delays that are not attributable to Güven Hospital, Güven Hospital shall promptly notify the event to the Buyer. \n7.\tThe full or deferred price of the Service Package purchased by the Buyer shall be listed on the order form, shall be approved by the Buyer, and shall be sent to the Buyer’s e-mail address as an e-invoice following the completion of the order. Any discounts and promotion, if applied, shall be reflected on the sales price. \n8.\tWhere the Service Package requires a physical delivery to the Buyer, delivery charges are on the Buyer unless otherwise indicated by Güven Hospital. In this case, Güven Hospital shall deliver the Service Package in 30 (thirty) days following the order date. Güven Hospital reserves its right to extend this term by an additional 10 (ten) days via written notice during this period. Upon the delivery of the Service Package to the post or to the courier company, the risk shall pass to the Buyer. \n9.\tThis Agreement shall come into effect upon its approval by the Buyer on the Online Platform and shall be deemed to have been performed by the delivery of the Service Package purchased by the Buyer from Güven Hospital physically and/or via online means. \n10.\tThe Service Package shall be delivered to the person or persons present at the address indicated by the Buyer on the order form and in this Agreement. \nARTICLE 3: BUYER’S REPRESENTATIONS AND UNDERTAKINGS\n1.\tThe Buyer represents that it has duly received preliminary information on the features of the Service Package, its sales price inclusive of taxes, the payment method, delivery, its right of withdrawal and terms of use, and that it has read, understood, has been fully informed of, has electronically agreed to, and has electronically made all necessary approvals for the information provided to itself by Güven Hospital over the Online Platform. \n2.\tBy way of accepting this Agreement, the Buyer agrees in advance that upon its approval of the Service Package subject matter to this Agreement, it is under the obligation to pay for the price of the Service Package and additional fees such as tax and that it has been informed in this regard. \n3.\tFor the intended performance of the chosen Service Package and limited with purpose of performing the service listed under the Service Package, the Buyer expressly consents to the processing of its medical data that is deemed as sensitive personal data by the Personal Data Protection Law No. 6698.\n4.\tThe Buyer may relay its requests and complaints to Güven Hospital’s communication channels listed above. Güven Hospital shall promptly revert to the Buyer following the evaluation of said requests and complaints. \n5.\tThe Buyer agrees, represents, and undertakes that in case of any failure to pay for the price of the Service Package subject matter to this Agreement and/or the cancellation of the payment over bank records, Güven Hospital’s obligation to perform and/or deliver the Service Package subject matter to this Agreement shall expire. \n6.\tThe Buyer agrees and represents that in and while accepting this Agreement, the Buyer is at least 18 years of age or is at an age mandated by the relevant country’s laws to be legally capable of accepting this Agreement, that its capacity is not restricted and that it is authorized to accept this Agreement. If it is determined that the Buyer is younger than the age prescribed for in this article, is of restricted capacity or is not in any manner authorized to execute this Agreement, Güven Hospital may immediately terminate this Agreement and no return payments shall be made to the Buyer or its legal representative. \n7.\tWhere the Service Package is an “online meeting”, the Buyer is required to log in to the Güven Online application no later than 5 (five) minutes before the appointment time, be ready for connection and commence the meeting with the physician. If the Buyer is not ready as prescribed for under this article and/or does not attend the meeting at all, the meeting shall be priced as if it were duly conducted, and no return payments shall be made to the Buyer. \n8.\tWhere the Service Package is an “online meeting”, issues necessary for the Buyer’s consideration to conduct a video meeting and information on the software and hardware necessary for the utilization of the service are listed in the relevant sections of the web page “https://www.guven.com.tr/online-doktor” and may be updated from time to time by Güven Hospital. The Buyer is under the obligation to abide by these as well as to keep track of any updates. \n9.\tThe Buyer represents and undertakes that it has read, understood, and accepted the information listed under Annex-1: Information on the Scope of the Online Doctor and E-Consultation Service and Informed Consent Document. \nARTICLE 4: SEQUENCE OF PERFORMANCE, DEFAULT, AND ITS LEGAL CONSEQUENCES\n1.\tFollowing payment by the Buyer, in compliance with the terms of this Agreement, Güven Hospital shall provide the service prescribed under the Service Package specified in this Agreement. \n2.\tIn the event of any default on the side of the Buyer, the Buyer agrees to pay for any damages and costs incurred by Güven Hospital due to the late performance of its obligation. \nARTICLE 5: RIGHT OF WITHDRAWAL\n1.\tThe Buyer, without any civil or criminal consequences and without providing for a cause, may use its right of withdrawal within 14 (fourteen) days, which starts from the date of delivery for the sale of goods, and starts from the date of purchase for the sale of services. For transactions on the sale of goods, the Buyer may also use its right of withdrawal until the delivery of the goods. \n2.\tThe right of withdrawal cannot be used by the Buyer if the service within the scope of the Service Package is used, in part or in full, by the Buyer. Similarly, the right of withdrawal may not be used for services that are being performed following the Buyer’s consent prior to the expiry of the term available for the right of withdrawal. \n3.\tWithin 14 (fourteen) days starting from the date of the Buyer’s use of its right of withdrawal (and on condition that for the sale of goods, the goods are returned through the courier specified for this purpose by Güven Hospital), all payments made by the Buyer to Güven Hospital for the relevant good or service shall be returned to or through the payment instrument used by the Buyer for the purchase of the Service Package, without any costs or obligations to the Buyer and in one payment. \n4.\tAny notifications for the right of withdrawal shall be made to the e-mail address of <hospitalEmail> operated by Güven Hospital. \n5.\tAny costs arising out of the utilization of the right of withdrawal shall be borne by Güven Hospital. The Buyer agrees in advance that by way of accepting this Agreement, it has been informed of its right of withdrawal. \nARTICLE 6: LIMITATION OF LIABILITY\n1.\tIn all cases, for medical diagnoses, treatments and disease prevention, Buyer is required to consult its physician freely chosen at its own ultimate discretion, not to skip any routine controls and in case of all emergencies, to apply to the closest emergency ward without any delay. Güven Hospital shall have absolutely no liability for any acts or actions to the contrary. \n2.\tNo medical procedures (such as examinations, diagnoses, or treatments) are offered or provided by the physicians attending Güven Online through the scope of the “online meeting”, and Güven Hospital and/or the physicians attending Güven Online shall have absolutely no liability for any professed malpractice. \n3.\tThe physicians attending Güven Online for an “online meeting” are not providing any advice. It is the Buyer’s responsibility and obligation to verify the correctness of any information or data provided during an “online meeting”. Güven Hospital and the physicians attending Güven Online shall have absolutely no liability for the use or failure to use of Güven Online and/or the “online meeting” feature, any disruption of the service provided over Güven Online and any wounding, physical injuries, actual or moral damages, loss of profit, loss of employment opportunity and similar direct or indirect damages. \n4.\tTo the extent possible under the applicable law, Güven Hospital’s liability for any damages incurred by the Buyer due to the Service Package and Agreement shall be limited by whichever is the lowest of (i) the sum total of the amounts paid by the Buyer to Güven Hospital over Güven Online within the 1 (one) calendar month before the occurrence of the event giving rise to liability, or (ii) 1,000 (one thousand) Turkish Liras. \n5.\tThe Buyer shall hold Güven Hospital harmless in cases where the Buyer damages any third parties by its breach of this Agreement. If Güven Hospital incurs any damages due to any reason attributable to the Buyer, said damages shall be compensated for by the Buyer promptly, in cash and in full. \nARTICLE 7: MISCELLANEOUS PROVISIONS\n1.\tAll correspondence related with this Agreement by and between the Parties shall be done so through e-mail, except in cases where the applicable legislation explicitly requires another form of communication. For these cases provided for in the applicable legislation, the Parties’ designated addresses shall be deemed as their service addresses. Unless any changes of address are notified to the other Party in 15 (fifteen) days, all notifications to the former address shall be deemed to have been duly served. \n2.\tGüven Hospital shall bear no liability for any damages or losses arising out of or in connection with any delays or a failure to perform any obligations due to unforeseeable and unpreventable force majeure events out of its control, such as natural disasters, fires, explosions, civil wars, wars, uprisings, riots, mobilizations, strikes, lockouts, and pandemics. In cases where a force majeure event directly affects Güven Hospital’s obligations provided for in this Agreement, Güven Hospital reserves its right to unilaterally terminate this agreement without compensation. \n3.\tIf any of the articles or any part of this agreement is deemed as invalid, void or unenforceable, then said article or part shall be construed and performed in a manner and form that is enforceable and that is closest to its literal purpose; however, in cases where this is not possible, said article or part shall be deemed to have been severed and removed from this Agreement and such severance and removal shall in no manner affect or invalidate the remaining articles and terms of this Agreement, and the remaining articles and terms of this Agreement shall continue to remain valid and in full effect. \n4.\tNo waiver shall be valid unless it is in writing and is done so by the Parties. Any failure to request the performance of any of the terms and conditions of this Agreement by any Party, or the waiver of any Party’s rights of recourse due to the breach of this Agreement, shall not prevent the performance of said term or condition in the future or shall not be construed as a waiver of any potential future breach. \n5.\tGüven Hospital reserves its right to assign any of its rights or liabilities arising out of this Agreement to third parties without any restriction. \n6.\tThe Parties agree and undertake that the laws and regulations of the Republic of Turkey, excluding its choice of law provisions, shall exclusively govern this Agreement, and shall be used to interpret the validity, performance, and construction of this Agreement. \n7.\tIn connection with any disputes arising out of this Agreement, for issues at or below the monetary limit announced annually by the Ministry of Commerce, the District or Provincial Consumer Issues Arbitration Tribunal seated at the registered address of the Buyer or at the location where the Buyer purchased the Service Package shall be authorized, and for any disputes above said monetary limit, Consumer Courts shall have jurisdiction. \n8.\tGüven Hospital’s official books and commercial records, as well as the electronic information and computer data held in its servers and database, shall be binding, exclusive and definitive evidence. This article is a contract for evidence within the context of Article 193 of the Civil Procedural Law.\n9.\tTHE BUYER AGREES AND REPRESENTS THAT IT HAS READ AND UNDERSTOOD THE INFORMATION PROVIDED TO ITSELF BY GÜVEN HOSPITAL ON THE FEATURES OF THE SERVICE THAT IS TO BE PROVIDED OVER GÜVEN ONLINE AND THROUGH THIS AGREEMENT AND ITS OBLIGATIONS THEREFROM, THAT IT HAS POSED INQUIRIES ON ISSUES THAT IT DID NOT UNDERSTAND, THAT SUCH INQUIRIES WERE ANSWERED BY AUTHORIZED PERSONNEL AND THAT IT WAS INFORMED IN FULL. \nThis Agreement, being comprised of 7 (seven) articles and 1 (one) annex, has been executed by the Buyer by way of being read and approved electronically, and came into effect immediately. \n\nAnnex-1: Information on the Scope of the Online Doctor and E-Consultation Service and Informed Consent Document\n\nBUYER\t                          GÜVEN HASTANESİ A.Ş.\n\n \nANNEX-1:\nINFORMATION ON THE SCOPE OF THE ONLINE DOCTOR AND E-CONSULTATION SERVICE\n AND \nINFORMED CONSENT DOCUMENT\nUpdated as of: 03.04.2020\n\nI have been informed in writing of the scope of the ONLINE DOCTOR AND E-CONSULTATION SERVICE (the “Service”) provided by the web site and mobile applications (the “Online Platform”) owned by Güven Hastanesi A.Ş. (“Güven Hospital”).\nI have been clearly informed in writing that \n1.\tWithin the scope of the Service, through the Online Platform, the possibility of Güven Hospital physicians’ advice and consultation is being offered, \n2.\tIn cases where the patient and the physician must be together, the Service is not a substitute for medical examination, \n3.\tFor all personal needs of medical diagnosis and treatment, I must apply to my physician freely chosen at my own ultimate discretion and that I must be physically examined, \n4.\tIn emergency cases that concern my health, I must apply to the nearest emergency ward without delay, and\n5.\tGüven Hospital carries absolutely no liability for any adverse consequences due to any failure to abide by the above.\nI was provided with phone numbers that I may contact if I had any inquiries as to the above. \nAccordingly: \nI accept and represent that I have read, understood, and accepted all written information relayed to me as they are, and that I will utilize the ONLINE DOCTOR AND E-CONSULTATION SERVICE within the guidelines set forth in said information. \n(This Document has been signed by the BUYER as a supplementary part of the DISTANCE SALES AGREEMENT by and between GÜVEN HOSPITAL and the BUYER.)\n\n\n',
      name: 'distance_sales_contract_context',
      desc: '',
      args: [],
    );
  }

  /// `BOY`
  String get boy {
    return Intl.message(
      'BOY',
      name: 'boy',
      desc: '',
      args: [],
    );
  }

  /// `GIRL`
  String get girl {
    return Intl.message(
      'GIRL',
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

  /// `In this section of the application, you are presented with an informative feature (“Symptom Checker”), which indicates which section you should refer to by ticking the areas of your body where you feel discomfort and the options appropriate for your symptoms. The Symptom Checker is a feature that has been produced for you to get support while identifying the potentially relevant section(s) that you only need to apply according to the symptoms marked by you; The Symptom Checker does not guarantee or warrant a precise, accurate, complete and flawless result. If, following the examination of the relevant physician, it is determined that the department(s) applied using the Symptom Controller is irrelevant and/or it is determined that another department(s) should be consulted, no fault can be attributed to us, nor is any liability for compensation for any damages or payments accepted. The Symptom Controller cannot be considered to have made any referrals. No medical procedure (such as examination, diagnosis, diagnosis, treatment) is offered or promised to you with the Symptom Controller; The services provided by the Symptom Controller cannot be interpreted as creating liability for medical malpractice. You are solely responsible for your health and any decisions, actions and practices related to your health. Based on the service provided by the Symptom Controller, you should never stop receiving medical care, delay receiving medical care, refuse medical advice, or terminate your ongoing treatment. The Symptom Controller is not a substitute for physician examination and/or treatment of the patient or monitoring of the patient's health status by a physician. Information presented with the Symptom Controller cannot be considered a medical opinion. In any case, you should consult your doctor for medical diagnosis, treatment and prevention of diseases, do not delay your controls, and apply to the nearest emergency service without losing time in any emergency. Otherwise, we have no responsibility. The Symptom Controller is provided as is (as is) and no representation, commitment or warranty is given to you. No warranty or commitment is made that the Symptom Checker is flawless, error-free, perfect, and will fully meet all your particular needs.`
  String get symptom_checker_consent_form_text {
    return Intl.message(
      'In this section of the application, you are presented with an informative feature (“Symptom Checker”), which indicates which section you should refer to by ticking the areas of your body where you feel discomfort and the options appropriate for your symptoms. The Symptom Checker is a feature that has been produced for you to get support while identifying the potentially relevant section(s) that you only need to apply according to the symptoms marked by you; The Symptom Checker does not guarantee or warrant a precise, accurate, complete and flawless result. If, following the examination of the relevant physician, it is determined that the department(s) applied using the Symptom Controller is irrelevant and/or it is determined that another department(s) should be consulted, no fault can be attributed to us, nor is any liability for compensation for any damages or payments accepted. The Symptom Controller cannot be considered to have made any referrals. No medical procedure (such as examination, diagnosis, diagnosis, treatment) is offered or promised to you with the Symptom Controller; The services provided by the Symptom Controller cannot be interpreted as creating liability for medical malpractice. You are solely responsible for your health and any decisions, actions and practices related to your health. Based on the service provided by the Symptom Controller, you should never stop receiving medical care, delay receiving medical care, refuse medical advice, or terminate your ongoing treatment. The Symptom Controller is not a substitute for physician examination and/or treatment of the patient or monitoring of the patient\'s health status by a physician. Information presented with the Symptom Controller cannot be considered a medical opinion. In any case, you should consult your doctor for medical diagnosis, treatment and prevention of diseases, do not delay your controls, and apply to the nearest emergency service without losing time in any emergency. Otherwise, we have no responsibility. The Symptom Controller is provided as is (as is) and no representation, commitment or warranty is given to you. No warranty or commitment is made that the Symptom Checker is flawless, error-free, perfect, and will fully meet all your particular needs.',
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

  /// `Create Appointment`
  String get create_appo {
    return Intl.message(
      'Create Appointment',
      name: 'create_appo',
      desc: '',
      args: [],
    );
  }

  /// `Güven Hospital Ayrancı`
  String get mars_hosp {
    return Intl.message(
      'Güven Hospital Ayrancı',
      name: 'mars_hosp',
      desc: '',
      args: [],
    );
  }

  /// `Güven Çayyolu Campus`
  String get neptune_hosp {
    return Intl.message(
      'Güven Çayyolu Campus',
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

  /// `Detaylı Sağlık Kontrolüne hoşgeldiniz, lütfen cinsiyetinizi ve doğum yılınızı sesli bir şekilde söyler misiniz? Örneğin, Erkek, 1980`
  String get symptom_checker_welcome {
    return Intl.message(
      'Detaylı Sağlık Kontrolüne hoşgeldiniz, lütfen cinsiyetinizi ve doğum yılınızı sesli bir şekilde söyler misiniz? Örneğin, Erkek, 1980',
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
