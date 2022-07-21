import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../core/core.dart';
import '../cubit/request_suggestions_cubit.dart';

class RequestSuggestionsScreen extends StatelessWidget {
  const RequestSuggestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestSuggestionsCubit(getIt()),
      child: const RequestSuggestionsView(),
    );
  }
}

class RequestSuggestionsView extends StatefulWidget {
  const RequestSuggestionsView({Key? key}) : super(key: key);

  @override
  _RequestSuggestionsViewState createState() => _RequestSuggestionsViewState();
}

class _RequestSuggestionsViewState extends State<RequestSuggestionsView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController textEditingController;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    focusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestSuggestionsCubit, RequestSuggestionsState>(
      listener: (BuildContext context, RequestSuggestionsState state) {
        if (state.status == RequestSuggestionsStatus.success) {
          showWarningDialog(
            context,
            LocaleProvider.current.info,
            LocaleProvider.current.suggestion_thanks_message,
          );
        } else if (state.status == RequestSuggestionsStatus.failure) {
          showWarningDialog(
            context,
            LocaleProvider.current.warning,
            LocaleProvider.current.something_went_wrong,
          );
        }
      },
      builder: (BuildContext context, RequestSuggestionsState state) {
        return KeyboardDismissOnTap(
          child: RbioStackedScaffold(
            isLoading: state.status == RequestSuggestionsStatus.loadInProgress,
            appbar: _buildAppBar(context),
            // body: Container(),
            body: _buildBody(context),
          ),
        );
      },
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      context: context,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).request_and_suggestions,
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: RbioKeyboardActions(
        focusList: [
          focusNode,
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            R.widgets.stackedTopPadding(context),
            R.widgets.hSizer16,

            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                LocaleProvider.current.request_and_suggestions_text,
                textAlign: TextAlign.center,
                style: context.xHeadline5.copyWith(
                  color: context.xPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            //
            Form(
              key: formKey,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: R.sizes.borderRadiusCircular,
                ),
                child: ClipRRect(
                  borderRadius: R.sizes.borderRadiusCircular,
                  child: RbioTextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value?.isNotEmpty ?? false) {
                        return null;
                      } else {
                        return LocaleProvider.current.validation;
                      }
                    },
                    focusNode: focusNode,
                    controller: textEditingController,
                    keyboardType: TextInputType.multiline,
                    border: RbioTextFormField.noneBorder(),
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(500),
                    ],
                    hintText: LocaleProvider.current.request_and_suggestions,
                  ),
                ),
              ),
            ),

            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textEditingController.text.length.toString() + "/500",
                style: context.xHeadline5,
              ),
            ),

            //
            R.widgets.hSizer8,

            //
            Center(
              child: RbioElevatedButton(
                title: LocaleProvider.current.send,
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    context.read<RequestSuggestionsCubit>().sendSuggestion(
                        text: textEditingController.text.trim());
                  } else {
                    LocaleProvider.current.validation;
                  }
                },
                infinityWidth: true,
              ),
            ),

            //
            R.widgets.defaultBottomPadding,
          ],
        ),
      ),
    );
  }

  void showWarningDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return RbioMessageDialog(
          description: text,
          buttonTitle: LocaleProvider.current.Ok,
          isAtom: false,
        );
      },
    ).then((value) {
      Atom.to(PagePaths.main, isReplacement: true);
    });
  }
}
