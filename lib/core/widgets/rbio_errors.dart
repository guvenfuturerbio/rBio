import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core.dart';

class RbioRouteError extends StatelessWidget {
  const RbioRouteError({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RbioAppBar(),
      body: RbioBodyError(),
    );
  }
}

class RbioBodyError extends StatelessWidget {
  const RbioBodyError({Key key}) : super(key: key);

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
              constraints: BoxConstraints(
                maxWidth: 600,
              ),
              child: SvgPicture.asset(
                R.image.oops,
              ),
            ),
          ),
        ] else ...[
          Center(
            child: SvgPicture.asset(
              R.image.oops,
              width: Atom.width * 0.6,
            ),
          ),
        ],

        //
        _buildGap(),

        //
        Text(
          'Bir şeyler ters gitti',
          style: context.xHeadline1,
        ),

        //
        _buildGap(),

        //
        RbioElevatedButton(
          onTap: () {},
          title: 'Geriye Dön',
        ),
      ],
    );
  }

  Widget _buildGap() => SizedBox(height: 16);
}
