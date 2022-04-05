import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../../core/core.dart';
import '../../../../core/utils/tz_helper.dart';
import '../../mediminder.dart';

part 'medication_reminder_add_edit_state.dart';
part 'medication_reminder_add_edit_cubit.freezed.dart';

class MedicationReminderAddEditCubit extends Cubit<MedicationReminderAddEditState> {
  MedicationReminderAddEditCubit() : super(MedicationReminderAddEditState.initial());
}
