import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/helper/masked_text_controller.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/notifiers/patient_notifiers.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/resources/resources.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'hypo_hyper_edit_view_model.dart';

class HypoHyperEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HypoHyperEditState();
}

class _HypoHyperEditState extends State<HypoHyperEdit> {
  TextEditingController hypoController = MaskedTextController(mask: "00");
  TextEditingController hyperController = MaskedTextController(mask: "000");
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HypoHyperEditViewModel(context: context),
      child: Consumer<HypoHyperEditViewModel>(
        builder: (context, value, child) {
          hypoController.text = value.hypoText;
          hyperController.text = value.hyperText;
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          LocaleProvider.current.hypo,
                          style: TextStyle(color: R.color.veryLow),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.height * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            color: R.color.veryLow,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: hypoController,
                            textAlign: TextAlign.center,
                            cursorColor: Colors.white,
                            onChanged: (valueTxt) {
                              value.setHypoText(valueTxt);
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          LocaleProvider.current.hyper,
                          style: TextStyle(color: R.color.veryHigh),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.height * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            color: R.color.veryHigh,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.white,
                            textAlign: TextAlign.center,
                            controller: hyperController,
                            onChanged: (valueTxt) {
                              value.setHyperText(valueTxt);
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    value.updatePatientLimit(
                        hypo: int.parse(hypoController.text),
                        hyper: int.parse(hyperController.text),
                        id: Provider.of<PatientNotifiers>(context,
                                listen: false)
                            .patientDetail
                            .id);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: R.color.mainColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0)),
                    ),
                    child: Text(
                      LocaleProvider.current.save,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.all(12.0),
          );
        },
      ),
    );
  }
}
