import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import 'all_files_vm.dart';

class AllFilesScreen extends StatefulWidget {
  const AllFilesScreen({Key? key}) : super(key: key);

  @override
  _AllFilesScreenState createState() => _AllFilesScreenState();
}

class _AllFilesScreenState extends State<AllFilesScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllFilesVm>(
      create: (context) => AllFilesVm(context),
      child: Consumer<AllFilesVm>(
        builder: (BuildContext context, AllFilesVm vm, Widget? child) {
          return RbioStackedScaffold(
            isLoading: vm.showProgressOverlay,
            appbar: _buildAppBar(),
            body: _buildBody(vm),
          );
        },
      ),
    );
  }

  RbioAppBar _buildAppBar() {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).all_appointment_file,
      ),
    );
  }

  Widget _buildBody(AllFilesVm vm) {
    switch (vm.progress) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return _buildListView(vm);

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }

  Widget _buildListView(AllFilesVm vm) {
    if (vm.fileLists.isEmpty) {
      return Center(
        child: Text(
          LocaleProvider.of(context).no_file_found,
          textAlign: TextAlign.center,
          textScaleFactor: 1.3,
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(
        top: R.sizes.stackedTopPaddingValue(context) + 8,
      ),
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: vm.fileLists.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildCard(vm, vm.fileLists[index]);
      },
    );
  }

  Widget _buildCard(AllFilesVm vm, ServerFile file) {
    return InkWell(
      onTap: () => vm.onFileTapped(file),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(
                (file.fileType ?? '').toLowerCase() == "pdf"
                    ? R.image.ic_file_icon
                    : R.image.ic_image_icon,
              ),

              //
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 1,
                height: 30,
                color: getIt<ITheme>().textColorPassive,
              ),

              //
              Expanded(
                child: Text(
                  file.file ?? '',
                  style: TextStyle(color: R.color.black, fontSize: 18),
                ),
              ),

              //
              SvgPicture.asset(
                R.image.ic_arrow_right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
