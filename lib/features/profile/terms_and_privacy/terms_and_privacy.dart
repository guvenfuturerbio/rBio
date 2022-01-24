import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/profile/terms_and_privacy/terms_and_privacy_vm.dart';
import 'package:provider/provider.dart';

class TermsAndPrivacyScreen extends StatefulWidget {
  const TermsAndPrivacyScreen({Key key}) : super(key: key);

  @override
  State<TermsAndPrivacyScreen> createState() => _TermsAndPrivacyScreenState();
}

class _TermsAndPrivacyScreenState extends State<TermsAndPrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TermsAndPrivacyVm>(
        create: (context) => TermsAndPrivacyVm(),
        child: Consumer<TermsAndPrivacyVm>(builder: (context, vm, child) {
          return RbioStackedScaffold(
            appbar: RbioAppBar(
              title: Text(LocaleProvider.current.terms_and_privacy),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildApplicationContest(vm),
                _buildKVKK(vm)
              ],
            ),
          );
        }));
  }

  Widget _buildApplicationContest(TermsAndPrivacyVm value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Container(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
            width: 35,
            height: 35,
            child: Checkbox(
              value: true,
              onChanged: (newValue) {},
              activeColor: getIt<ITheme>().mainColor,
            ),
          ),
        ),

        //
        Expanded(
          child: TextButton(
            onPressed: () => value.showApplicationContestForm(),
            child: Text(
              LocaleProvider.of(context).accept_application_consent_form,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.xHeadline5.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKVKK(TermsAndPrivacyVm value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Container(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
            width: 35,
            height: 35,
            child: Checkbox(
              value: value.checkedKvkkForm,
              onChanged: (newValue) {
                value.checkedKvkkForm = newValue;
              },
              activeColor: getIt<ITheme>().mainColor,
            ),
          ),
        ),

        //
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextButton(
              onPressed: () => {value.showKvkkInfo()},
              child: Text(
                LocaleProvider.of(context).read_understood_kvkk,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: context.xHeadline5.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
