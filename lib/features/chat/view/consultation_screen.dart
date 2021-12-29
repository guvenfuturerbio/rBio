import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../controller/consultation_vm.dart';
import '../model/chat_person.dart';

class ConsultationScreen extends StatelessWidget {
  ConsultationScreen({Key key}) : super(key: key);

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
          //  floatingActionButton: _buildFAB(),
        );
      }),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.consultation,
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
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: vm.stream,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> streamList,
      ) {
        if (streamList.hasData) {
          final list = vm.getChatPersonWithStream(streamList);
          return ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: vm.list.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildCard(context, list[index]);
            },
          );
        }

        if (streamList.hasError) {
          return RbioBodyError();
        }

        return RbioLoading();
      },
    );
  }
  // #endregion

  // #region _buildCard
  Widget _buildCard(BuildContext context, ChatPerson item) {
    return GestureDetector(
      onTap: () {
        Atom.to(
          PagePaths.CHAT,
          queryParameters: {'otherPerson': item.toJson()},
        );
      },
      child: Container(
        color: Colors.transparent,
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
              backgroundImage: NetworkImage(item.url),
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
                  Row(
                    children: [
                      Text(
                        item.name ?? '',
                        style: context.xHeadline5.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(item.messageTime ?? ""),
                          //
                          SizedBox(
                            height: 8,
                          ),
                          item.otherHasRead &&
                                  item.hasRead &&
                                  item.lastMessageSender ==
                                      getIt<UserNotifier>().firebaseID
                              ? SvgPicture.asset(R.image.eyeseen_icon,
                                  height: 10)
                              : SizedBox(),
                        ],
                      )
                    ],
                  ),

                  //
                  SizedBox(height: 6),

                  //
                  Text(
                    item.lastMessage ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: item.hasRead
                        ? context.xBodyText1
                        : context.xBodyText1
                            .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            //
            item.hasRead
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(top: 12, right: 0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getIt<ITheme>().mainColor),
                      child: SizedBox(
                        height: 10,
                        width: 10,
                      ),
                    ),
                  ),

            //
          ],
        ),
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
            R.image.add,
            color: R.color.white,
          ),
        ),
      ),
      backgroundColor: R.color.white,
    );
  }
  // #endregion
}
