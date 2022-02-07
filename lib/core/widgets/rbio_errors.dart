import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core.dart';

class RbioRouteError extends StatelessWidget {
  const RbioRouteError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(),
      body: const RbioBodyError(),
    );
  }
}

class RbioBodyError extends StatelessWidget {
  const RbioBodyError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //
        _buildGap(),

        //
        if (Atom.isWeb) ...[
          Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: SvgPicture.asset(
                R.image.error,
              ),
            ),
          ),
          _buildGap(),
        ] else ...[
          Center(
            child: SvgPicture.asset(
              R.image.error,
              width: Atom.width * 0.3,
            ),
          ),
        ],

        //
        _buildGap(),

        //
        Text(
          LocaleProvider.current.something_went_wrong,
          style: context.xHeadline1,
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
