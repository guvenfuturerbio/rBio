import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../model/for_you_sub_category_detail_response.dart';

part 'for_you_sub_category_detail_cubit.freezed.dart';
part 'for_you_sub_category_detail_state.dart';

class ForYouSubCategoryDetailCubit extends Cubit<ForYouSubCategoryDetailState> {
  ForYouSubCategoryDetailCubit(this.repository)
      : super(const ForYouSubCategoryDetailState.initial());
  late final Repository repository;

  Future<void> fetchSubCategoryDetail(var id) async {
    try {
      emit(const ForYouSubCategoryDetailState.loadInProgress());
      List<ForYouSubCategoryDetailResponse> subCategoryDetail =
          await repository.getSubCategoryDetail(id);
      emit(ForYouSubCategoryDetailState.success(subCategoryDetail));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      emit(const ForYouSubCategoryDetailState.failure());
    }
  }
}
