import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../core/core.dart';
import '../viewmodel/strip_vm.dart';
import '../widgets/strip_counter_dialog.dart';

class StripScreen extends StatefulWidget {
  const StripScreen({Key? key}) : super(key: key);

  @override
  _StripScreenState createState() => _StripScreenState();
}

class _StripScreenState extends State<StripScreen> {
  final _formKey = GlobalKey<FormState>();
  StripMode modeOfStrip = StripMode.none;

  late TextEditingController stripCountController;
  late TextEditingController alarmController;

  @override
  void initState() {
    stripCountController = TextEditingController();
    alarmController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    stripCountController.dispose();
    alarmController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StripVm>(
      create: (context) => StripVm(context),
      child: Consumer<StripVm>(
        builder: (
          BuildContext context,
          StripVm stripCount,
          Widget? child,
        ) {
          alarmController.text = stripCount.alarmCount.toString();
          stripCountController.text = stripCount.stripCount.toString();
          stripCountController.selection = TextSelection.collapsed(
              offset: stripCount.stripCount.toString().length);
          alarmController.selection = TextSelection.collapsed(
              offset: stripCount.alarmCount.toString().length);

          return KeyboardDismissOnTap(
            child: RbioScaffold(
              extendBodyBehindAppBar: true,
              appbar: RbioAppBar(
                title: RbioAppBar.textTitle(
                  context,
                  LocaleProvider.current.strip_tracker,
                ),
              ),
              body: _buildBody(stripCount),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(StripVm stripCount) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: context.height * .18,
          ),

          //
          _buildHeaderSection(stripCount),

          //
          _buildCircle(stripCount),

          //
          _buildDescription(context),

          //
          Center(
            child: Text(
              LocaleProvider.current.when_to_be_notified,
              style: context.xHeadline3.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          //
          _buildTextField(stripCount),

          //
          Text(
            LocaleProvider.current.strips_left,
            style: context.xHeadline3.copyWith(fontWeight: FontWeight.bold),
          ),

          //
          const SizedBox(
            height: 20,
          ),

          //
          _buildSaveChangesButton(stripCount),

          //
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(StripVm stripCount) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
      child: Column(
        children: <Widget>[
          Card(
            color: getIt<ITheme>().cardBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 4,
            child: Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(R.image.markIcon),
                  ),

                  //
                  Expanded(
                    child: Text(
                      stripCount.usedStripCount == 0
                          ? LocaleProvider.current.never_used_strip
                          : LocaleProvider.current.strips_used
                              .format([stripCount.usedStripCount.toString()]),
                      textAlign: TextAlign.center,
                      style: context.xHeadline3
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(StripVm stripCount) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: 40,
          ),

          //
          CircleAvatar(
            backgroundColor: getIt<ITheme>().mainColor,
            radius: 85,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 70,
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Column(
                  children: [
                    //
                    SizedBox(
                      width: 70,
                      child: Theme(
                        data: ThemeData(primaryColor: Colors.black),
                        child: TextFormField(
                          controller: stripCountController,
                          style: context.xHeadline1
                              .copyWith(fontWeight: FontWeight.bold),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 3,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value != '') {
                              stripCount.changeTo(int.parse(value));
                            }
                          },
                          decoration: const InputDecoration(
                            counterText: '',
                            errorStyle: TextStyle(height: 0),
                          ),
                          validator: (input) {
                            if (input?.isNotEmpty ?? false) {
                              return null;
                            } else {
                              return "";
                            }
                          },
                        ),
                      ),
                    ),

                    //
                    const SizedBox(
                      height: 9,
                    ),

                    //
                    Text(LocaleProvider.current.strips,
                        style: context.xHeadline3.copyWith(
                            color: getIt<ITheme>().textColorSecondary)),
                  ],
                ),
              ),
            ),
          ),

          //
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(
                          LocaleProvider.current.remove_strips,
                          textAlign: TextAlign.center,
                          style: context.xHeadline3.copyWith(
                              color: getIt<ITheme>().textColorSecondary),
                        ),
                        onPressed: () {
                          modeOfStrip = StripMode.subtract;
                          showGradientDialog(
                            LocaleProvider.current.remove_strips,
                            stripCount,
                            modeOfStrip,
                          );
                        },
                      ),
                      Icon(
                        Icons.remove,
                        size: 40,
                        color: getIt<ITheme>().blackForItem,
                      )
                    ],
                  ),
                ),

                //
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 40,
                        color: getIt<ITheme>().blackForItem,
                      ),
                      TextButton(
                        child: Text(LocaleProvider.current.add_strips,
                            textAlign: TextAlign.center,
                            style: context.xHeadline3.copyWith(
                                color: getIt<ITheme>().textColorSecondary)),
                        onPressed: () {
                          modeOfStrip = StripMode.add;
                          showGradientDialog(
                            LocaleProvider.current.add_strips,
                            stripCount,
                            modeOfStrip,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Center(
        child: Text(
          LocaleProvider.current.strip_page_info_message,
          style: context.xHeadline4.copyWith(
              fontWeight: FontWeight.w100,
              color: getIt<ITheme>().textColorPassive),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildTextField(StripVm stripCount) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Material(
        elevation: 15,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: SizedBox(
          width: 350,
          child: TextField(
            controller: alarmController,
            cursorColor: Colors.black,
            textAlign: TextAlign.center,
            maxLength: 3,
            keyboardType: TextInputType.number,
            obscureText: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: "",
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.only(
                left: 15,
                bottom: 11,
                top: 11,
                right: 15,
              ),
              hintText: LocaleProvider.current.strip_number,
            ),
            onChanged: (String value) {
              if (value != '') {
                try {
                  stripCount.setAlarmCount((int.tryParse(value) ?? 30));
                  // ignore: empty_catches
                } catch (e) {}
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSaveChangesButton(StripVm stripCount) {
    return SizedBox(
      height: 50,
      width: 150,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: <Color>[
              getIt<ITheme>().secondaryColor,
              getIt<ITheme>().mainColor
            ],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                R.image.done,
                height: 30,
                width: 30,
              ),
              Text(
                LocaleProvider.current.save,
                style: context.xHeadline3
                    .copyWith(color: getIt<ITheme>().textColor),
              ),
            ],
          ),
          onPressed: () {
            if (_formKey.currentState != null) {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                stripCount.saveData();
              }
            }
          },
        ),
      ),
    );
  }

  void showGradientDialog(String title, StripVm stripCounter, StripMode mos) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StripGradientDialog(
          title: title,
          callback: (val) {
            if (mos == StripMode.add) {
              stripCounter.incrementBy(val);
            } else {
              stripCounter.decrementBy(val);
            }
          },
        );
      },
    );
  }
}
