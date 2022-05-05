import 'core/core.dart';
import 'bootstrap.dart';

Future<void> main() async {
  final config = GuvenConfig();
  await bootstrap(config);
}
