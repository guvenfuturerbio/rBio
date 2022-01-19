import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/features/doctor/notifiers/patient_notifiers.dart';
import 'package:onedosehealth/model/treatment_model/treatment_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';

part '../model/treatment_process_model.dart';

class DoctorTreatmentProcessScreen extends StatefulWidget {
  DoctorTreatmentProcessScreen({Key key}) : super(key: key);

  @override
  _DoctorTreatmentProcessScreenState createState() =>
      _DoctorTreatmentProcessScreenState();
}

class _DoctorTreatmentProcessScreenState
    extends State<DoctorTreatmentProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return RbioScaffold(appbar: _buildAppBar(), body: _buildBody());
  }

  RbioAppBar _buildAppBar() => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.treatment_process,
        ),
        actions: [
          Center(
            child: RbioBadge(
              image: R.image.chat_icon,
              isDark: false,
              onTap: () {
                Atom.to(PagePaths.DOCTOR_CONSULTATION);
              },
            ),
          ),
          SizedBox(
            width: 12,
          ),
        ],
      );

  Widget _buildBody() {
    return _buildSuccess();
  }

  Widget _buildSuccess() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: context
          .watch<PatientNotifiers>()
          .patientDetail
          .treatmentModelList
          .length,
      itemBuilder: (BuildContext context, int index) {
        var _item = context
            .watch<PatientNotifiers>()
            .patientDetail
            .treatmentModelList[index];
        TreatmentProcessItemModel _tempItem = TreatmentProcessItemModel(
            id: _item.id,
            title: _item.createDate.xFormatTime9(),
            description: _item.treatment,
            dateTime: _item.createDate);
        return _buildCard(_tempItem, index == 0 ? true : false);
      },
    );
  }

  Widget _buildCard(TreatmentProcessItemModel item, bool newModel) {
    return GestureDetector(
      onTap: () {
        Atom.to(PagePaths.DOCTOR_TREATMENT_EDIT, queryParameters: {
          'treatment_model': jsonEncode(item.toJson()),
          'newModel': newModel.toString()
        });
      },
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //
                        Expanded(
                          child: Text(
                            item.title ?? '',
                            style: context.xHeadline4.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        //
                        Text(
                          '',
                          style: context.xHeadline4.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    //
                    Text(
                      item.description ?? '',
                      style: context.xHeadline5.copyWith(
                        color: getIt<ITheme>().textColorPassive,
                      ),
                    ),
                  ],
                ),
              ),

              //
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: SvgPicture.asset(
                  R.image.arrow_right_icon,
                  height: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
