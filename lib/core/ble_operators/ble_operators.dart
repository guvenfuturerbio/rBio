import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/core.dart';
import '../../../../../model/ble_models/DeviceTypes.dart';
import '../../features/chronic_tracking/progress_sections/glucose_progress/utils/blood_glucose_tagger/bg_tagger_pop_up.dart';
import '../../features/chronic_tracking/progress_sections/scale_progress/utils/mi_scale_popup.dart';
import '../../features/chronic_tracking/progress_sections/scale_progress/utils/scale_tagger/scale_tagger_pop_up.dart';
import '../../model/ble_models/paired_device.dart';
import '../../model/device_model/mi_scale_device.dart';
import '../../model/device_model/scale_device_model.dart';
import '../manager/local_notification_manager.dart';

part 'ble_connector.dart';
part 'ble_reactor.dart';
part 'ble_scanner.dart';
