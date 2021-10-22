library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import '../model.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  GuvenLogin,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
