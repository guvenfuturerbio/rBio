part of '../devices.dart';

class DeviceCard extends StatelessWidget {
  final Widget image;
  final String name;
  final Color background;
  final VoidCallback onTap;
  final Widget trailing;
  const DeviceCard(
      {Key key,
      this.image,
      this.name,
      this.background,
      this.onTap,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(builder: (context, constraints) {
        return Card(
          color: background,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: SizedBox(
            width: constraints.maxWidth,
            height: context.HEIGHT * .1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(flex: 2, child: image),
                  Expanded(
                      flex: 5, child: Text(name, style: context.xHeadline2)),
                  if (trailing != null) trailing
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
