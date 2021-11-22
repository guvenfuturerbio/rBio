import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../common/mediminder_common.dart';

class StripScreen extends StatefulWidget {
  StripScreen({Key key}) : super(key: key);

  @override
  _StripScreenState createState() => _StripScreenState();
}

class _StripScreenState extends State<StripScreen> {
  final _formKey = GlobalKey<FormState>();
  StripMode modeOfStrip = StripMode.NONE;

  TextEditingController stripCountController;
  TextEditingController alarmController;

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
          Widget child,
        ) {
          alarmController.text = stripCount.alarmCount.toString();
          stripCountController.text = stripCount.stripCount.toString();
          stripCountController.selection = TextSelection.collapsed(
              offset: stripCount?.stripCount?.toString()?.length ?? 0);
          alarmController.selection = TextSelection.collapsed(
              offset: stripCount?.alarmCount?.toString()?.length ?? 0);

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
            height: context.HEIGHT * .18,
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),

          //
          _buildTextField(stripCount),

          //
          Text(
            LocaleProvider.current.strips_left,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          //
          SizedBox(
            height: 20,
          ),

          //
          _buildSaveChangesButton(stripCount),

          //
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(StripVm stripCount) {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 16),
      child: Column(
        children: <Widget>[
          Card(
            color: Mediminder.instance.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 4,
            child: Container(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //
                  Container(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(Mediminder.instance.mark_icon),
                  ),

                  //
                  Expanded(
                    child: Text(
                      stripCount.usedStripCount == 0
                          ? LocaleProvider.current.never_used_strip
                          : LocaleProvider.current.strips_used.format(
                              []..add(stripCount.usedStripCount.toString())),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
          SizedBox(
            width: 40,
          ),

          //
          CircleAvatar(
            backgroundColor: Mediminder.instance.btnDarkBlue,
            radius: 85,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 70,
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Column(
                  children: [
                    //
                    Container(
                      width: 70,
                      child: Theme(
                        data: ThemeData(primaryColor: Colors.black),
                        child: TextFormField(
                          controller: stripCountController,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 3,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value != null && value != '') {
                              stripCount.changeTo(int.parse(value));
                            }
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            errorStyle: TextStyle(height: 0),
                          ),
                          validator: (input) {
                            if (input.isNotEmpty)
                              return null;
                            else
                              return "";
                          },
                        ),
                      ),
                    ),

                    //
                    SizedBox(
                      height: 9,
                    ),

                    //
                    Text(
                      LocaleProvider.current.strips,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
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
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(LocaleProvider.current.remove_strips,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          modeOfStrip = StripMode.SUBTRACT;
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
                        color: Mediminder.instance.black,
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
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 40,
                        color: Mediminder.instance.black,
                      ),
                      TextButton(
                        child: Text(LocaleProvider.current.add_strips,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          modeOfStrip = StripMode.ADD;
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
          style: TextStyle(
            fontWeight: FontWeight.w100,
            fontSize: 12,
            color: Colors.grey,
          ),
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
        child: Container(
          width: 350,
          child: TextField(
            controller: alarmController,
            cursorColor: Colors.black,
            textAlign: TextAlign.center,
            maxLength: 3,
            keyboardType: TextInputType.number,
            obscureText: false,
            decoration: new InputDecoration(
              border: InputBorder.none,
              counterText: "",
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.only(
                left: 15,
                bottom: 11,
                top: 11,
                right: 15,
              ),
              hintText: "Strip number",
            ),
            onChanged: (String value) {
              if (value != '' && value != null) {
                try {
                  stripCount.setAlarmCount((int.parse(value) ?? 30));
                } catch (e) {}
              }
            },
          ),
        ),
      ),
    );
  }

  Container _buildSaveChangesButton(StripVm stripCount) {
    return Container(
      height: 50,
      width: 150,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: <Color>[
              Mediminder.instance.btnLightBlue,
              Mediminder.instance.btnDarkBlue
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
                Mediminder.instance.done_icon,
                height: 30,
                width: 30,
              ),
              Text(
                LocaleProvider.current.save,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              stripCount.saveData();
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
          title,
          (val) {
            if (mos == StripMode.ADD) {
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
