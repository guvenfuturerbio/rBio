import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class WebConferanceScreen extends StatefulWidget {
  String? webConsultAppId;
  int? availability;

  WebConferanceScreen({Key? key}) : super(key: key);

  @override
  _WebConferanceScreenState createState() => _WebConferanceScreenState();
}

class _WebConferanceScreenState extends State<WebConferanceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) async {
        await getIt<UserManager>().startMeeting(
          context,
          widget.webConsultAppId ?? '',
          widget.availability ?? 0,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      widget.webConsultAppId = Atom.queryParameters['webConsultAppId']!;
      widget.availability = int.parse(Atom.queryParameters['availability']!);
    } catch (_) {
      return const RbioRouteError();
    }

    return RbioScaffold(
      appbar: RbioAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: Atom.size.width,
      height: Atom.size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: R.sizes.defaultElevation,
          color: Colors.white54,
        ),
      ),
    );
  }
}
