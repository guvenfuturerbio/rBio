import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/abstract/app_config.dart';
import '../core.dart';

class ThemeCubit extends Cubit<IAppTheme> {
  ThemeCubit({
    required IAppTheme initialTheme,
    required this.appUtils,
    required this.sharedPreferencesManager,
  }) : super(initialTheme);
  late final IAppUtils appUtils;
  late final ISharedPreferencesManager sharedPreferencesManager;

  Future<void> updateTheme(AppThemeTypes type) async {
    final theme = appUtils.getThemeByType(type);
    emit(theme);
    await sharedPreferencesManager.setString(
      SharedPreferencesKeys.theme,
      type.xRawValue,
    );
  }

  // void toggle() {
  //   final brightness = state.brightness;
  //   updateTheme(
  //     brightness == Brightness.dark
  //         ? AppThemeTypes.oneDoseLight
  //         : AppThemeTypes.oneDoseDark,
  //   );
  // }
}
