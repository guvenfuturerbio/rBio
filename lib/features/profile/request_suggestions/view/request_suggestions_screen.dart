import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/request_suggestions_vm.dart';

class RequestSuggestionsScreen extends StatefulWidget {
  const RequestSuggestionsScreen({Key? key}) : super(key: key);

  @override
  _RequestSuggestionsScreenState createState() =>
      _RequestSuggestionsScreenState();
}

class _RequestSuggestionsScreenState extends State<RequestSuggestionsScreen> {
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
    return ChangeNotifierProvider<RequestSuggestionsScreenVm>(
      create: (context) => RequestSuggestionsScreenVm(context: context),
      child: Consumer<RequestSuggestionsScreenVm>(
        builder: (
          BuildContext context,
          RequestSuggestionsScreenVm vm,
          Widget child,
        ) {
          return KeyboardDismissOnTap(
            child: RbioStackedScaffold(
              isLoading: vm.progressOverlay,
              appbar: _buildAppBar(context),
              body: _buildBody(vm, context),
            ),
          );
        },
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).request_and_suggestions,
      ),
    );
  }

  Widget _buildBody(
    RequestSuggestionsScreenVm vm,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          R.sizes.stackedTopPadding(context),
          R.sizes.hSizer16,

          //
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              LocaleProvider.current.request_and_suggestions_text,
              textAlign: TextAlign.center,
              style: context.xHeadline5.copyWith(
                color: getIt<ITheme>().mainColor,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

          //
          Container(
            padding: EdgeInsets.only(top: 8),
            height: MediaQuery.of(context).size.height * 0.40,
            child: Card(
              elevation: 4,
              color: getIt<ITheme>().textColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: RbioTextFormField(
                controller: textEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textInputAction: TextInputAction.done,
                onChanged: (text) {
                  vm.setText(text);
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(500),
                ],
                hintText: LocaleProvider.current.request_and_suggestions,
              ),
            ),
          ),

          //
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              vm.textLength.toString() + "/500",
              style: context.xHeadline5,
            ),
          ),

          //
          R.sizes.hSizer8,

          //
          Center(
            child: RbioElevatedButton(
              title: LocaleProvider.current.send,
              onTap: () {
                vm.sendSuggestion();
              },
              infinityWidth: true,
            ),
          ),

          //
          R.sizes.defaultBottomPadding,
        ],
      ),
    );
  }
}
