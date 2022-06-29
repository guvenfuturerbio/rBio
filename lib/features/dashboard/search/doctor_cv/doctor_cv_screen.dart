import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import 'cubit/doctor_cv_cubit.dart';
import 'doctor_cv_response.dart';

class DoctorCvScreen extends StatelessWidget {
  const DoctorCvScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String doctorNameNoTitle;
    late int tenantId;
    late int departmentId;
    late int resourceId;
    late String doctorName;
    late String departmentName;
    late String cvLink;

    try {
      tenantId = int.parse(Atom.queryParameters['tenantId']!);
      doctorNameNoTitle = Atom.queryParameters['doctorNameNoTitle']!;
      departmentId = int.parse(Atom.queryParameters['departmentId']!);
      resourceId = int.parse(Atom.queryParameters['resourceId']!);
      doctorName = Atom.queryParameters['doctorName']!;
      departmentName = Atom.queryParameters['departmentName']!;
      cvLink = Atom.queryParameters['cvLink']!;
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return BlocProvider(
      create: (context) => DoctorCvCubit()..fetchDoctorCv(doctorName: doctorName, cvLink: cvLink),
      child: DoctorCvView(
        doctorNameNoTitle: doctorNameNoTitle,
        tenantId: tenantId,
        departmentId: departmentId,
        resourceId: resourceId,
        doctorName: doctorName,
        departmentName: departmentName,
      ),
    );
  }
}

class DoctorCvView extends StatelessWidget {
  final String doctorNameNoTitle;
  final int tenantId;
  final int departmentId;
  final int resourceId;
  final String doctorName;
  final String departmentName;

  const DoctorCvView({
    Key? key,
    required this.doctorNameNoTitle,
    required this.tenantId,
    required this.departmentId,
    required this.resourceId,
    required this.doctorName,
    required this.departmentName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.of(context).title_doctors_profiles,
        ),
      ),
      body: _buildBody(
        context: context,
        doctorNameNoTitle: doctorNameNoTitle,
        tenantId: tenantId,
        departmentId: departmentId,
        resourceId: resourceId,
        doctorName: doctorName,
        departmentName: departmentName,
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required String doctorNameNoTitle,
    required int tenantId,
    required int departmentId,
    required int resourceId,
    required String doctorName,
    required String departmentName,
  }) {
    return BlocBuilder<DoctorCvCubit, DoctorCvState>(
      builder: (context, state) {
        return state.when(
            initial: () => const SizedBox(),
            success: (result) => result.id == null
                ? RbioEmptyText(
                    title: LocaleProvider.current.empty_cv,
                  )
                : _buildSuccess(
                    context: context,
                    doctorName: doctorName,
                    tenantId: tenantId,
                    departmentName: departmentName,
                    result: result,
                  ),
            loading: () => const RbioLoading(),
            error: (result) => const RbioBodyError());
      },
    );
  }

  Widget _buildSuccess({
    required BuildContext context,
    required String doctorName,
    required int tenantId,
    required String departmentName,
    required DoctorCvResponse result,
  }) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: MediaQuery.of(context).size.width > 800 ? const EdgeInsets.all(64) : const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  context.read<DoctorCvCubit>().imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Utils.instance.customCircleAvatar(
                      size: 120,
                      child: SvgPicture.asset(
                        R.image.doctorAvatar,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  loadingBuilder: (BuildContext context, Widget? child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return Utils.instance.customCircleAvatar(
                        child: Container(
                          child: child,
                        ),
                        size: 120,
                      );
                    }
                    return Stack(
                      alignment: Alignment.center,
                      children: const [
                        RbioLoading(),
                        Center(
                          child: SizedBox(
                            width: 120,
                            height: 120,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),

            //
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                doctorName,
                style: context.xHeadline2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            //
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Text(
                tenantId == 1
                    ? LocaleProvider.current.guven_hospital_ayranci
                    : tenantId == 7
                        ? LocaleProvider.current.guven_cayyolu_campus
                        : LocaleProvider.current.online_hospital,
                style: context.xHeadline3.copyWith(
                  color: getIt<IAppConfig>().theme.grey,
                ),
              ),
            ),

            //
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Text(
                departmentName,
                style: context.xHeadline3.copyWith(
                  color: getIt<IAppConfig>().theme.grey,
                ),
              ),
            ),

            //
            Column(
              children: [
                //
                Visibility(
                  visible: (result.specialties?.length ?? 0) == 0 ? false : true,
                  child: ListTile(
                    title: Text(LocaleProvider.of(context).specialities, style: context.xHeadline3.copyWith(fontWeight: FontWeight.bold)),
                    subtitle: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: result.specialties?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          '-' + result.specialties![index].text!,
                          style: context.xHeadline5,
                        );
                      },
                    ),
                  ),
                ),

                //
                Visibility(
                  visible: (result.treatments?.length ?? 0) == 0 ? false : true,
                  child: ListTile(
                    title: Text(LocaleProvider.of(context).treatments,
                        style: context.xHeadline3.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: result.treatments?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          '-' + result.treatments![index].text!,
                          style: context.xHeadline5,
                        );
                      },
                    ),
                  ),
                ),

                //
                Visibility(
                  visible: (result.experiences?.length ?? 0) == 0 ? false : true,
                  child: ListTile(
                    title: Text(LocaleProvider.of(context).experiences,
                        style: context.xHeadline3.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: result.experiences?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          '-' + result.experiences![index].text!,
                          style: context.xHeadline5,
                        );
                      },
                    ),
                  ),
                ),

                //
                Visibility(
                  visible: (result.educations?.length ?? 0) == 0 ? false : true,
                  child: ListTile(
                    title: Text(LocaleProvider.of(context).educations,
                        style: context.xHeadline3.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: result.educations?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          '-' + result.educations![index].text!,
                          style: context.xHeadline5,
                        );
                      },
                    ),
                  ),
                ),

                //
                Visibility(
                  visible: (result.publications?.length ?? 0) == 0 ? false : true,
                  child: ListTile(
                    title: Text(LocaleProvider.of(context).publications,
                        style: context.xHeadline3.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: result.publications?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          '-' + result.publications![index].text!,
                          style: context.xHeadline5,
                        );
                      },
                    ),
                  ),
                ),

                //
                Visibility(
                  visible: (result.memberships?.length ?? 0) == 0 ? false : true,
                  child: ListTile(
                    title: Text(LocaleProvider.of(context).memberships,
                        style: context.xHeadline3.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: result.memberships?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          '-' + result.memberships![index].text!,
                          style: context.xHeadline5,
                        );
                      },
                    ),
                  ),
                ),

                //
                Visibility(
                  visible: (result.trainings?.length ?? 0) == 0 ? false : true,
                  child: ListTile(
                    title: Text(
                      LocaleProvider.of(context).trainings,
                      style: context.xHeadline3.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: result.trainings?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          '-' + result.trainings![index].text!,
                          style: context.xHeadline5,
                        );
                      },
                    ),
                  ),
                ),

                //
                Visibility(
                  visible: (result.awards?.length ?? 0) == 0 ? false : true,
                  child: ListTile(
                    title: Text(LocaleProvider.of(context).awards,
                        style: context.xHeadline3.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: result.awards?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          '-' + result.awards![index].text!,
                          style: context.xHeadline5,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
