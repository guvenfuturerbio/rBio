import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import '../../../core/core.dart';

class WebConferanceScreen extends StatefulWidget {
  String webConsultAppId;
  int availability;

  WebConferanceScreen({
    Key key,
    this.webConsultAppId,
    this.availability,
  }) : super(key: key);

  @override
  _WebConferanceScreenState createState() => _WebConferanceScreenState();
}

class _WebConferanceScreenState extends State<WebConferanceScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await getIt<UserManager>()
            .startMeeting(context, widget.webConsultAppId, widget.availability);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      widget.webConsultAppId = Atom.queryParameters['webConsultAppId'];
      widget.availability = int.parse(Atom.queryParameters['availability']);
    } catch (_) {
      return RbioRouteError();
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
          color: Colors.white54,
          child: JitsiMeetConferencing(
            extraJS: [
              // extraJs setup example
              '<script>function echo(){console.log("echo!!!")};</script>',
              '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
            ],
          ),
        ),
      ),
    );
  }
}
