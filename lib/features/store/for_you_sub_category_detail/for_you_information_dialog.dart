import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ForYouInformationDialog extends StatelessWidget {
  const ForYouInformationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: getIt<ITheme>().mainColor,
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Text(
                LocaleProvider.current.information,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              //
              const Divider(),

              //
              const SizedBox(height: 10),

              //
              Text(
                LocaleProvider.current.addcart_success_message,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              //
              const SizedBox(height: 10),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  Expanded(
                    child: RbioTextButton(
                      child: Text(
                        LocaleProvider.current.yes,
                        style: context.xHeadline3.copyWith(
                          color: Colors.green,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                        Atom.to(PagePaths.shoppingChart);
                      },
                    ),
                  ),

                  //
                  const SizedBox(
                    width: 6,
                  ),

                  //
                  Expanded(
                    child: RbioTextButton(
                      child: Text(
                        LocaleProvider.current.no,
                        style: context.xHeadline3.copyWith(
                          color: Colors.red,
                        ),
                      ),
                      backgroundColor: Colors.white,
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
