import 'package:flutter/material.dart';

class RbioOverlayMenu extends StatefulWidget {
  final Color color;
  final Widget separator;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry margin;
  final List<Widget> tiles;

  const RbioOverlayMenu({
    Key key,
    this.color,
    this.separator,
    this.borderRadius,
    this.margin,
    this.tiles,
  }) : super(key: key);

  @override
  _RbioOverlayMenuState createState() => _RbioOverlayMenuState();
}

class _RbioOverlayMenuState extends State<RbioOverlayMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _fadeTransition;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _fadeTransition = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );

    _slideAnimation = Tween(
      begin: Offset(.5, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.reset();
    _animationController.forward();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: widget.borderRadius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, __) => widget.separator,
        itemCount: widget.tiles.length,
        itemBuilder: (BuildContext context, int index) {
          return ClipRect(
            child: FadeTransition(
              opacity: _fadeTransition,
              child: SlideTransition(
                position: _slideAnimation,
                child: widget.tiles[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
