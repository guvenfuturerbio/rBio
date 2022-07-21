import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../app/bluetooth_v2/bluetooth_v2.dart';
import '../cubit/for_you_categories_cubit.dart';

class ForYouCategoriesScreen extends StatelessWidget {
  const ForYouCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForYouCategoriesCubit(getIt())..fetchCategories(),
      child: const ForYouCategoriesView(),
    );
  }
}

class ForYouCategoriesView extends StatelessWidget {
  const ForYouCategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioStackedScaffold(
      appbar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      context: context,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).for_you,
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ForYouCategoriesCubit, ForYouCategoriesState>(
      builder: (context, state) {
        return state.when(
            initial: () => const SizedBox(),
            loadInProgress: () => const RbioLoading(),
            success: (list) => GridView.builder(
                  padding: EdgeInsets.only(
                    top: R.sizes.stackedTopPaddingValue(context) + 8,
                  ),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width < 800
                        ? MediaQuery.of(context).size.width * 0.45
                        : MediaQuery.of(context).size.width * 0.33,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 25,
                  ),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = list[index];

                    return RbioForYouCategoryCard(
                      title: item.text,
                      id: item.id,
                      icon: item.icon != null
                          ? Image.memory(base64Decode(item.icon ?? ''))
                          : Image.asset(R.image.covidCat),
                      onTap: () {
                        getIt<IAppConfig>()
                            .platform
                            .adjustManager
                            ?.trackEvent(ForYouCategoryClickedEvent());
                        getIt<FirebaseAnalyticsManager>().logEvent(
                          SizeOzelKategoriTiklandiEvent(
                            item.text ?? '',
                          ),
                        );

                        Atom.to(
                          PagePaths.forYouSubCategories,
                          queryParameters: {
                            'title': item.text != null
                                ? Uri.encodeFull(item.text!)
                                : "No title",
                            'categoryId': item.id.toString(),
                          },
                        );
                      },
                    );
                  },
                ),
            failure: () => const RbioBodyError());
      },
    );
  }
}
