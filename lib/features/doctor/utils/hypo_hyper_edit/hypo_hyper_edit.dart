import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../notifiers/patient_notifiers.dart';
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
                          style: TextStyle(color: R.color.very_low),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.height * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            color: R.color.very_low,
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
                          style: TextStyle(color: R.color.very_high),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.height * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            color: R.color.very_high,
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
