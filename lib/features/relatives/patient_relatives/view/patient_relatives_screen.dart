import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../take_appointment/create_appointment/model/patient_relative_info_response.dart';
import '../cubit/patient_relatives_cubit.dart';

class PatientRelativesScreen extends StatelessWidget {
  const PatientRelativesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientRelativesCubit(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      )..fetchPatientReletives(),
      child: const PatientRelativesView(),
    );
  }
}

class PatientRelativesView extends StatefulWidget {
  const PatientRelativesView({Key? key}) : super(key: key);

  @override
  _PatientRelativesViewState createState() => _PatientRelativesViewState();
}

class _PatientRelativesViewState extends State<PatientRelativesView> {
  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        context: context,
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.relatives,
        ),
      ),
      body: _buildBody(),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<PatientRelativesCubit, PatientRelativesState>(
        listener: (BuildContext context, PatientRelativesState state) {
      state.when(
        initial: () {},
        loadInProgress: () {},
        success: (PatientRelativeInfoResponse value) {},
        failure: () {
          Utils.instance.showErrorSnackbar(
              context, LocaleProvider.of(context).something_went_wrong);
        },
      );
    }, builder: (BuildContext context, PatientRelativesState state) {
      return state.when(
        initial: () => const SizedBox(),
        loadInProgress: () => const RbioLoading(),
        success: (PatientRelativeInfoResponse response) => ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: response.patientRelatives.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                _PatientRelativeListTile(
                  patientRelative: response.patientRelatives[index],
                ),

                //
                _buildVerticalGap(),
              ],
            );
          },
        ),
        failure: () => const RbioBodyError(),
      );
    });
  }

  Widget _buildFab() {
    return RbioSVGFAB.primaryColor(
      context,
      imagePath: R.image.add,
      onPressed: () {
        Atom.to(PagePaths.addPatientRelatives);
      },
    );
  }

  Widget _buildVerticalGap() => SizedBox(height: Atom.height * 0.015);
}

class _PatientRelativeListTile extends StatelessWidget {
  const _PatientRelativeListTile({
    Key? key,
    required this.patientRelative,
  }) : super(key: key);

  final PatientRelative patientRelative;

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
              Text('${patientRelative.name} ${patientRelative.surname}',
                  style: context.xTextTheme.headline3),
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
                  Navigator.pop(context);
                  context
                      .read<PatientRelativesCubit>()
                      .changeUserToPatientRelative(patientRelative);
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
              context,
              LocaleProvider.of(context).btn_cancel,
              () {
                Navigator.of(context).pop();
              },
            ),

            //
            GuvenAlert.buildMaterialAction(
              context,
              okButtonText,
              okButtonFunc,
            ),
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
