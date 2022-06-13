part of 'atom_instance.dart';

class _AtomBaseDialog extends StatelessWidget {
  final Widget child;
  final Color barrierColor;
  final bool barrierDismissible;

  const _AtomBaseDialog({
    Key? key,
    required this.child,
    required this.barrierColor,
    required this.barrierDismissible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeroControllerScope(
      controller: MaterialApp.createMaterialHeroController(),
      child: Navigator(
        onGenerateRoute: (context) {
          return MaterialPageRoute(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  if (barrierDismissible) {
                    Atom.dismiss();
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: barrierColor,
                  child: GestureDetector(
                    onTap: () {},
                    child: child,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
