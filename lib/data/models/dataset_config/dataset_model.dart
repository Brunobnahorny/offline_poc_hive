import 'dart:convert';

import 'package:hive/hive.dart';

import 'dataset_column_model.dart';
part 'dataset_model.g.dart';

const _kDatasetUuid = 'c5b61220-0122-479c-bf0f-f1c511cd22bf';
const _kAnotherDatasetUuid = '8e72ec6c-b9a2-4d1a-973c-0c0dcc04b9a9';

final kExampleDatasetConfig = Dataset(
  uuid: _kDatasetUuid,
  uuidPkColumn: pkColumn,
  title: 'Dataset de exemplo',
  columns: kExampleColumns,
);

final kExampleAnotherDatasetConfig = Dataset(
  uuid: _kAnotherDatasetUuid,
  uuidPkColumn: anotherPkColumn,
  title: 'Dataset não pesquisável',
  columns: kAnotherExampleColumns,
);

@HiveType(typeId: 1)
class Dataset extends HiveObject {
  @HiveField(0)
  final String uuid;

  @HiveField(1, defaultValue: '')
  final String title;

  @HiveField(2)
  final String uuidPkColumn;

  @HiveField(3)
  final List<DatasetColumn> columns;

  Dataset({
    required this.uuid,
    required this.uuidPkColumn,
    required this.title,
    required this.columns,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'pk_column': pkColumn,
      'title': title,
      'columns': columns.map((x) => x.toMap()).toList(),
    };
  }

  factory Dataset.fromMap(Map<String, dynamic> map) {
    return Dataset(
      uuid: map['uuid'] as String,
      uuidPkColumn: map['pk_column'] as String,
      title: map['title'] as String,
      columns: List<DatasetColumn>.from(
        (map['columns'] as List<int>).map<DatasetColumn>(
          (x) => DatasetColumn.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Dataset.fromJson(String source) =>
      Dataset.fromMap(json.decode(source) as Map<String, dynamic>);
}
