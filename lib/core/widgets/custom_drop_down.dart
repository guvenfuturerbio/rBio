import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../model/model.dart';
import '../core.dart';
import 'arrow_clipper.dart';

class CustomDropDown extends StatefulWidget {
  final List<Icon> icons;
  final List<TranslatorResponse> translators;
  final String selectedLanguage;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Color iconColor;
  final ValueChanged<int> onChange;

  const CustomDropDown({
    Key key,
    this.icons,
    this.borderRadius,
    this.backgroundColor = const Color(0xFFF67C0B9),
    this.iconColor = Colors.black,
    this.onChange,
    this.translators,
    this.selectedLanguage,
  })  : assert(icons != null),
        assert(translators != null),
        assert(selectedLanguage != null),
        super(key: key);
  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown>
    with SingleTickerProviderStateMixin {
  GlobalKey _key;
  bool isMenuOpen = false;
  Offset buttonPosition;
  Size buttonSize;
  OverlayEntry _overlayEntry;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    _overlayEntry.remove();
    _animationController.reverse();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    findButton();
    _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      key: _key,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: LinearGradient(colors: [
          R.color.online_appointment,
          R.color.light_online_appointment
        ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
      ),
      child: InkWell(
        onTap: () {
          if (isMenuOpen) {
            closeMenu();
          } else {
            openMenu();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: SvgPicture.asset(R.image.ic_translator),
              color: Colors.white,
              onPressed: () {},
            ),
            Text(
              widget.selectedLanguage == ""
                  ? LocaleProvider.of(context).get_translator
                  : widget.selectedLanguage,
              style: TextStyle(color: R.color.white),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: buttonSize.width,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipPath(
                    clipper: ArrowClipper(),
                    child: Container(
                      width: 17,
                      height: 17,
                      color: R.color.online_appointment,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: widget.icons.length * buttonSize.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            R.color.online_appointment,
                            R.color.light_online_appointment
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Theme(
                      data: ThemeData(
                        iconTheme: IconThemeData(
                          color: widget.iconColor,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                              List.generate(widget.translators.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                widget.onChange(index);
                                closeMenu();
                              },
                              child: Container(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.translators[index].language,
                                      style: TextStyle(color: R.color.white),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
