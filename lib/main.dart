import 'core/core.dart';
import 'bootstrap.dart';

Future<void> main() async {
  final config = OneDoseConfig();
  await bootstrap(config);
}
