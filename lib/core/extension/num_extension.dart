extension DoubleExtensions on double {
  String get xGetFriendyString => toStringAsFixed(2).replaceAll(".", ",");
}
