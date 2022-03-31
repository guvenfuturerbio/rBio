import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../app/bluetooth_v2/bluetooth_v2.dart';
import '../../../../../core/core.dart';
import '../../../mediminder.dart';

part 'widget/filter_dialog.dart';
part 'widget/reminder_alert_dialog.dart';
part 'widget/reminder_detail_dialog.dart';

class AllReminderListScreen extends StatelessWidget {
  const AllReminderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllReminderListCubit>(
      create: (ctx) => AllReminderListCubit()..fetchAll(),
      child: const AllReminderListView(),
    );
  }
}

class AllReminderListView extends StatefulWidget {
  const AllReminderListView({Key? key}) : super(key: key);

  @override
  _AllReminderListViewState createState() => _AllReminderListViewState();
}

class _AllReminderListViewState extends State<AllReminderListView> {
  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFAB(context),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.reminders,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            R.image.relatives,
            color: Colors.white,
            width: 50,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AllReminderListCubit, AllReminderListState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loadInProgress: () => const RbioLoading(),
          success: (result) => _buildList(result),
          failure: () => const RbioBodyError(),
        );
      },
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: getIt<ITheme>().mainColor,
      onPressed: () {
        Atom.to(PagePaths.selectReminder);
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          R.image.add,
          color: R.color.white,
        ),
      ),
    );
  }

  Widget _buildList(AllReminderListResult result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Align(
          alignment: Alignment.centerRight,
          child: RbioElevatedButton(
            onTap: () {
              Atom.show(const FilterDialog());
            },
            title: LocaleProvider.current.filter,
            showElevation: false,
            backColor: getIt<ITheme>().cardBackgroundColor,
            textColor: getIt<ITheme>().textColorSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),

        //
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(
              bottom: R.sizes.defaultBottomValue,
            ),
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: result.list.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildCard(context, result.list[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context,
    AllReminderListModel model,
  ) {
    return GestureDetector(
      onTap: () {
        Atom.show(
          ReminderAlertDialog(
            model: model,
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: getIt<ITheme>().mainColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  Expanded(
                    child: Text(
                      model.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.xHeadline4.copyWith(
                        color: getIt<ITheme>().textColor,
                      ),
                    ),
                  ),

                  //
                  Text(
                    model.subTitle ?? '',
                    style: context.xHeadline4.copyWith(
                      color: getIt<ITheme>().textColor,
                    ),
                  ),
                ],
              ),
            ),

            //
            Container(
              decoration: BoxDecoration(
                color: getIt<ITheme>().cardBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        left: 12,
                      ),
                      child: Text(
                        "30dk",
                        style: context.xHeadline3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: getIt<ITheme>().mainColor,
                        ),
                      ),
                    ),
                  ),

                  //
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        right: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //
                          Text(
                            model.date ?? '',
                            style: context.xHeadline4.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          //
                          R.sizes.hSizer8,

                          //
                          Text(
                            model.nameAndSurname ?? '',
                            style: context.xHeadline4.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
