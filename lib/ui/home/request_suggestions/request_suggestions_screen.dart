import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import 'request_suggestions_vm.dart';

class RequestSuggestionsScreen extends StatefulWidget {
  const RequestSuggestionsScreen({Key key}) : super(key: key);

  @override
  _RequestSuggestionsScreenState createState() =>
      _RequestSuggestionsScreenState();
}

class _RequestSuggestionsScreenState extends State<RequestSuggestionsScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RequestSuggestionsScreenVm>(
      create: (context) => RequestSuggestionsScreenVm(context: context),
      child: Consumer<RequestSuggestionsScreenVm>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: MainAppBar(
                context: context,
                leading: ButtonBackWhite(context),
                title: TitleAppBarWhite(
                    title: LocaleProvider.of(context).request_and_suggestions)),
            body: LoadingOverlay(
              isLoading: value.showProgressOverlay,
              progressIndicator: loadingDialog(),
              opacity: 0,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width < 800
                          ? MediaQuery.of(context).size.width * 0.03
                          : MediaQuery.of(context).size.width * 0.10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          LocaleProvider.current.request_and_suggestions_text,
                          style: TextStyle(
                              color: R.color.blue,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Card(
                          color: R.color.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 4,
                          child: TextField(
                              controller: textEditingController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              maxLengthEnforced: true,
                              textInputAction: TextInputAction.done,
                              minLines: 2,
                              onChanged: (text) {
                                value.setText(text);
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(500),
                              ],
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 12, right: 12),
                                  hintStyle: TextStyle(fontSize: 12),
                                  labelText: LocaleProvider.of(context)
                                      .request_and_suggestions,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    //  when the TextFormField in unfocused
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    //  when the TextFormField in focused
                                  ),
                                  border: UnderlineInputBorder())),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(value.textLength.toString() + "/500"),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      button(
                        text: LocaleProvider.current.save,
                        onPressed: () {
                          value.sendSuggestion();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
