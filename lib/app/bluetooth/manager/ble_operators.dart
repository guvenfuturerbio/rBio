import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as ln;
import 'package:mi_scale/mi_scale.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scale_calculations/scale_calculations.dart';
import 'package:scale_repository/scale_repository.dart';

import '../../../../../core/core.dart';
import '../../../features/chronic_tracking/progress_sections/blood_glucose/widgets/tagger/bg_tagger_pop_up.dart';
import '../../../features/chronic_tracking/progress_sections/scale/widgets/mi_scale_popup.dart';
import '../../../features/chronic_tracking/progress_sections/scale/widgets/tagger/scale_tagger_pop_up.dart';
import '../../../model/device_model/scale_device_model.dart';

part 'ble_connector.dart';
part 'ble_reactor.dart';
part 'ble_scanner.dart';
part 'ble_manager.dart';
