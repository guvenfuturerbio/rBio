import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/model/ble_models/paired_device.dart';
import 'package:provider/provider.dart';
import 'package:reactive_ble_platform_interface/src/model/discovered_device.dart';

import '../../../core/core.dart';
import '../../../model/ble_models/DeviceTypes.dart';

part 'available_devices/view/available_devices_screen.dart';
part 'available_devices/view_model/available_devices_vm.dart';
part 'model/devices_model.dart';
part 'selected_devices/view/selected_devices_screen.dart';
part 'selected_devices/view_model/selected_devices_vm.dart';
part 'view/devices_screen.dart';
part 'viewmodel/devices_vm.dart';
part 'utils/device_card.dart';
