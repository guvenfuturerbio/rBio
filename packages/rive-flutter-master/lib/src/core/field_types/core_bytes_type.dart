import 'dart:typed_data';

import '../../utilities/binary_buffer/binary_reader.dart';
import 'core_field_type.dart';

class CoreBytesType extends CoreFieldType<Uint8List> {
  @override
  Uint8List deserialize(BinaryReader reader) {
    var length = reader.readVarUint();
    return reader.read(length);
  }
}
