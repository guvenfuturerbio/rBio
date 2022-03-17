class ScaleCalculate {
  ScaleCalculate._();

  static ScaleCalculate? _instance;

  static ScaleCalculate get instance {
    _instance ??= ScaleCalculate._();
    return _instance!;
  }

  double getBMI({
    required double weight,
    required int height,
  }) =>
      weight / (((height * height) / 100.0) / 100.0);

  double getWater({
    required double weight,
    required int height,
    required int age,
    required int gender,
    required int impedance,
  }) {
    late double coeff;
    var water =
        (100.0 - getBodyFat(weight, height, age, gender, impedance)) * 0.7;

    if (water < 50) {
      coeff = 1.02;
    } else {
      coeff = 0.98;
    }

    return coeff * water;
  }

  double getBodyFat(
    double weight,
    int height,
    int age,
    int gender,
    int impedance,
  ) {
    double bodyFat = 0.0;
    double lbmSub = 0.8;
    if (gender == 0 && age <= 49) {
      lbmSub = 9.25;
    } else if (gender == 0 && age > 49) {
      lbmSub = 7.25;
    }
    double lbmCoeff = getLBMCoefficient(weight, height, age, impedance);
    double coeff = 1.0;
    if (gender == 1 && weight < 61.0) {
      coeff = 0.98;
    } else if (gender == 0 && weight > 60.0) {
      coeff = 0.96;

      if (height > 160) {
        coeff *= 1.03;
      }
    } else if (gender == 0 && weight < 50.0) {
      coeff = 1.02;

      if (height > 160) {
        coeff *= 1.03;
      }
    }

    bodyFat = (1.0 - (((lbmCoeff - lbmSub) * coeff) / weight)) * 100.0;

    if (bodyFat > 63.0) {
      bodyFat = 75.0;
    }

    return bodyFat;
  }

  double getLBMCoefficient(
    double weight,
    int height,
    int age,
    int impedance,
  ) {
    double lbm = (height * 9.058 / 100.0) * (height / 100.0);
    lbm += weight * 0.32 + 12.226;
    lbm -= impedance * 0.0068;
    lbm -= age * 0.0542;
    return lbm;
  }

  double getVisceralFat({
    required double weight,
    required int height,
    required int age,
    required int gender,
    required int impedance,
  }) {
    double visceralFat = 0.0;
    if (gender == 0) {
      if (weight > (13.0 - (height * 0.5)) * -1.0) {
        double subsubcalc =
            ((height * 1.45) + (height * 0.1158) * height) - 120.0;
        double subcalc = weight * 500.0 / subsubcalc;
        visceralFat = (subcalc - 6.0) + (age * 0.07);
      } else {
        double subcalc = 0.691 + (height * -0.0024) + (height * -0.0024);
        visceralFat = (((height * 0.027) - (subcalc * weight)) * -1.0) +
            (age * 0.07) -
            age;
      }
    } else {
      if (height < weight * 1.6) {
        double subcalc = ((height * 0.4) - (height * (height * 0.0826))) * -1.0;
        visceralFat =
            ((weight * 305.0) / (subcalc + 48.0)) - 2.9 + (age * 0.15);
      } else {
        double subcalc = 0.765 + height * -0.0015;
        visceralFat = (((height * 0.143) - (weight * subcalc)) * -1.0) +
            (age * 0.15) -
            5.0;
      }
    }

    return visceralFat;
  }

  double getBoneMass(
    int gender,
    double weight,
    int height,
    int age,
    int impedance,
  ) {
    double boneMass;
    double base;
    if (gender == 0) {
      base = 0.245691014;
    } else {
      base = 0.18016894;
    }

    boneMass =
        (base - (getLBMCoefficient(weight, height, age, impedance) * 0.05158)) *
            -1.0;

    if (boneMass > 2.2) {
      boneMass += 0.1;
    } else {
      boneMass -= 0.1;
    }

    if (gender == 0 && boneMass > 5.1) {
      boneMass = 8.0;
    } else if (gender == 1 && boneMass > 5.2) {
      boneMass = 8.0;
    }

    return boneMass;
  }

  double getMuscle(
    int gender,
    double weight,
    int height,
    int age,
    int impedance,
  ) {
    double muscleMass = weight -
        ((getBodyFat(weight, height, age, gender, impedance) * 0.01) * weight) -
        getBoneMass(gender, weight, height, age, impedance);

    if (gender == 0 && muscleMass >= 84.0) {
      muscleMass = 120.0;
    } else if (gender == 1 && muscleMass >= 93.5) {
      muscleMass = 120.0;
    }

    return muscleMass;
  }

  double getBMH({
    required int gender,
    required double weight,
    required int height,
    required int age,
  }) {
    if (gender == 0) {
      return 66.5 + (13.75 * weight) + (5.03 * height) - (6.75 * age);
    } else {
      return 655.1 + (9.56 * weight) + (1.85 * height) - (4.68 * age);
    }
  }
}
