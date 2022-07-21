import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';

class DoctorVideoCallEditScreen extends StatefulWidget {
  const DoctorVideoCallEditScreen({Key? key}) : super(key: key);

  @override
  _DoctorVideoCallEditScreenState createState() =>
      _DoctorVideoCallEditScreenState();
}

class _DoctorVideoCallEditScreenState extends State<DoctorVideoCallEditScreen> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: RbioScaffold(
        appbar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  RbioAppBar _buildAppBar() => RbioAppBar(
        context: context,
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.treatment_process,
        ),
        actions: [
          Center(
            child: RbioBadge(
              image: R.image.chat,
              isDark: false,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      );

  Widget _buildBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          _buildUserCard(),

          //
          _buildTimeRow(),

          //
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 16,
              right: 8,
              bottom: 8,
            ),
            child: Text(
              LocaleProvider.current.notes,
              textAlign: TextAlign.start,
              style: context.xHeadline4.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.xCardColor,
                borderRadius: R.sizes.borderRadiusCircular,
              ),
              child: RbioTextFormField(
                controller: textEditingController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                border: RbioTextFormField.noneBorder(),
              ),
            ),
          ),

          //
          const SizedBox(
            height: 16,
          ),

          //
          _buildButtons(),

          //
          SizedBox(
            height: Atom.safeBottom + 12,
          ),
        ],
      );

  Widget _buildButtons() {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (!isKeyboardVisible) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              Expanded(
                child: RbioElevatedButton(
                  title: LocaleProvider.current.back,
                  backColor: context.xCardColor,
                  textColor: getIt<IAppConfig>().theme.textColorSecondary,
                  onTap: () {},
                  fontWeight: FontWeight.bold,
                ),
              ),

              //
              const SizedBox(width: 16),

              //
              Expanded(
                child: RbioElevatedButton(
                  title: 'Kaydet',
                  onTap: () {},
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildUserCard() {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: context.xCardColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            foregroundImage: NetworkImage(R.image.circlevatar),
            backgroundColor: context.xCardColor,
          ),

          //
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Serkan Öztürk',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.xHeadline5.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //
          SvgPicture.asset(
            R.image.arrowDown,
            height: 10,
          ),
        ],
      ),
    );
  }

  Padding _buildTimeRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: Text(
              LocaleProvider.current.video_call,
              textAlign: TextAlign.start,
              style: context.xHeadline4.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //
          Expanded(
            child: Text(
              '01/01/2021 - 09:00',
              textAlign: TextAlign.end,
              style: context.xHeadline4.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
