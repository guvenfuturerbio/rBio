import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/widgets/loading_dialog.dart';

import '../../../../main.dart';
import '../../models/drug_result.dart';
import 'medicine_period_selection.dart';

class MedicineSelection extends StatefulWidget {
  MedicineSelection();
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<MedicineSelection> with RouteAware {
  LoadingDialog loadingDialog;
  final TextEditingController _filter = new TextEditingController();
  BaseProvider baseProvider;
  String _searchText = "";
  List names = [];
  List<DrugResult> filteredNames = [];

  String get searchText => _searchText;
  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames.clear();
        });
      } else if (_filter.text.length > 2) {
        _searchText = _filter.text;
        _getNames();
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void initState() {
    super.initState();
    baseProvider = BaseProvider.create("");
    _getNames();
  }

  @override
  void didPopNext() {
    _getNames();
  }

  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: getTitleBar(context),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(child: _buildList()),
      ),
    );
  }

  Widget getTitleBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
      padding: EdgeInsets.only(left: 10),
      width: double.infinity,
      child: TextFormField(
        cursorColor: getIt<ITheme>().mainColor,
        autofocus: true,
        controller: _filter,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: LocaleProvider.current.drug_search,
          hintStyle: TextStyle(color: Color(0xFF969696), fontSize: 14),
          labelStyle: TextStyle(color: R.color.black, fontSize: 14),
          suffixIcon: Icon(
            Icons.search,
            color: Color(0xFF969696),
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(200)),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: filteredNames.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 4,
          child: Container(
            height: 56,
            child: Center(
              child: ListTile(
                title: Text(
                  filteredNames[index].name.trim(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(filteredNames[index].name.toLowerCase() ==
                        "doctor"
                    ? LocaleProvider.current.hint_doctor
                    : filteredNames[index].name.toLowerCase() == "department"
                        ? LocaleProvider.current.department
                        : filteredNames[index].name.toLowerCase() == "disease"
                            ? LocaleProvider.current.disease
                            : " "),
                onTap: () {
                  filteredNames[index].name.toLowerCase() == 'doctor'
                      ? _getDoctorInfo(filteredNames[index])
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicinePeriodSelection(
                                drugResult: filteredNames[index],
                                selectedRemindable: null),
                            settings: RouteSettings(name: 'NewEntry'),
                          ),
                        );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _getDoctorInfo(DrugResult searchResult) async {
    showLoadingDialog(context);
    try {} catch (error) {
      Future.delayed(const Duration(milliseconds: 500), () {
        print(error);
        hideDialog(context);
        showGradientDialog(
            context,
            LocaleProvider.current.warning,
            error.toString() == "network"
                ? LocaleProvider.current.no_network_connection
                : LocaleProvider.current.sorry_dont_transaction);
      });
    }
  }

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GuvenAlert(
            title: GuvenAlert.buildTitle(title),
            content: GuvenAlert.buildDescription(text),
          );
        });
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
    //builder: (BuildContext context) => WillPopScope(child:loadingDialog = LoadingDialog() , onWillPop:  () async => false,));
  }

  hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }

  void _getNames() async {
    //final response = await baseProvider.getMedicineByFilter(_searchText);

    //var searchResultBody = jsonDecode(utf8.decode(response.bodyBytes));
    // var datum = searchResultBody["datum"];

    var datum = ["Şeker Ölçümü", "İnsülin", "HbA1c", "Strip"];
    List<DrugResult> drugResults = [];
    int index = 0;

    for (var data in datum) {
      //drugResults.add(new DrugResult.fromJson(data));
      drugResults.add(new DrugResult(name: data, id: index));
      index++;
    }
    setState(() {
      names = drugResults;
      filteredNames = names;
    });
  }
}
