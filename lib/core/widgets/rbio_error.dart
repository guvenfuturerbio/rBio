import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core.dart';

class RbioError extends StatelessWidget {
  const RbioError({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RbioAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //
          _buildGap(),

          //
          Center(
            child: Container(
              width: 1176,
              child: SvgPicture.asset(
                R.image.oops,
              ),
            ),
          ),

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
      ),
    );
  }

  Widget _buildGap() => SizedBox(height: 16);
}
