import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../model/model.dart';

part 'for_you_categories_cubit.freezed.dart';
part 'for_you_categories_state.dart';

class ForYouCategoriesCubit extends Cubit<ForYouCategoriesState> {
  ForYouCategoriesCubit(this.repository)
      : super(const ForYouCategoriesState.initial());
  late final Repository repository;

  Future<void> fetchCategories() async {
    try {
      emit(const ForYouCategoriesState.loadInProgress());
      final categories = await repository.getAllPackage();
      emit(ForYouCategoriesState.success(categories));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      emit(const ForYouCategoriesState.failure());
    }
  }
}
