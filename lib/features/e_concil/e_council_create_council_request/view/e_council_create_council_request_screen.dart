// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:searchfield/searchfield.dart';

import '../../SIL_DELETE_DELETE_SIL/sil.dart';

class ECouncilCreateCouncilRequestScreen extends StatelessWidget {
  const ECouncilCreateCouncilRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(title: Text(LocaleProvider.of(context).create_new_council_request)),
      body: _BuildBody(),
    );
  }
}

class _BuildBody extends StatelessWidget {
  _BuildBody({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _BuildSearchField(textController: _textController),
            R.sizes.hSizer16,
            const _BuildNameSurnameField(),
            R.sizes.hSizer24,
            const _BuildIllnessHistoryField(),
            R.sizes.hSizer16,
            const _BuildRecordField(),
            R.sizes.hSizer16,
            const _BuildUploadField(),
            R.sizes.hSizer16,
            _BuildCreateRequestButton(formKey: _formKey),
          ],
        ),
      ),
    );
  }
}

class _BuildSearchField extends StatelessWidget {
  const _BuildSearchField({
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
        errorStyle: const TextStyle(fontSize: 11),
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

class _BuildNameSurnameField extends StatelessWidget {
  const _BuildNameSurnameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleProvider.of(context).name_surname, style: context.xHeadline4),
        R.sizes.hSizer4,
        RbioTextFormField(
          validator: (String? p0) {
            if (p0!.isEmpty) {
              return LocaleProvider.of(context).validation;
            }
            return null;
          },
        ),
      ],
    );
  }
}

class _BuildIllnessHistoryField extends StatelessWidget {
  const _BuildIllnessHistoryField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleProvider.of(context).enter_your_illness_history, style: context.xHeadline4),
        R.sizes.hSizer4,
        const RbioTextFormField(minLines: 4, maxLines: 4),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
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
                  // log(detail.localPosition.dx.toString());
                  if (detail.localPosition.distance >= 242) {
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
        ),
        ...silRecordList
            .map<Widget>(
              (String e) => Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.close),
                      splashRadius: 14,
                    ),
                    R.sizes.wSizer8,
                    Text(e, style: context.xSubtitle1),
                  ],
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}

class _BuildUploadField extends StatelessWidget {
  const _BuildUploadField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RbioTextFormField(
          hintText: LocaleProvider.of(context).file_description,
          readOnly: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
          ),
          onTap: () {},
          suffixIcon: Padding(padding: const EdgeInsets.all(10.0), child: SvgPicture.asset(R.image.councilUpload)),
        ),
        const Divider(height: 2, thickness: 2),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 22.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
          ),
          child: Text(LocaleProvider.of(context).please_select_the_file_you_want_to_upload, style: context.xHeadline3),
        ),
        ...silFileList
            .map<Widget>((String e) => CouncilCardFilesWidget(
                  title: e,
                  onPressed: () {},
                ))
            .toList(),
      ],
    );
  }
}

class CouncilCardFilesWidget extends StatelessWidget {
  const CouncilCardFilesWidget({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onPressed,
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.close),
            splashRadius: 14,
          ),
          R.sizes.wSizer8,
          Text(title, style: context.xSubtitle1),
        ],
      ),
    );
  }
}

class _BuildCreateRequestButton extends StatelessWidget {
  const _BuildCreateRequestButton({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return RbioElevatedButton(
      title: LocaleProvider.of(context).create_request,
      onTap: () {
        if (_formKey.currentState!.validate()) {
          // Geçerli form
        }
      },
    );
  }
}
