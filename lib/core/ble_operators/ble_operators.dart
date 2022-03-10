import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as ln;

import 'package:mi_scale/mi_scale.dart';

import '../../../../../core/core.dart';
import '../../features/chronic_tracking/progress_sections/blood_glucose/widgets/tagger/bg_tagger_pop_up.dart';
import '../../features/chronic_tracking/progress_sections/scale/widgets/mi_scale_popup.dart';
import '../../features/chronic_tracking/progress_sections/scale/widgets/tagger/scale_tagger_pop_up.dart';

part 'ble_reactor.dart';
