import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../../../app/bluetooth_v2/bluetooth_v2.dart';
import '../../../../../core/core.dart';
import '../../../../../core/utils/tz_helper.dart';
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
    return FloatingActionButton(
      backgroundColor: getIt<IAppConfig>().theme.mainColor,
      onPressed: () {
        Atom.to(PagePaths.selectReminder);
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          R.image.add,
          color: getIt<IAppConfig>().theme.white,
        ),
      ),
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
            showElevation: false,
            backColor: getIt<IAppConfig>().theme.cardBackgroundColor,
            textColor: getIt<IAppConfig>().theme.textColorSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),

        //
        R.sizes.hSizer8,

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
