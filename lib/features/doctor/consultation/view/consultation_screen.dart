import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/features/doctor/consultation/model/consultation_user_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/consultation_vm.dart';

class DoctorConsultationScreen extends StatelessWidget {
  DoctorConsultationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DoctorConsultationVm>(
      create: (context) => DoctorConsultationVm(context),
      child: Consumer<DoctorConsultationVm>(builder: (
        BuildContext context,
        DoctorConsultationVm vm,
        Widget child,
      ) {
        return RbioScaffold(
          appbar: _buildAppBar(context),
          body: _buildBody(context, vm),
          floatingActionButton: _buildFAB(),
        );
      }),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          'Danışma',
        ),
      );

  // #region _buildBody
  Widget _buildBody(BuildContext context, DoctorConsultationVm vm) {
    switch (vm.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return _buildList(context, vm);

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }
  // #endregions

  // #region _buildList
  Widget _buildList(BuildContext context, DoctorConsultationVm vm) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: vm.list.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildCard(context, vm.list[index]);
      },
    );
  }
  // #endregion

  // #region _buildCard
  Widget _buildCard(BuildContext context, DoctorConsultationUserModel item) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          CircleAvatar(
            backgroundColor: getIt<ITheme>().cardBackgroundColor,
            backgroundImage: NetworkImage(item.photoUrl),
            radius: 35,
          ),

          //
          SizedBox(width: 12),

          //
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                Text(
                  item.name ?? '',
                  style: context.xHeadline5.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                //
                SizedBox(height: 6),

                //
                Text(
                  item.lastMessage ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.xBodyText1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // #endregion

  // #region _buildFAB
  Widget _buildFAB() {
    return FloatingActionButton(
      heroTag: 'adder',
      onPressed: () {},
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: getIt<ITheme>().mainColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SvgPicture.asset(
            R.image.add_icon,
            color: R.color.white,
          ),
        ),
      ),
      backgroundColor: R.color.white,
    );
  }
  // #endregion
}
