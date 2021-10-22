import 'package:flutter/material.dart';

import '../core.dart';

class GradientDialog extends StatefulWidget {
  final String title;
  final String text;
  final bool hasScrollable;

  GradientDialog(this.title, this.text, {this.hasScrollable = false});

  @override
  _GradientDialogState createState() => _GradientDialogState();
}

class _GradientDialogState extends State<GradientDialog> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text(LocaleProvider.of(context).Ok),
      textColor: Colors.white,
      onPressed: () {
        widget.text == LocaleProvider.of(context).succefully_created_pass
            ? Atom.to(PagePaths.MAIN)
            : Atom.pop();
      },
    );

    return GuvenAlert(
      title: Text(
        widget.title,
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      actions: [
        okButton,
      ],
      content: Container(
        padding: const EdgeInsets.all(16.0),
        /*decoration: new BoxDecoration(
            gradient: BlueGradient()),*/
        child: !widget.hasScrollable
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(widget.text,
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )),
                ],
              )
            : SingleChildScrollView(
                child: new Text(widget.text,
                    style: new TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Roboto',
                      color: Colors.white,
                    )),
              ),
      ),
    );
  }

  Gradient BlueGradient() => LinearGradient(
      colors: [R.color.blue, R.color.light_blue],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
}
