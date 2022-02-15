import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../viewmodel/symptoms_body_sublocations_vm.dart';

class BodySubLocationsPage extends StatefulWidget {
  late GetBodyLocationResponse? selectedBodyLocation;
  late int? selectedGenderId;
  late String? yearOfBirth;
  late bool? isFromVoice;

  BodySubLocationsPage({
    Key? key,
    this.selectedGenderId,
    this.yearOfBirth,
    this.selectedBodyLocation,
    this.isFromVoice,
  }) : super(key: key);

  @override
  _BodySubLocationsPageState createState() => _BodySubLocationsPageState();
}

class _BodySubLocationsPageState extends State<BodySubLocationsPage> {
  @override
  void dispose() {
    try {
      RbioConfig.of(context)?.bodyLocationRsp = null;
    } catch (e) {
      LoggerUtils.instance.i(e);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      widget.selectedBodyLocation = RbioConfig.of(context)?.bodyLocationRsp;
      widget.selectedGenderId =
          int.parse(Atom.queryParameters['selectedGenderId'] as String);
      widget.yearOfBirth = Atom.queryParameters['yearOfBirth'];
      widget.isFromVoice = Atom.queryParameters['isFromVoice'] == 'true';
    } catch (_) {
      return const RbioRouteError();
    }
    return ChangeNotifierProvider(
      create: (context) => BodySublocationsVm(
          context: context,
          bodyLocationId: widget.selectedBodyLocation!.id,
          genderId: widget.selectedGenderId == 0 || widget.selectedGenderId == 2
              ? 0
              : 1,
          isFromVoicePage: widget.isFromVoice,
          selectedBodyLocation: widget.selectedBodyLocation,
          yearOfBirth: widget.yearOfBirth),
      child: Consumer<BodySublocationsVm>(
        builder: (
          BuildContext context,
          BodySublocationsVm value,
          Widget? child,
        ) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                LocaleProvider.of(context).my_symptoms,
              ),
            ),
            body: _buildBody(context, value),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, BodySublocationsVm value) {
    switch (value.progress) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 25, top: 25),
                  child: Text(
                    widget.selectedGenderId == 0
                        ? LocaleProvider.of(context).gender_male
                        : widget.selectedGenderId == 1
                            ? LocaleProvider.of(context).gender_female
                            : widget.selectedGenderId == 2
                                ? LocaleProvider.of(context).boy
                                : LocaleProvider.of(context).girl,
                    style: context.xHeadline3
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 35),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.selectedBodyLocation!.name!,
                      style: context.xHeadline3
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: value.bodySubLocations.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: R.sizes.defaultElevation,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: R.sizes.borderRadiusCircular,
                    ),
                    child: ExpandablePanel(
                      controller: value.expControllerList[index],
                      //iconColor: R.color.online_appointment,
                      header: GestureDetector(
                        onTap: () {
                          value.expControllerList[index].toggle();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 8),
                          child: Text(
                            '${value.bodySubLocations[index]!.name}',
                            style: context.xHeadline3
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      collapsed: ListTile(
                        title: SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                          child: value.symptomControl == LoadingProgress.loading
                              ? const RbioLoading()
                              : ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount:
                                      value.allBodySymptoms[index]!.length,
                                  itemBuilder:
                                      (BuildContext context, int indx) {
                                    return GestureDetector(
                                      onTap: () {
                                        value.addSemptomToList(value
                                            .allBodySymptoms[index]![indx]);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.70,
                                                child: Text(
                                                    value
                                                        .allBodySymptoms[
                                                            index]![indx]
                                                        .name!,
                                                    softWrap: true,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: context.xHeadline3.copyWith(
                                                        color: value
                                                                .selectedSymptoms!
                                                                .contains(value
                                                                            .allBodySymptoms[
                                                                        index]![
                                                                    indx])
                                                            ? getIt<ITheme>()
                                                                .mainColor
                                                            : getIt<ITheme>()
                                                                .textColorSecondary)),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  value.removeSemptomFromList(
                                                      value.allBodySymptoms[
                                                          index]![indx]);
                                                },
                                                child: Visibility(
                                                    visible: value
                                                            .selectedSymptoms!
                                                            .contains(value
                                                                    .allBodySymptoms[
                                                                index]![indx])
                                                        ? true
                                                        : false,
                                                    child: const Icon(
                                                        Icons.close,
                                                        size: 20)),
                                              ),
                                            ],
                                          ),
                                          const Divider()
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                      expanded: Container(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: Atom.safeBottom + 16,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: RbioElevatedButton(
                    onTap: value.selectedSymptoms?.isNotEmpty ?? false
                        ? () async {
                            RbioConfig.of(context)?.bodyLocationRsp =
                                widget.selectedBodyLocation;
                            RbioConfig.of(context)?.listBodySympRsp =
                                value.selectedSymptoms;
                            RbioConfig.of(context)?.sublocationVm = value;
                            Atom.to(
                              PagePaths.symptomSelectPage,
                              queryParameters: {
                                'selectedGenderId':
                                    widget.selectedGenderId.toString(),
                                'yearOfBirth': widget.yearOfBirth!,
                                'isFromVoice': false.toString(),
                              },
                            );
                          }
                        : null,
                    title: LocaleProvider.of(context).continue_lbl),
              ),
            ),
          ],
        );

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }
}
