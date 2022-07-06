import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:searchfield/searchfield.dart';

import '../../SIL_DELETE_DELETE_SIL/sil.dart';

class ECouncilCreateCouncilRequestScreen extends StatelessWidget {
  ECouncilCreateCouncilRequestScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RbioAppBar(title: Text(LocaleProvider.of(context).create_new_council_demand)),
      body: _buildBody(context),
    );
  }

  SingleChildScrollView _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _BuildSearchFiled(textController: _textController),
              R.sizes.hSizer24,
              Text(LocaleProvider.of(context).name_surname, style: context.xHeadline4),
              R.sizes.hSizer4,
              const RbioTextFormField(),
              R.sizes.hSizer24,
              Text(LocaleProvider.of(context).enter_your_illness_history, style: context.xHeadline4),
              R.sizes.hSizer4,
              const RbioTextFormField(minLines: 4, maxLines: 4),
              R.sizes.hSizer24,
              const _BuildRecordField(),
              R.sizes.hSizer24,
              const _BuildUploadFiled(),
              R.sizes.hSizer24,
              _BuildCreateDemandButton(formKey: _formKey),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildUploadFiled extends StatelessWidget {
  const _BuildUploadFiled({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RbioTextFormField(border: OutlineInputBorder(borderSide: BorderSide.none)),
        const Divider(height: 2, thickness: 2),
        Container(height: 25, color: Colors.white),
      ],
    );
  }
}

class _BuildRecordField extends StatefulWidget {
  const _BuildRecordField({
    Key? key,
  }) : super(key: key);

  @override
  State<_BuildRecordField> createState() => _BuildRecordFieldState();
}

class _BuildRecordFieldState extends State<_BuildRecordField> with TickerProviderStateMixin {
  double microphoneSvgSize = 48;
  bool isRecording = false;
  Color borderColor = Colors.transparent;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    controller.addStatusListener((AnimationStatus status) {
      setState(() {});
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      height: microphoneSvgSize,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: borderColor, width: 3),
        boxShadow: [
          if (isRecording) BoxShadow(color: borderColor.withOpacity(0.5), spreadRadius: 1, blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          //? Sol Mikrofon
          GestureDetector(
            child: SvgPicture.asset(R.image.councilRecord, width: microphoneSvgSize, height: microphoneSvgSize),
            onLongPressStart: (LongPressStartDetails detail) {
              setState(() {
                microphoneSvgSize = 64;
                borderColor = Colors.green;
                isRecording = true;
                controller.forward();
                controller.addListener(() {
                  setState(() {});
                });
              });
            },
            onLongPressMoveUpdate: (LongPressMoveUpdateDetails detail) {
              log(detail.localPosition.distance.toString());
              if (detail.localPosition.distance >= 150) {
                setState(() {
                  borderColor = Colors.red;
                });
              } else {
                setState(() {
                  borderColor = Colors.green;
                });
              }
            },
            onLongPressEnd: (LongPressEndDetails detail) {
              setState(() {
                microphoneSvgSize = 48;
                borderColor = Colors.transparent;
                isRecording = false;
                controller.removeListener(() {
                  setState(() {});
                });
                controller.value = 0.0;
              });
            },
          ),
          //? Text
          Text(
            isRecording ? LocaleProvider.of(context).slide_to_cancel : LocaleProvider.of(context).press_and_hold_the_microphone,
            style: context.xSubtitle1.copyWith(color: getIt<IAppConfig>().theme.textColorPassive),
          ),
          //? Ileri oku
          Visibility(
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: getIt<IAppConfig>().theme.textColorPassive,
              ),
              visible: isRecording),
          const Spacer(),
          //? Sag mikrofon
          Visibility(
            child: Opacity(
              child: const Icon(Icons.mic, color: Colors.red),
              opacity: controller.value,
            ),
            visible: isRecording,
          ),
        ],
      ),
    );
  }
}

class _BuildCreateDemandButton extends StatelessWidget {
  const _BuildCreateDemandButton({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return RbioElevatedButton(
      title: LocaleProvider.of(context).create_demand,
      onTap: () {
        if (_formKey.currentState!.validate()) {
          // Geçerli form
        }
      },
    );
  }
}

class _BuildSearchFiled extends StatelessWidget {
  const _BuildSearchFiled({
    Key? key,
    required TextEditingController textController,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return SearchField(
      searchInputDecoration: InputDecoration(
        hintText: LocaleProvider.of(context).please_select_your_diagnosis,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: Icon(Icons.search, color: getIt<IAppConfig>().theme.mainColor),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
      ),
      controller: _textController,
      autoCorrect: false,
      suggestions: listOfSearchItems.map((String e) => SearchFieldListItem(e)).toList(),
      validator: (String? x) {
        if (!listOfSearchItems.contains(x) || x!.isEmpty) {
          return LocaleProvider.of(context).inlavid_diagnosis;
        }
        return null;
      },
    );
  }
}
