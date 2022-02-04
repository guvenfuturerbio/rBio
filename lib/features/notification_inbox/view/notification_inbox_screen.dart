import 'package:flutter/material.dart';

import '../../../core/core.dart';

class NotificationInboxScreen extends StatefulWidget {
  const NotificationInboxScreen({Key? key}) : super(key: key);

  @override
  State<NotificationInboxScreen> createState() =>
      NotificationInboxStateScreen();
}

class NotificationInboxStateScreen extends State<NotificationInboxScreen> {
  @override
  Widget build(BuildContext context) {
    return RbioStackedScaffold(
      appbar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  RbioAppBar _buildAppBar() {
    return RbioAppBar(
      leadingWidth: 0,
      leading: const SizedBox(),
    );
  }

  Widget _buildBody() => Center(
        child: Text(
          LocaleProvider.current.notification_inbox_empty,
          style: context.xHeadline3,
        ),
      );
}
