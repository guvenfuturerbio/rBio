import 'bootstrap.dart';
import 'config/config.dart';

Future<void> main() async {
  final config = OneDoseConfig();
  await bootstrap(config);
}
