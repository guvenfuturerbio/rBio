import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../core.dart';

class RbioStackedScaffold extends StatelessWidget {
  final RbioAppBar? appbar;
  final Widget body;
  final bool isLoading;
  final bool showLoadingIcon;

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

  const RbioStackedScaffold({
    Key? key,
    this.appbar,
    required this.body,
    this.isLoading = false,
    this.showLoadingIcon = true,
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

  static double kHeight(BuildContext context) =>
      (64 + MediaQuery.of(context).viewPadding.top);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          //
          RbioBody(
            child: body,
            isLoading: isLoading,
            showLoadingIcon: showLoadingIcon,
          ),

          //
          if (appbar != null)
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: R.sizes.radiusCircular,
              ),
              child: SizedBox(
                height: kHeight(context),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    //
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: getIt<IAppConfig>().theme.mainColor,
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
