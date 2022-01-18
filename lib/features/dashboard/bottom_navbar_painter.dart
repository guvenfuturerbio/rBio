import 'package:flutter/material.dart';

class BottomNavbarCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/*
int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget _buildBottomNavigationBar() {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.transparent,
        width: size.width,
        height: 80,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            //
            CustomPaint(
              size: Size(size.width, 80),
              painter: BNBCustomPainter(),
            ),

            //
            Center(
              heightFactor: 0.8,
              child: FloatingActionButton(
                backgroundColor: Colors.orange,
                child: Icon(Icons.shopping_basket),
                elevation: 0.1,
                onPressed: () {},
              ),
            ),

            //
            Container(
              width: size.width,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: currentIndex == 0
                          ? Colors.orange
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setBottomBarIndex(0);
                    },
                    splashColor: Colors.white,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.restaurant_menu,
                      color: currentIndex == 1
                          ? Colors.orange
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setBottomBarIndex(1);
                    },
                  ),
                  Container(
                    width: size.width * 0.20,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.bookmark,
                      color: currentIndex == 2
                          ? Colors.orange
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setBottomBarIndex(2);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: currentIndex == 3
                          ? Colors.orange
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setBottomBarIndex(3);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
*/