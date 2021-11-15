import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/empty_model.dart';

import 'package:onedosehealth/services/model_converter.dart';
import 'package:onedosehealth/services/network_connection_service.dart';

part 'service_manager.dart';

part 'src/service.dart';
part 'src/service_network.dart';
part 'src/service_response.dart';
part 'src/service_error.dart';

part 'enum/request_type.dart';

part 'extension/request_type.dart';
part 'extension/core_service_extension.dart';

part 'model/response_model.dart';
part 'model/error_model.dart';
