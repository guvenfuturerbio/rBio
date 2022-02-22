import 'package:flutter/material.dart';

class RbioOverlayMenu extends StatefulWidget {
  final Color color;
  final Widget separator;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry margin;
  final List<Widget> tiles;

  const RbioOverlayMenu({
    Key? key,
    required this.color,
    required this.separator,
    required this.borderRadius,
    required this.margin,
    required this.tiles,
  }) : super(key: key);

  @override
  _RbioOverlayMenuState createState() => _RbioOverlayMenuState();
}

class _RbioOverlayMenuState extends State<RbioOverlayMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeTransition;
  late Animation<Offset> _slideAnimation;

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
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );

    _slideAnimation = Tween(
      begin: const Offset(.5, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
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
    _animationController.dispose();

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
        boxShadow: const <BoxShadow>[
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
