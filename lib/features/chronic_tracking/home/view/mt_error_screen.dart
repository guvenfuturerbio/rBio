import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/core.dart';

class RbioRouteError extends StatelessWidget {
  const RbioRouteError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(),
      body: const MtErrorScreen(),
    );
  }
}

class MtErrorScreen extends StatelessWidget {
  const MtErrorScreen({Key? key}) : super(key: key);
  final String oneDoseLink = "www.onedosehealth.io";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //
        _buildGap(),

        //
        Linkify(
          onOpen: (link) async {
            if (await canLaunch(link.url)) {
              await launch(link.url);
            } else {
              throw 'Could not launch $link';
            }
          },
          text: "${LocaleProvider.current.chronic_track_error}  $oneDoseLink",
          style: context.xHeadline2,
          textAlign: TextAlign.center,
        ),

        //
        _buildGap(),

        //
        RbioElevatedButton(
          onTap: () {
            Atom.historyBack();
          },
          title: LocaleProvider.current.turn_back,
        ),
      ],
    );
  }

  Widget _buildGap() => const SizedBox(height: 16);
}
