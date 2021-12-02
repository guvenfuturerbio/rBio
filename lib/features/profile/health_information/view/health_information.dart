import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../viewmodel/health_information_vm.dart';
import '../widget/widgets_in_use.dart';
import 'package:provider/provider.dart';

class HealthInformation extends StatefulWidget {
  const HealthInformation({Key key}) : super(key: key);

  @override
  _HealthInformationState createState() => _HealthInformationState();
}

class _HealthInformationState extends State<HealthInformation> {
  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: Text("My Health Information"),
      ),
      body: Consumer<HealthInformationVm>(
          builder: (BuildContext context, value, Widget child) =>
              _buildBody(value)),
    );
  }

  Widget _buildBody(HealthInformationVm val) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                healthInfoItem(context, val,
                    one_one: LocaleProvider.current.diabet_type,
                    one_two: val.selection.diabetesType,
                    two_one: LocaleProvider.current.weight,
                    two_two: val.selection.weight),
                healthInfoItem(context, val,
                    one_one: LocaleProvider.current.normal_range,
                    one_two:
                        "${val.selection.rangeMin}-${val.selection.rangeMax} mg/dl",
                    two_one: LocaleProvider.current.height,
                    two_two: "${val.selection.height}"),
                healthInfoItem(context, val,
                    one_one: LocaleProvider.current.max_range,
                    one_two: "${val.selection.hyper} mg/dl",
                    two_one: null,
                    two_two: null),
                healthInfoItem(context, val,
                    one_one: LocaleProvider.current.min_range,
                    one_two: "${val.selection.hypo} mg/dl",
                    two_one: null,
                    two_two: null),
                healthInfoItem(context, val,
                    one_one: LocaleProvider.current.do_you_smoke,
                    one_two: "${val.selection.smoker}",
                    two_one: null,
                    two_two: null,
                    smokeCheck: true),
                healthInfoItem(context, val,
                    one_one: LocaleProvider.current.year_of_diagnosis,
                    one_two: "${val.selection.yearOfDiagnosis}",
                    two_one: null,
                    two_two: null)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: RbioElevatedButton(
            title: "Bilgileri Güncelle",
            onTap: () {
              print("asd");
            },
          ),
        )
      ],
    );
  }
}
