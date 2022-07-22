import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import 'terms_and_privacy_vm.dart';

class TermsAndPrivacyScreen extends StatelessWidget {
  const TermsAndPrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TermsAndPrivacyVm>(
      create: (context) => TermsAndPrivacyVm(),
      child: Consumer<TermsAndPrivacyVm>(
        builder: (BuildContext context, TermsAndPrivacyVm vm, Widget? child) {
          return RbioStackedScaffold(
            appbar: _buildAppBar(context),
            body: _buildBody(context, vm),
          );
        },
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      context: context,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.terms_and_privacy,
      ),
    );
  }

  Column _buildBody(BuildContext context, TermsAndPrivacyVm vm) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildApplicationContest(context, vm),
        _buildKVKK(context, vm),
      ],
    );
  }

  Widget _buildApplicationContest(
    BuildContext context,
    TermsAndPrivacyVm value,
  ) {
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
            child: RbioCheckbox(
              value: true,
              onChanged: (newValue) {},
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

  Widget _buildKVKK(BuildContext context, TermsAndPrivacyVm value) {
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
            child: RbioCheckbox(
              value: value.checkedKvkk,
              onChanged: (newValue) {
                if (newValue != null) {
                  value.setCheckedKvkk(newValue);
                }
              },
            ),
          ),
        ),

        //
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextButton(
              onPressed: () => {value.showKvkkInfo(context)},
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
