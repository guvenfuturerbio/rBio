part of 'date_range_picker.dart';

enum _SelectionState { focused, unFocused }

class DateRangePickerVm extends ChangeNotifier {
  DateRangePickerVm(
      {required this.context, required this.selected, required this.items}) {
    if (selected != TimePeriodFilter.daily) {
      focusType = _SelectionState.focused;
    }
  }
  final BuildContext context;
  final List<TimePeriodFilter> items;
  _SelectionState focusType = _SelectionState.unFocused;

  final TimePeriodFilter selected;
  changeFocusedType() {
    switch (focusType) {
      case _SelectionState.focused:
        focusType = _SelectionState.unFocused;
        break;
      case _SelectionState.unFocused:
        focusType = _SelectionState.focused;

        break;
    }
    notifyListeners();
  }
}
