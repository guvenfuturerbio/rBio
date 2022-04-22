class ScaleConstants {
  static const bMHRanges = [1305.0];
  static const bMHMinimum = 0.0;
  static const bMHMaximum = 3000.0;

  static List<double> bodyFatRanges(int gender) =>
      gender == 1 ? [10.0, 20.0, 25.0] : [20.0, 30.0, 35.0];
  static double bodyFatMinimum(int gender) => gender == 1 ? 5.0 : 15.0;
  static double bodyFatMaximum(int gender) => gender == 1 ? 30.0 : 40.0;

  static const bMIRanges = [18.5, 24.9, 29.9, 34.9];
  static const bMIMinimum = 15.0;
  static const bMIMaximum = 40.0;

  static List<double> muscleRanges(int gender) =>
      gender == 1 ? [32.8, 35.7, 37.3] : [25.8, 27.9, 29.0];
  static double muscleMinimum(int gender) => gender == 1 ? 30.0 : 23.0;
  static double muscleMaximum(int gender) => gender == 1 ? 40.0 : 32.0;

  static List<double> waterRanges(int gender) =>
      gender == 1 ? [50.0, 65.0] : [45.0, 60.0];
  static double waterMinimum(int gender) => gender == 1 ? 40.0 : 35.0;
  static double waterMaximum(int gender) => gender == 1 ? 75.0 : 70.0;

  static const visceralFatRanges = [10.0, 15.0];
  static const visceralFatMinimum = 2.0;
  static const visceralFatMaximum = 23.0;

  static const boneMassRanges = [1.8, 3.9];
  static const boneMassMinimum = 0.0;
  static const boneMassMaximum = 5.0;
}
