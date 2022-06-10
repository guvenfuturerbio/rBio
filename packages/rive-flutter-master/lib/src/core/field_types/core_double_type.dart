import '../../utilities/binary_buffer/binary_reader.dart';
import 'core_field_type.dart';

class CoreDoubleType extends CoreFieldType<double> {
  @override
  double deserialize(BinaryReader reader) => reader.readFloat32();
}
