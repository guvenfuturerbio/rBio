import 'bootstrap.dart';
import 'core/core.dart';

Future<void> main() async {
  final config = GuvenConfig();
  await bootstrap(config);
}
