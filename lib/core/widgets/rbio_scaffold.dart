import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../core.dart';
import 'rbio_appbar_login.dart';

class RbioScaffold extends StatelessWidget {
  final IRbioAppBar appbar;
  final Widget body;

  // Optionals
  final Color backgroundColor;
  final Widget bottomNavigationBar;
  final Widget bottomSheet;
  final Widget drawer;
  final DragStartBehavior drawerDragStartBehavior;
  final double drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final Color drawerScrimColor;
  final Widget endDrawer;
  final bool endDrawerEnableOpenDragGesture;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Widget floatingActionButton;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final void Function(bool) onDrawerChanged;
  final void Function(bool) onEndDrawerChanged;
  final List<Widget> persistentFooterButtons;
  final bool primary;
  final bool resizeToAvoidBottomInset;
  final String restorationId;

  RbioScaffold({
    Key key,
    @required this.appbar,
    @required this.body,
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
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //
          ClipRRect(
            borderRadius: BorderRadius.vertical(
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
                      constraints: BoxConstraints(
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
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      drawerScrimColor: drawerScrimColor,
      endDrawer: endDrawer,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
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

  const RbioBody({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 1200),
      child: Padding(
        padding: R.sizes.screenPadding(context),
        child: child,
      ),
    );
  }
}
