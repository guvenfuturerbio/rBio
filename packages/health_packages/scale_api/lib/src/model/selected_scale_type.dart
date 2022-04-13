enum SelectedScaleType {
  bodyFat,
  bmi,
  muscle,
  water,
  visceralFat,
  boneMass,
  weight,
  bmh,
}

const kBMHRanges = [1305.0];
const kBMHMinimum = 0.0;
const kBMHMaximum = 3000.0;

List<double> kBodyFatRanges(int gender) =>
    gender == 1 ? [10.0, 20.0, 25.0] : [20.0, 30.0, 35.0];
double kBodyFatMinimum(int gender) => gender == 1 ? 5.0 : 15.0;
double kBodyFatMaximum(int gender) => gender == 1 ? 30.0 : 40.0;

const kBMIRanges = [18.5, 24.9, 29.9, 34.9];
const kBMIMinimum = 15.0;
const kBMIMaximum = 40.0;

List<double> kMuscleRanges(int gender) =>
    gender == 1 ? [32.8, 35.7, 37.3] : [25.8, 27.9, 29.0];
double kMuscleMinimum(int gender) => gender == 1 ? 30.0 : 23.0;
double kMuscleMaximum(int gender) => gender == 1 ? 40.0 : 32.0;

List<double> kWaterRanges(int gender) =>
    gender == 1 ? [50.0, 65.0] : [45.0, 60.0];
double kWaterMinimum(int gender) => gender == 1 ? 40.0 : 35.0;
double kWaterMaximum(int gender) => gender == 1 ? 75.0 : 70.0;

const kVisceralFatRanges = [10.0, 15.0];
const kVisceralFatMinimum = 2.0;
const kVisceralFatMaximum = 23.0;

const kBoneMassRanges = [1.8, 3.9];
const kBoneMassMinimum = 0.0;
const kBoneMassMaximum = 5.0;
