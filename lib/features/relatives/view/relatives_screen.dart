// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/relatives_vm.dart';

class RelativesScreen extends StatefulWidget {
  const RelativesScreen({Key? key}) : super(key: key);

  @override
  _RelativesScreenState createState() => _RelativesScreenState();
}

class _RelativesScreenState extends State<RelativesScreen> {
  @override
  void initState() {
    super.initState();
    final widgetsBinding = WidgetsBinding.instance;
    if (widgetsBinding != null) {
      widgetsBinding.addPostFrameCallback(
        (_) {
          Provider.of<RelativesVm>(context, listen: false).getAll();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.relatives,
        ),
      ),
      body: Consumer<RelativesVm>(
        builder: (
          BuildContext context,
          RelativesVm value,
          Widget? child,
        ) {
          return _buildBody(value);
        },
      ),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildBody(RelativesVm vm) {
    switch (vm.state) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: vm.response.patientRelatives.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                _PatientRelativeListTile(
                  name:
                      '${vm.response.patientRelatives[index].name} ${vm.response.patientRelatives[index].surname}',
                ),

                //
                _buildVerticalGap(),
              ],
            );
          },
        );

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }

  Widget _buildFab() {
    return FloatingActionButton(
      backgroundColor: getIt<IAppConfig>().theme.mainColor,
      onPressed: () {
        Atom.to(PagePaths.addPatientRelatives);
      },
      child: Center(
        child: SvgPicture.asset(
          R.image.add,
          width: R.sizes.iconSize2,
        ),
      ),
    );
  }

  Widget _buildVerticalGap() => SizedBox(height: Atom.height * 0.015);
}

class _PatientRelativeListTile extends StatelessWidget {
  const _PatientRelativeListTile({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: context.xTextTheme.headline3),
              GestureDetector(
                onTap: () => showConfirmationAlertDialog(
                  context,
                  LocaleProvider.of(context).delete_relative_title,
                  LocaleProvider.of(context).delete_relative_confirm_message,
                  LocaleProvider.of(context).Ok,
                  () {
                    // vm.deleteRelative(patientRelative, context);
                  },
                ),
                child: SvgPicture.asset(
                  R.image.icDeleteRed,
                  width: R.sizes.iconSize3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          RbioElevatedButton(
            title: 'Geçiş Yap',
            onTap: () {
              showConfirmationAlertDialog(
                context,
                LocaleProvider.of(context).warning,
                LocaleProvider.of(context).relative_change_message,
                LocaleProvider.of(context).Ok,
                () {
                  // vm.changeUserToRelative(patientRelative, context);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void showConfirmationAlertDialog(
    BuildContext context,
    String title,
    String text,
    String okButtonText,
    void Function() okButtonFunc,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GuvenAlert(
          backgroundColor: Colors.white,
          title: GuvenAlert.buildTitle(title),
          actions: [
            GuvenAlert.buildMaterialAction(
              LocaleProvider.of(context).btn_cancel,
              () {
                Navigator.of(context).pop();
              },
            ),

            //
            GuvenAlert.buildMaterialAction(okButtonText, okButtonFunc),
          ],

          //
          content: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GuvenAlert.buildDescription(text),
              ],
            ),
          ),
        );
      },
    );
  }
}
