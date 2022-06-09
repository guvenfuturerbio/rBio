import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

part 'for_you_categories_state.dart';
part 'for_you_categories_cubit.freezed.dart';

class ForYouCategoriesCubit extends Cubit<ForYouCategoriesState> {
  ForYouCategoriesCubit(this.repository)
      : super(const ForYouCategoriesState.initial());
  late final Repository repository;

  Future<void> fetchCategories() async {
    try {
      emit(const ForYouCategoriesState.loadInProgress());
      final categories = await repository.getAllPackage();
      emit(ForYouCategoriesState.success(categories));
    } catch (e) {
      emit(const ForYouCategoriesState.failure());
    }
  }
}
