import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/model_converter.dart';
import '../../services/network_connection_service.dart';
import 'model/empty_model.dart';

part 'enum/request_type.dart';
part 'extension/core_service_extension.dart';
part 'extension/request_type.dart';
part 'model/error_model.dart';
part 'model/response_model.dart';
part 'service_manager.dart';
part 'src/service.dart';
part 'src/service_error.dart';
part 'src/service_network.dart';
part 'src/service_response.dart';
