import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../mediminder.dart';

part 'all_reminder_list_cubit.freezed.dart';
part 'all_reminder_list_state.dart';

class AllReminderListCubit extends Cubit<AllReminderListState> {
  AllReminderListCubit() : super(const AllReminderListState.initial());

  FutureOr<void> fetchAll() async {
    emit(const AllReminderListState.loadInProgress());
    await Future.delayed(const Duration(seconds: 2));
    emit(
      AllReminderListState.success(
        AllReminderListResult(
          [
            AllReminderListModel(
              title: "Kan şekeri ölçümü",
              subTitle: "Tok",
              date: "10:00",
              nameAndSurname: "Ahmet Yıldırım",
            ),
            AllReminderListModel(
              title: "Strip",
              subTitle: "",
              date: "10:30",
              nameAndSurname: "Ahmet Yıldırım",
            ),
            AllReminderListModel(
              title: "İlaç Aspirin",
              subTitle: "Manuel",
              date: "10:45",
              nameAndSurname: "Zeynep Yıldırım",
            ),
            AllReminderListModel(
              title: "İlaç Colnar",
              subTitle: "İlaç kutusu",
              date: "11:00",
              nameAndSurname: "Zeynep Yıldırım",
            ),
          ],
        ),
      ),
    );
  }
}
