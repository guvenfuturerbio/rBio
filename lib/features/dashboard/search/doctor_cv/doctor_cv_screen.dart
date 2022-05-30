import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import 'cubit/doctor_cv_cubit.dart';

class DoctorCvScreen extends StatefulWidget {
  late String doctorNameNoTitle;
  late int tenantId;
  late int departmentId;
  late int resourceId;
  late String doctorName;
  late String departmentName;

  DoctorCvScreen({Key? key}) : super(key: key);

  @override
  _DoctorCvScreenState createState() => _DoctorCvScreenState();
}

class _DoctorCvScreenState extends State<DoctorCvScreen> {
  @override
  Widget build(BuildContext context) {
    try {
      widget.tenantId = int.parse(Atom.queryParameters['tenantId']!);
      widget.doctorNameNoTitle = Atom.queryParameters['doctorNameNoTitle']!;
      widget.departmentId = int.parse(Atom.queryParameters['departmentId']!);
      widget.resourceId = int.parse(Atom.queryParameters['resourceId']!);
      widget.doctorName = Atom.queryParameters['doctorName']!;
      widget.departmentName = Atom.queryParameters['departmentName']!;
    } catch (e) {
      return const RbioRouteError();
    }

    return BlocProvider(
        create: (context) => DoctorCvCubit()..fetchDoctorCv(widget.doctorName),
        child: RbioScaffold(
          appbar: RbioAppBar(
            title: RbioAppBar.textTitle(
              context,
              LocaleProvider.of(context).title_doctors_profiles,
            ),
          ),
          body: _buildBody(
            context,
          ),
        ));
  }

  Widget _buildBody(
    BuildContext context,
  ) {
    return BlocBuilder<DoctorCvCubit, DoctorCvState>(
      builder: (context, state) {
        return state.when(
            initial: () => const SizedBox(),
            success: (result) => SingleChildScrollView(
                  child: Container(
                    padding: MediaQuery.of(context).size.width > 800
                        ? const EdgeInsets.all(64)
                        : const EdgeInsets.only(top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (context.read<DoctorCvCubit>().progress ==
                                LoadingProgress.done)
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
                                loadingBuilder: (BuildContext context,
                                    Widget? child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return Utils.instance.customCircleAvatar(
                                        child: Container(
                                          child: child,
                                        ),
                                        size: 120);
                                  }
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: const [
                                      RbioLoading(),
                                      Center(
                                          child: SizedBox(
                                        width: 120,
                                        height: 120,
                                      ))
                                    ],
                                  );
                                },
                              )
                            else
                              Utils.instance.customCircleAvatar(
                                size: 120,
                                child: SvgPicture.asset(
                                  R.image.doctorAvatar,
                                  fit: BoxFit.fill,
                                ),
                              ),
                          ],
                        ),

                        //
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            widget.doctorName,
                            style: context.xHeadline2.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        //
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          child: Text(
                              widget.tenantId == 1
                                  ? LocaleProvider
                                      .current.guven_hospital_ayranci
                                  : widget.tenantId == 7
                                      ? LocaleProvider
                                          .current.guven_cayyolu_campus
                                      : LocaleProvider.current.online_hospital,
                              style: context.xHeadline3.copyWith(
                                  color: getIt<IAppConfig>().theme.grey)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          child: Text(widget.departmentName,
                              style: context.xHeadline3.copyWith(
                                  color: getIt<IAppConfig>().theme.grey)),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(top: 20, bottom: 20),
                        //   child: Utils.instance.button(
                        //     width: 260,
                        //     text: LocaleProvider.of(context)
                        //         .make_an_appointment
                        //         .toUpperCase(),
                        //     onPressed: () {
                        //       Atom.to(
                        //         PagePaths.createAppointment,
                        //         queryParameters: {
                        //           'fromOnline': 'false',
                        //           'fromSearch': 'true',
                        //           'departmentId':
                        //               widget.departmentId.toString(),
                        //           'resourceId': widget.resourceId.toString(),
                        //           'tenantId': widget.tenantId.toString(),
                        //         },
                        //       );
                        //     },
                        //   ),
                        // ),
                        context.read<DoctorCvCubit>().progress ==
                                LoadingProgress.done
                            ? Column(
                                children: [
                                  Visibility(
                                    visible:
                                        (result.specialties?.length ?? 0) == 0
                                            ? false
                                            : true,
                                    child: ListTile(
                                      title: Text(
                                          LocaleProvider.of(context)
                                              .specialities,
                                          style: context.xHeadline3.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            result.specialties?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Text(
                                              '-' +
                                                  result.specialties![index]
                                                      .text!,
                                              style: context.xHeadline5);
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        (result.treatments?.length ?? 0) == 0
                                            ? false
                                            : true,
                                    child: ListTile(
                                      title: Text(
                                          LocaleProvider.of(context).treatments,
                                          style: context.xHeadline3.copyWith(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      subtitle: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            result.treatments?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Text(
                                              '-' +
                                                  result
                                                      .treatments![index].text!,
                                              style: context.xHeadline5);
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        (result.experiences?.length ?? 0) == 0
                                            ? false
                                            : true,
                                    child: ListTile(
                                      title: Text(
                                          LocaleProvider.of(context)
                                              .experiences,
                                          style: context.xHeadline3.copyWith(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      subtitle: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            result.experiences?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Text(
                                              '-' +
                                                  result.experiences![index]
                                                      .text!,
                                              style: context.xHeadline5);
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        (result.educations?.length ?? 0) == 0
                                            ? false
                                            : true,
                                    child: ListTile(
                                      title: Text(
                                          LocaleProvider.of(context).educations,
                                          style: context.xHeadline3.copyWith(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      subtitle: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            result.educations?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Text(
                                              '-' +
                                                  result
                                                      .educations![index].text!,
                                              style: context.xHeadline5);
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        (result.publications?.length ?? 0) == 0
                                            ? false
                                            : true,
                                    child: ListTile(
                                      title: Text(
                                          LocaleProvider.of(context)
                                              .publications,
                                          style: context.xHeadline3.copyWith(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      subtitle: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            result.publications?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Text(
                                              '-' +
                                                  result.publications![index]
                                                      .text!,
                                              style: context.xHeadline5);
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        (result.memberships?.length ?? 0) == 0
                                            ? false
                                            : true,
                                    child: ListTile(
                                      title: Text(
                                          LocaleProvider.of(context)
                                              .memberships,
                                          style: context.xHeadline3.copyWith(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      subtitle: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            result.memberships?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Text(
                                              '-' +
                                                  result.memberships![index]
                                                      .text!,
                                              style: context.xHeadline5);
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        (result.trainings?.length ?? 0) == 0
                                            ? false
                                            : true,
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
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            result.trainings?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Text(
                                              '-' +
                                                  result
                                                      .trainings![index].text!,
                                              style: context.xHeadline5);
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: (result.awards?.length ?? 0) == 0
                                        ? false
                                        : true,
                                    child: ListTile(
                                      title: Text(
                                          LocaleProvider.of(context).awards,
                                          style: context.xHeadline3.copyWith(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      subtitle: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: result.awards?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Text(
                                              '-' + result.awards![index].text!,
                                              style: context.xHeadline5);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : context.read<DoctorCvCubit>().progress ==
                                    LoadingProgress.loading
                                ? const RbioLoading()
                                : Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 20, left: 20, right: 20),
                                    child: Text(
                                        widget.doctorName +
                                            " " +
                                            LocaleProvider.of(context)
                                                .doctor_cv_not_uploaded,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.3,
                                        style: context.xHeadline5),
                                  ),
                      ],
                    ),
                  ),
                ),
            loading: () => const RbioLoading(),
            error: (result) => result == null
                ? RbioEmptyText(
                    title: LocaleProvider.current.empty_cv,
                  )
                : const RbioBodyError());
      },
    );
  }
}
