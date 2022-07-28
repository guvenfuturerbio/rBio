enum Durations {
  low(Duration(milliseconds: 500)),
  normal(Duration(seconds: 1)),
  high(Duration(seconds: 2));

  final Duration value;
  const Durations(this.value);
}
