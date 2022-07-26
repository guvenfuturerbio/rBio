import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/core.dart';

class SelectReminderScreen extends StatelessWidget {
  const SelectReminderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      context: context,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.create_reminder,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: 2,
      children: _getList(context),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio:
          context.xTextScaleType == TextScaleType.small ? 0.8 : 0.7,
    );
  }

  List<Widget> _getList(BuildContext context) {
    return [
      _buildCard(
        context,
        R.image.reminderBloodGlucose,
        Remindable.bloodGlucose,
        onTap: () {
          Atom.to(
            PagePaths.bloodGlucoseReminderAddEdit,
            isReplacement: true,
          );
        },
      ),
      _buildCard(
        context,
        R.image.reminderStrip,
        Remindable.strip,
        onTap: () {
          Atom.to(
            PagePaths.strip,
            isReplacement: true,
          );
        },
      ),
      _buildCard(
        context,
        R.image.reminderMedication,
        Remindable.medication,
        onTap: () {
          Atom.to(
            PagePaths.medicationReminderAddEdit,
            isReplacement: true,
          );
        },
      ),
      _buildCard(
        context,
        R.image.reminderHba1c,
        Remindable.hbA1c,
        onTap: () {
          Atom.to(
            PagePaths.hba1cReminderAddEdit,
            isReplacement: true,
          );
        },
      ),
    ];
  }

  Widget _buildCard(
    BuildContext context,
    String icon,
    Remindable remindable, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              //
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  icon,
                  width: Atom.height * 0.065,
                  height: Atom.height * 0.065,
                ),
              ),

              //
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  remindable.toShortTitle(),
                  maxLines: 5,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: context.xCurrentTheme.textTheme.headline4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
