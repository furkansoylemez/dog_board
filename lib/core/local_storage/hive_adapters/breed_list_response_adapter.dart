import 'package:dog_board/data/model/breed_list_response.dart';
import 'package:hive/hive.dart';

class BreedListResponseAdapter extends TypeAdapter<BreedListResponse> {
  @override
  final int typeId = 0;

  @override
  BreedListResponse read(BinaryReader reader) {
    final raw = reader.read();
    final rawMap = Map<String, dynamic>.from(raw as Map);

    final message = rawMap.map(
      (key, value) =>
          MapEntry(key, List<String>.from(value as Iterable<dynamic>)),
    );

    final status = reader.read() as String;

    return BreedListResponse(
      message: message,
      status: status,
    );
  }

  @override
  void write(BinaryWriter writer, BreedListResponse obj) {
    writer
      ..write<Map<String, List<String>>>(obj.message)
      ..write<String>(obj.status);
  }
}
