import '../../utilities/binary_buffer/binary_reader.dart';
import 'core_field_type.dart';

class CoreUintType extends CoreFieldType<int> {
  @override
  int deserialize(BinaryReader reader) => reader.readVarUint();
}
