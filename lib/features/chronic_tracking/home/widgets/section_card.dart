part of '../view/mt_home_screen.dart';

class _SectionCard extends StatelessWidget {
  final bool isVisible;
  final Widget smallChild;
  final bool hasDivider;

  const _SectionCard({
    Key? key,
    this.isVisible = true,
    required this.smallChild,
    this.hasDivider = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? Column(
            children: [
              //
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOutBack,
                height: (context.height * .12) *
                    (context.textScale > 1 ? (context.textScale / 2) : 1),
                width: context.width,
                child: smallChild,
              ),

              //
              if (hasDivider)
                const Divider(
                  thickness: 1,
                )
            ],
          )
        : const SizedBox();
  }
}
