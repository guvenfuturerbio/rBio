import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/treatment_model/treatment_model.dart';
import '../../notifiers/patient_notifiers.dart';

part '../model/treatment_process_model.dart';

class DoctorTreatmentProcessScreen extends StatefulWidget {
  const DoctorTreatmentProcessScreen({Key? key}) : super(key: key);

  @override
  _DoctorTreatmentProcessScreenState createState() =>
      _DoctorTreatmentProcessScreenState();
}

class _DoctorTreatmentProcessScreenState
    extends State<DoctorTreatmentProcessScreen> {
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
          LocaleProvider.current.treatment_process,
        ),
      );

  Widget _buildBody() {
    return _buildSuccess();
  }

  Widget _buildSuccess() {
    return Consumer<PatientNotifiers>(
      builder: (context, value, child) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: value.patientDetail.treatmentModelList?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            var _item = value.patientDetail.treatmentModelList?[index];
            TreatmentProcessItemModel _tempItem = TreatmentProcessItemModel(
              id: _item?.id,
              title: _item?.createDate?.xFormatTime9(),
              description: _item?.treatment,
              dateTime: _item?.createDate,
            );

            return _buildCard(_tempItem, index == 0 ? true : false);
          },
        );
      },
    );
  }

  Widget _buildCard(TreatmentProcessItemModel item, bool newModel) {
    return GestureDetector(
      onTap: () {
        Atom.to(
          PagePaths.doctorTreatmentEdit,
          queryParameters: {
            'treatment_model': jsonEncode(item.toJson()),
            'newModel': newModel.toString()
          },
        );
      },
      child: Card(
        elevation: R.sizes.defaultElevation,
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
                    Text(
                      item.title ?? "",
                      style: context.xHeadline4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //
                    Text(
                      item.description ?? "",
                      maxLines: 3,
                      style: context.xHeadline5.copyWith(
                        color: getIt<ITheme>().textColorPassive,
                      ),
                    ),
                  ],
                ),
              ),

              //
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: SvgPicture.asset(
                  R.image.arrowRightIcon,
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
