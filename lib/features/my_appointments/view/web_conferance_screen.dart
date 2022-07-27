import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class WebConferanceScreen extends StatefulWidget {
  String? webConsultAppId;
  int? availability;
  String? fromDate;

  WebConferanceScreen({Key? key}) : super(key: key);

  @override
  _WebConferanceScreenState createState() => _WebConferanceScreenState();
}

class _WebConferanceScreenState extends State<WebConferanceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await getIt<UserManager>().startMeeting(
          context,
          widget.webConsultAppId ?? '',
          widget.availability ?? 0,
          widget.fromDate ?? '',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      widget.webConsultAppId = Atom.queryParameters['webConsultAppId']!;
      widget.availability = int.parse(Atom.queryParameters['availability']!);
      widget.fromDate = Atom.queryParameters['fromDate']!;
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return RbioScaffold(
      appbar: RbioAppBar(context: context),
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
