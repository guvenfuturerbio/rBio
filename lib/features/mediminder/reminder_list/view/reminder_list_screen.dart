import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../../../app/bluetooth_v2/bluetooth_v2.dart';
import '../../../../../core/core.dart';
import '../../../../core/utils/helper/tz_helper.dart';
import '../../mediminder.dart';

part 'widget/filter_dialog.dart';
part 'widget/reminder_card.dart';
part 'widget/reminder_detail_dialog.dart';

class ReminderListScreen extends StatelessWidget {
  const ReminderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReminderListCubit>(
      create: (ctx) => ReminderListCubit(getIt())..fetchAll(),
      child: _ReminderListView(),
    );
  }
}

class _ReminderListView extends StatelessWidget {
  final currentTime = TZHelper.instance.now();

  _ReminderListView({Key? key}) : super(key: key);

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
      context: context,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.reminders,
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ReminderListCubit, ReminderListState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loadInProgress: () => const RbioLoading(),
          success: (result) => _buildList(context, result.filterList),
          failure: () => const RbioBodyError(),
        );
      },
    );
  }

  Widget _buildFAB(BuildContext context) {
    return RbioSVGFAB.primaryColor(
      context,
      imagePath: R.image.add,
      onPressed: () {
        Atom.to(PagePaths.selectReminder);
      },
    );
  }

  Widget _buildList(BuildContext context, List<ReminderListModel> list) {
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
              Atom.show(
                BlocProvider.value(
                  value: context.read<ReminderListCubit>(),
                  child: const FilterDialog(),
                ),
              );
            },
            title: LocaleProvider.current.filter,
            backColor: getIt<IAppConfig>().theme.cardBackgroundColor,
            textColor: getIt<IAppConfig>().theme.textColorSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),

        //
        R.widgets.hSizer8,

        //
        list.isEmpty
            ? RbioEmptyText(
                title: LocaleProvider.current.there_are_no_reminders,
              )
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    bottom: R.sizes.defaultBottomValue,
                  ),
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ReminderCard(
                      currentTime: currentTime,
                      model: list[index],
                    );
                  },
                ),
              ),
      ],
    );
  }
}
