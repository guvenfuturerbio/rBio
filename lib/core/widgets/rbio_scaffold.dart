import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../core.dart';

class RbioScaffold extends StatelessWidget {
  final Key? scaffoldKey;
  final IRbioAppBar appbar;
  final Widget body;

  // Optionals
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Widget? drawer;
  final DragStartBehavior? drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool? drawerEnableOpenDragGesture;
  final Color? drawerScrimColor;
  final Widget? endDrawer;
  final bool? endDrawerEnableOpenDragGesture;
  final bool? extendBody;
  final bool? extendBodyBehindAppBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final void Function(bool)? onDrawerChanged;
  final void Function(bool)? onEndDrawerChanged;
  final List<Widget>? persistentFooterButtons;
  final bool? primary;
  final bool? resizeToAvoidBottomInset;
  final String? restorationId;

  const RbioScaffold({
    Key? key,
    this.scaffoldKey,
    required this.appbar,
    required this.body,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.drawer,
    this.drawerDragStartBehavior,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture,
    this.drawerScrimColor,
    this.endDrawer,
    this.endDrawerEnableOpenDragGesture,
    this.extendBody,
    this.extendBodyBehindAppBar,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.onDrawerChanged,
    this.onEndDrawerChanged,
    this.persistentFooterButtons,
    this.primary,
    this.resizeToAvoidBottomInset,
    this.restorationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        children: [
          //
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
            child: SizedBox(
              height: 64 + MediaQuery.of(context).viewPadding.top,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  //
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: getIt<ITheme>().mainColor,
                      ),
                    ),
                  ),

                  //
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 1176,
                      ),
                      child: appbar,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //
          Expanded(
            child: RbioBody(
              child: body,
            ),
          ),
        ],
      ),

      //
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      drawer: drawer,
      drawerDragStartBehavior:
          drawerDragStartBehavior ?? DragStartBehavior.start,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture ?? true,
      drawerScrimColor: drawerScrimColor,
      endDrawer: endDrawer,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture ?? true,
      extendBody: extendBody ?? false,
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
      floatingActionButton: floatingActionButton,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      floatingActionButtonLocation: floatingActionButtonLocation,
      onDrawerChanged: onDrawerChanged,
      onEndDrawerChanged: onEndDrawerChanged,
      persistentFooterButtons: persistentFooterButtons,
      primary: primary ?? true,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      restorationId: restorationId,
    );
  }
}

class RbioBody extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const RbioBody({
    Key? key,
    required this.child,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: RbioLoadingOverlay(
        child: Padding(
          padding: R.sizes.screenPadding(context),
          child: child,
        ),
        isLoading: isLoading,
        progressIndicator: RbioLoading.progressIndicator(),
        opacity: 0,
      ),
    );
  }
}
