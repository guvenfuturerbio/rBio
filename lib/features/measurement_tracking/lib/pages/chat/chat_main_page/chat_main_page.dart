import 'package:flutter/services.dart';
import 'package:onedosehealth/extension/size_extension.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/pages/additional_info/additional_info_view_model.dart';
import 'package:onedosehealth/pages/chat/chat_main_page/chat_main_page_vm.dart';
import 'package:onedosehealth/pages/chat/chat_person.dart';
import 'package:onedosehealth/pages/chat/chat_window.dart';
import 'package:onedosehealth/pages/chat/chat_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/helper/resources.dart';
import 'package:onedosehealth/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:onedosehealth/widgets/utils.dart';
import 'package:provider/provider.dart';

/// MG15 - Message history of all doctors with patient's post history is shown on this page
class ChatMainPage extends StatelessWidget {
  const ChatMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ChangeNotifierProvider(
      create: (context) => ChatMainPageVm(context: context),
      child: Consumer<ChatMainPageVm>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: CustomAppBar(
                preferredSize: Size.fromHeight(context.HEIGHT * .18),
                leading: InkWell(
                    child: SvgPicture.asset(R.image.back_icon),
                    onTap: () => Navigator.of(context).pop()),
                title:
                    TitleAppBarWhite(title: LocaleProvider.current.messages)),
            extendBodyBehindAppBar: true,
            body: value.stateProcess == StateProcess.DONE
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: context.HEIGHT * .16,
                        ),
                        ...value.myChatList
                            .map((item) => ChatListTile(item))
                            .toList()
                      ],
                    ),
                  )
                : Container(), //TODO try again Widget(button and information text) for refresh page
          );
        },
      ),
    );
  }
}

class ChatListTile extends StatelessWidget {
  ChatPerson person;
  ChatListTile(this.person);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider<ChatController>(
                create: (context) => ChatController(),
                child: ChatWindow(person))),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 15,
          child: Container(
            height: 75,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(person.url)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(person.name),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
