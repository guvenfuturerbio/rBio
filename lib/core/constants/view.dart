part of 'constants.dart';

class GuvenColors {
  GuvenColors._();

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color green = Color.fromARGB(255, 0, 158, 71);
  static const Color green2 = Color.fromARGB(255, 202, 234, 216);
  static const Color grey = Color.fromARGB(255, 238, 238, 238);
}

class _Sizes {
  EdgeInsets get screenPadding => EdgeInsets.symmetric(
        horizontal: Atom.width * .04,
        vertical: Atom.width * .04,
      );
  final BorderRadiusGeometry borderRadiusCircular = BorderRadius.circular(12);
}

class _Color {
  final gray = Color(0xFF969696);
  final grey = Color(0xFF696969);
  final black = Color(0xFF131313);
  final white = Color(0xFFFFFFFF);
  final dark_black = Color(0xFF000000);
  final blue = Color(0xFFC74852);
  final light_blue = Color(0xFFE18B94);
  final dark_blue = Color(0xFF862634);
  final dark_white = Color(0xFFE5E5E5);
  final online_appointment = Color(0xFF100A9F);
  final light_online_appointment = Color(0xFF648DE5);
  final online_appointment_text = Color(0xFFFFFFFF);
  final ayranci = Color(0xFF63C1B8);
  final light_ayranci = Color(0xFFB7DBD8);
  final ayranci_text = Color(0xFF000000);
  final cayyolu = Color(0xFFFF6F59);
  final light_cayyolu = Color(0xFFF0B7AB);
  final cayyolu_text = Color(0xFFFFFFFF);
  final danisma = Color(0xff65c0b8);
  final danisma_light = Color(0xffafdfdb);
}
