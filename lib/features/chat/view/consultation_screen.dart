import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/features/dashboard/not_chronic_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../controller/consultation_vm.dart';
import '../model/chat_person.dart';

class ConsultationScreen extends StatelessWidget {
  final bool fromBottomBar;

  const ConsultationScreen({
    Key? key,
    this.fromBottomBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !(getIt<UserNotifier>().isCronic || getIt<UserNotifier>().isDoctor)
        ? NotChronicScreen(
            title: LocaleProvider.current.consultation,
          )
        : ChangeNotifierProvider<DoctorConsultationVm>(
            create: (context) => DoctorConsultationVm(context),
            child: Consumer<DoctorConsultationVm>(builder: (
              BuildContext context,
              DoctorConsultationVm vm,
              Widget? child,
            ) {
              return RbioScaffold(
                appbar: _buildAppBar(context),
                body: _buildBody(context, vm),
              );
            }),
          );
  }

  RbioAppBar _buildAppBar(BuildContext context) => RbioAppBar(
        leadingWidth: !fromBottomBar ? null : 0,
        leading: !fromBottomBar ? null : const SizedBox(width: 0, height: 0),
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.consultation,
        ),
      );

  // #region _buildBody
  Widget _buildBody(BuildContext context, DoctorConsultationVm vm) {
    switch (vm.progress) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return _buildList(context, vm);

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
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
          final list = vm.getChatPersonListWithStream(streamList.data!);
          return ListView.builder(
            padding: EdgeInsets.only(
              bottom: !fromBottomBar ? 0 : R.sizes.bottomNavigationBarHeight,
            ),
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildCard(context, list[index]);
            },
          );
        }

        if (streamList.hasError) {
          return const RbioBodyError();
        }

        return const RbioLoading();
      },
    );
  }
  // #endregion

  // #region _buildCard
  Widget _buildCard(BuildContext context, ChatPerson item) {
    return GestureDetector(
      onTap: () {
        Atom.to(
          PagePaths.chat,
          queryParameters: {
            'otherPerson': item.toJson(),
          },
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            const SizedBox(height: 4),

            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                CircleAvatar(
                  backgroundColor: getIt<ITheme>().cardBackgroundColor,
                  backgroundImage: NetworkImage(item.url!),
                  radius: 25,
                ),

                //
                const SizedBox(width: 12),

                //
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              item.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.xHeadline4.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          //
                          item.hasRead!
                              ? const SizedBox()
                              : Container(
                                  margin: const EdgeInsets.only(right: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: getIt<ITheme>().mainColor,
                                  ),
                                  child: const SizedBox(
                                    height: 10,
                                    width: 10,
                                  ),
                                ),
                        ],
                      ),

                      //
                      const SizedBox(height: 4),

                      //
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //
                          if (item.lastMessageType == 0) ...[
                            Expanded(
                              child: Text(
                                item.lastMessage ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: item.hasRead!
                                    ? context.xHeadline5
                                    : context.xHeadline5
                                        .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ] else ...[
                            Image.network(
                              item.lastMessage ?? "",
                              height: 20,
                            ),
                          ],

                          //
                          item.otherHasRead! &&
                                  item.hasRead! &&
                                  item.lastMessageSender ==
                                      getIt<UserNotifier>().firebaseID
                              ? SvgPicture.asset(
                                  R.image.eyeSeen,
                                  height: 12,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                item.messageTime ?? "",
                style: context.xBodyText1,
              ),
            ),

            //
            const SizedBox(height: 4),

            //
            const Divider(),
          ],
        ),
      ),
    );
  }
  // #endregion
}
