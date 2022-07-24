import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../for_you_categories/model/for_you_category_response.dart';

part 'for_you_sub_categories_cubit.freezed.dart';
part 'for_you_sub_categories_state.dart';

class ForYouSubCategoriesCubit extends Cubit<ForYouSubCategoriesState> {
  ForYouSubCategoriesCubit(this.repository)
      : super(const ForYouSubCategoriesState.initial());
  late final Repository repository;

  Future<void> fetchCategories(int id) async {
    try {
      emit(const ForYouSubCategoriesState.loadInProgress());
      final categories = await repository.getAllSubCategories(id);
      emit(ForYouSubCategoriesState.success(categories));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      emit(const ForYouSubCategoriesState.failure());
    }
  }
}
