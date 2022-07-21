import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class NotificationInboxScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? drawerKey;

  const NotificationInboxScreen({
    Key? key,
    this.drawerKey,
  }) : super(key: key);

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
      context: context,
      leading: widget.drawerKey != null
          ? RbioLeadingMenu(drawerKey: widget.drawerKey)
          : null,
    );
  }

  Widget _buildBody() => Column(
        children: [
          R.widgets.stackedTopPadding(context),
          RbioEmptyText(title: LocaleProvider.current.notification_inbox_empty),
        ],
      );
}
