part of '../devices.dart';

class DeviceCard extends StatelessWidget {
  final Widget image;
  final String name;
  final Color background;
  final VoidCallback? onTap;
  final Widget? trailing;

  const DeviceCard({
    Key? key,
    required this.image,
    required this.name,
    required this.background,
    this.onTap,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Card(
            color: background,
            child: SizedBox(
              width: constraints.maxWidth,
              height: context.height * .1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    //
                    Expanded(
                      flex: 2,
                      child: image,
                    ),

                    //
                    Expanded(
                      flex: 5,
                      child: Text(
                        name,
                        style: context.xHeadline2,
                      ),
                    ),

                    //
                    if (trailing != null) trailing!,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
