import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/helper/resources.dart';
import 'package:onedosehealth/pages/additional_info/additional_info_view_model.dart';
import 'package:onedosehealth/widgets/utils.dart';
import 'package:provider/provider.dart';
import 'online_appointment_file_view_model.dart';

class OnlineAppointmentFilePage extends StatefulWidget {
  @override
  _OnlineAppointmentFilePageState createState() =>
      _OnlineAppointmentFilePageState();
}

class _OnlineAppointmentFilePageState extends State<OnlineAppointmentFilePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    String webAppointmentId = ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider(
      create: (context) => OnlineAppointmentFileViewModel(
          context: context, webAppointmentId: webAppointmentId),
      child: Consumer<OnlineAppointmentFileViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: MainAppBar(
                context: context,
                title: TitleAppBarWhite(
                    title: LocaleProvider.current.appointment_files),
                leading: InkWell(
                    child: SvgPicture.asset(R.image.back_icon),
                    onTap: () => Navigator.of(context).pop())),
            body: value.stateProcess == StateProcess.DONE
                ? _buildBody(context: context, files: value.appointmentFiles)
                : Container(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                value.selectFile();
              },
              backgroundColor: R.color.main_color,
              child: Container(
                height: 25,
                width: 25,
                child: SvgPicture.asset(R.image.add_icon),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildBody({BuildContext context, List<String> files}) {
  return ListView.builder(
    itemCount: files.length,
    padding: EdgeInsets.all(8),
    itemBuilder: (context, index) {
      return Consumer<OnlineAppointmentFileViewModel>(
          builder: (context, value, child) {
        return Card(
          elevation: 4,
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: [
              IconSlideAction(
                caption: LocaleProvider.current.delete,
                color: R.color.very_low,
                icon: Icons.delete,
                onTap: () {
                  value.deleteFile(value.webAppointmentId, files[index]);
                },
              ),
            ],
            child: ListTile(
              title: Text(
                files[index],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                value.downloadFile(value.webAppointmentId, files[index]);
              },
            ),
          ),
        );
      });
    },
  );
}
