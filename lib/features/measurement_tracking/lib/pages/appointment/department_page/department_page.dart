import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/extension/size_extension.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/helper/resources.dart';
import 'package:onedosehealth/models/appointment_models/Department.dart';
import 'package:onedosehealth/pages/appointment/appointment_page/appointment_page_view_model.dart';
import 'package:onedosehealth/pages/appointment/department_page/department_page_view_model.dart';
import 'package:onedosehealth/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:onedosehealth/widgets/utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DepartmentPage extends StatefulWidget {
  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: CustomAppBar(
          preferredSize: Size.fromHeight(context.HEIGHT * .18),
          title: TitleAppBarWhite(title: LocaleProvider.current.department),
          leading: InkWell(
              child: SvgPicture.asset(R.image.back_icon),
              onTap: () => Navigator.of(context).pop())),
      extendBodyBehindAppBar: true,
      body: ChangeNotifierProvider(
        create: (context) => DepartmentPageViewModel(context: context),
        child: Consumer<DepartmentPageViewModel>(
          builder: (context, value, child) {
            return Center(
              child: value.stage == Stage.DONE
                  ? _buildPosts(context, value.departments)
                  : value.stage == Stage.LOADING
                      ? _shimmer(context)
                      : Container(),
            );
          },
        ),
      ),
    );
  }

  Widget _shimmer(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: 300,
          padding: EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Shimmer.fromColors(
                  child: ListTile(
                    title: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.05,
                      color: Colors.white,
                    ),
                  ),
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                ),
              ],
            );
          },
        ))
      ],
    );
  }

  ListView _buildPosts(BuildContext context, List<Department> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: Consumer<DepartmentPageViewModel>(
            builder: (context, value, child) {
              return ListTile(
                title: Text(
                  posts[index]?.name ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                //subtitle: Text(posts[index].id.toString()),
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.DOCTORS,
                      arguments: posts[index].id.toString());
                },
              );
            },
          ),
        );
      },
    );
  }
}
