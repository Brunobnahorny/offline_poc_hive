import 'package:hive/hive.dart';

part 'record_model.g.dart';

@HiveType(typeId: 2)
class Record extends HiveObject {
  @HiveField(0)
  final String uuidDataset;

  @HiveField(1)
  final String uuidPkColumn;
  String get pkValue => mapColumnValues[uuidPkColumn]!.toString();

  @HiveField(2, defaultValue: {})
  final Map<String, dynamic> mapColumnValues;

  Record({
    required this.uuidDataset,
    required this.uuidPkColumn,
    required this.mapColumnValues,
  });
}
