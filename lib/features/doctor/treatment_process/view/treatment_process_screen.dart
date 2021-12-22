import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';

part '../model/treatment_process_model.dart';
part '../viewmodel/treatment_process_vm.dart';

class DoctorTreatmentProcessScreen extends StatefulWidget {
  DoctorTreatmentProcessScreen({Key key}) : super(key: key);

  @override
  _DoctorTreatmentProcessScreenState createState() =>
      _DoctorTreatmentProcessScreenState();
}

class _DoctorTreatmentProcessScreenState
    extends State<DoctorTreatmentProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(),
      body: Consumer<TreatmentProcessVm>(
        builder: (
          BuildContext context,
          TreatmentProcessVm vm,
          Widget child,
        ) {
          return _buildBody(vm);
        },
      ),
    );
  }

  RbioAppBar _buildAppBar() => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.treatment_process,
        ),
        actions: [
          Center(
            child: RbioBadge(
              image: R.image.chat_icon,
              isDark: false,
              onTap: () {
                Atom.to(PagePaths.DOCTOR_CONSULTATION);
              },
            ),
          ),
          SizedBox(
            width: 12,
          ),
        ],
      );

  Widget _buildBody(TreatmentProcessVm vm) {
    switch (vm.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return _buildSuccess(vm);

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }

  Widget _buildSuccess(TreatmentProcessVm vm) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: vm.list.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildCard(vm.list[index]);
      },
    );
  }

  Widget _buildCard(TreatmentProcessItemModel item) {
    return GestureDetector(
      onTap: () {
        Atom.to(PagePaths.DOCTOR_VIDEO_CALL_EDIT);
      },
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //
                        Expanded(
                          child: Text(
                            item.title ?? '',
                            style: context.xHeadline4.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        //
                        Text(
                          item.dateTime ?? '',
                          style: context.xHeadline4.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    //
                    Text(
                      item.description ?? '',
                      style: context.xHeadline5.copyWith(
                        color: getIt<ITheme>().textColorPassive,
                      ),
                    ),
                  ],
                ),
              ),

              //
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: SvgPicture.asset(
                  R.image.arrow_right_icon,
                  height: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
