import 'package:flutter/material.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../../../../core/core.dart';

class ForYouInformationDialog extends StatelessWidget {
  const ForYouInformationDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: R.color.blue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Text(
                LocaleProvider.current.information,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              //
              Divider(),

              //
              SizedBox(height: 10),

              //
              Text(
                LocaleProvider.current.addcart_success_message,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              //
              SizedBox(height: 10),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  Expanded(
                    child: FlatButton(
                      child: Text(
                        LocaleProvider.current.yes,
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.green,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                        Atom.to(PagePaths.SHOPPING_CART);
                      },
                    ),
                  ),

                  //
                  SizedBox(
                    width: 6,
                  ),

                  //
                  Expanded(
                    child: FlatButton(
                      child: Text(
                        LocaleProvider.current.no,
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.red,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
