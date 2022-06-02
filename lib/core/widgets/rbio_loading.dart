import 'package:flutter/material.dart';

import '../core.dart';

class RbioLoading extends StatelessWidget {
  const RbioLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(getIt<IAppConfig>().theme.mainColor),
      ),
    );
  }

  static Widget progressIndicator([bool showLoadingIcon = true]) => Scaffold(
        backgroundColor: Colors.black38,
        body: showLoadingIcon
            ? const Center(child: RbioLoading())
            : const SizedBox(),
      );
}

class RbioWhiteLoading extends StatelessWidget {
  const RbioWhiteLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
