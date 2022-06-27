import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as ln;
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/core.dart';
import '../../../features/chronic_tracking/blood_glucose/blood_glucose.dart';
import '../../../features/chronic_tracking/blood_glucose/blood_glucose_save_data_dialog/view/blood_glucose_save_data_dialog.dart';

part 'ble_connector.dart';
part 'ble_reactor.dart';
part 'ble_scanner.dart';
part 'ble_manager.dart';
