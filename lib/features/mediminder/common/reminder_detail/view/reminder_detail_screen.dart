import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class ReminderDetailScreen extends StatefulWidget {
  const ReminderDetailScreen({Key? key}) : super(key: key);

  @override
  _ReminderDetailScreenState createState() => _ReminderDetailScreenState();
}

class _ReminderDetailScreenState extends State<ReminderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  RbioAppBar _buildAppBar() => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          "İlaç Aspirin",
        ),
      );

  Widget _buildBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: _buildScrollView(),
          ),

          //
          _buildButtons(),

          //
          R.sizes.defaultBottomPadding,
        ],
      );

  Widget _buildScrollView() {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: getIt<ITheme>().cardBackgroundColor,
              borderRadius: R.sizes.borderRadiusCircular,
            ),
            child: _buildPillar(),
          ),
        ],
      ),
    );
  }

  Widget _buildPillar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        _buildDetailsTitle(),

        //
        _buildTitleRow(
          "Kutu kodu",
          "Durum",
          false,
        ),

        //
        _buildTitleRow(
          "12345",
          "Tok",
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          "Kaç günde bir",
          "Günde alınan",
          false,
        ),

        //
        _buildTitleRow(
          "1",
          "2 kere",
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          "Bir kerede",
          "Kalan ilaç",
          false,
        ),

        //
        _buildTitleRow(
          "1 doz",
          "20 adet",
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          "Bildirim",
          "",
          false,
        ),

        //
        _buildTitleRow(
          "10 adet kaldığında",
          "",
          true,
        ),
      ],
    );
  }

  Widget _buildBloodGlucose() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        _buildDetailsTitle(),

        //
        _buildTitleRow(
          "Etiket",
          "Ne sıklıkla",
          false,
        ),

        //
        _buildTitleRow(
          "Tok",
          "Her gün",
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          "Günde kaç kere",
          "",
          false,
        ),

        //
        _buildTitleRow(
          "2",
          "",
          true,
        ),
      ],
    );
  }

  Widget _buildStrip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        _buildDetailsTitle(),

        //
        _buildTitleRow(
          "Strip sayısı",
          "Kalan adet bildirimi",
          false,
        ),

        //
        _buildTitleRow(
          "200",
          "30",
          true,
        ),
      ],
    );
  }

  Widget _buildHbA1c() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        _buildDetailsTitle(),

        //
        _buildTitleRow(
          "Son test tarihi",
          "Son test değeri",
          false,
        ),

        //
        _buildTitleRow(
          "23/12/2021",
          "4.5%",
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          "Hatırlatılacak gün",
          "Saat",
          false,
        ),

        //
        _buildTitleRow(
          "23/03/2022",
          "10:00",
          true,
        ),
      ],
    );
  }

  Widget _buildMedicationReminders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDetailsTitle(),

        //
        _buildTitleRow(
          LocaleProvider.current.status,
          "Günde alınan",
          false,
        ),

        //
        _buildTitleRow(
          "Aç",
          "2 kere",
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          "Kaç günde bir",
          "Bir kerede",
          false,
        ),

        //
        _buildTitleRow(
          "1",
          "1 doz",
          true,
        ),
      ],
    );
  }

  Widget _buildGap() => R.sizes.hSizer8;

  Widget _buildDetailsTitle() {
    return Column(
      children: [
        //
        Text(
          LocaleProvider.current.details,
          style: context.xHeadline3.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        //
        R.sizes.hSizer8
      ],
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: Column(
        children: [
          //
          RbioElevatedButton(
            onTap: () {},
            title: LocaleProvider.current.edit,
            infinityWidth: true,
            showElevation: false,
            fontWeight: FontWeight.bold,
            textColor: getIt<ITheme>().textColorSecondary,
            backColor: getIt<ITheme>().cardBackgroundColor,
          ),

          //
          R.sizes.hSizer8,

          //
          RbioElevatedButton(
            onTap: () {},
            title: LocaleProvider.current.btn_delete_reminder,
            infinityWidth: true,
            showElevation: false,
            fontWeight: FontWeight.bold,
            textColor: getIt<ITheme>().textColor,
            backColor: R.color.darkRed,
          ),
        ],
      ),
    );
  }

  Widget _buildTitleRow(
    String leftText,
    String rightText,
    bool isActive,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: Text(
            leftText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline4.copyWith(
              color: isActive ? null : getIt<ITheme>().textColorPassive,
            ),
          ),
        ),

        //
        Expanded(
          child: Text(
            rightText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline4.copyWith(
              color: isActive ? null : getIt<ITheme>().textColorPassive,
            ),
          ),
        ),
      ],
    );
  }
}
