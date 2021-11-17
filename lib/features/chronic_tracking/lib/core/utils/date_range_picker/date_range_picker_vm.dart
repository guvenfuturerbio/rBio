part of 'date_range_picker.dart';

enum _SelectionState { FOCUSED, UN_FOCUSED }

class DateRangePickerVm extends ChangeNotifier {
  DateRangePickerVm({this.context, this.selected, this.items}) {
    if (selected != TimePeriodFilter.DAILY) {
      focusType = _SelectionState.FOCUSED;
    }
  }
  final BuildContext context;
  final List<TimePeriodFilter> items;
  _SelectionState focusType = _SelectionState.UN_FOCUSED;

  final TimePeriodFilter selected;
  changeFocusedType() {
    switch (focusType) {
      case _SelectionState.FOCUSED:
        focusType = _SelectionState.UN_FOCUSED;
        break;
      case _SelectionState.UN_FOCUSED:
        focusType = _SelectionState.FOCUSED;

        break;
    }
    notifyListeners();
  }
}
