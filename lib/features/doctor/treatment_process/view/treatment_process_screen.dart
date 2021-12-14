import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/core.dart';

class DoctorTreatmentProcessScreen extends StatefulWidget {
  DoctorTreatmentProcessScreen({Key key}) : super(key: key);

  @override
  _DoctorTreatmentProcessScreenState createState() =>
      _DoctorTreatmentProcessScreenState();
}

class _DoctorTreatmentProcessScreenState
    extends State<DoctorTreatmentProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  RbioAppBar _buildAppBar() => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.treatment_process,
        ),
        actions: [
          Center(
            child: RbioBadge(
              image: R.image.chat_icon,
              isDark: false,
            ),
          ),
          SizedBox(
            width: 12,
          ),
        ],
      );

  Widget _buildBody() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return _buildCard();
      },
    );
  }

  Widget _buildCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //
                      Expanded(
                        child: Text(
                          'Görüntülü Görüşme',
                          style: context.xHeadline4.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      //
                      Text(
                        '01/01/2021 - 09:00',
                        style: context.xHeadline4.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  //
                  Text(
                    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh',
                    style: context.xHeadline5.copyWith(
                      color: getIt<ITheme>().textColorPassive,
                    ),
                  ),
                ],
              ),
            ),

            //
            Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: SvgPicture.asset(
                R.image.arrow_right_icon,
                height: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
