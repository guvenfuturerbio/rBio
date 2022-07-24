import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../bluetooth/bluetooth.dart';
import '../../bluetooth_v2/bluetooth_v2.dart';

part 'available_devices/view/available_devices_screen.dart';
part 'available_devices/view_model/available_devices_vm.dart';
part 'model/devices_model.dart';
part 'selected_devices/view/selected_devices_screen.dart';
part 'selected_devices/view_model/selected_devices_vm.dart';
part 'view/devices_screen.dart';
part 'viewmodel/devices_vm.dart';
part 'widgets/device_card.dart';
