import 'dart:async';
import 'dart:developer';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:offline_poc_hive/data/models/dataset_config/dataset_model.dart';
import 'package:offline_poc_hive/data/models/filter/filter_model.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/dataset_config/dataset_column_model.dart';
import '../../models/record/record_model.dart';

late final Database dbSingleton;

class Database {
  var completer = Completer<Box<Record>>();

  Database() {
    _initDb();
  }

  Future _initDb() async {
    var appDocDirectory = await getApplicationDocumentsDirectory();

    Hive
      ..init(appDocDirectory.path)
      ..registerAdapter(RecordAdapter());

    final box = await Hive.openBox<Record>('registers');
    if (!completer.isCompleted) completer.complete(box);
    // clear();
  }

  Future clear() async {
    final box = await completer.future;
    await box.clear();
  }

  void saveDataset(Dataset dataset) {}

  Future<void> insertRandomRecords(
    Dataset dataset,
    int quantity,
  ) async {
    final box = await completer.future;
    final records = await compute<Map<String, int>, List<Record>>(
      _generateRandomRecords,
      <String, int>{
        'quantity': quantity,
        'startingIdx': box.values.length,
      },
    );
    log('Começou popular tabela ${DateTime.now().toIso8601String()}');

    box.addAll(records);
    Future.forEach(records, (record) => record.save());

    log('Terminou de popular tabela ${DateTime.now().toIso8601String()}');
  }

  Future<List<Record>> queryDataset(
    Dataset dataset,
    List<Filter> searchFilters,
  ) async {
    final box = (await completer.future);

    if (searchFilters.isEmpty) return box.values.toList();

    log('Começou pesquisar tabela ${DateTime.now().toIso8601String()}');
    final searchedRecords = box.values
        .where(
          (record) => searchFilters.any(
            (filter) =>
                record.uuidDataset == dataset.uuid &&
                record.mapColumnValues[filter.uuidCol] != null &&
                record.mapColumnValues[filter.uuidCol].contains(
                  filter.searchValue,
                ),
          ),
        )
        .toList()
        .unique((x) => x.pkValue)
        .sublist(0, 100);

    log('Terminou pesquisar tabela ${DateTime.now().toIso8601String()}');
    return searchedRecords;
  }
}

List<Record> _generateRandomRecords(Map<String, int> map) {
  final quantity = map['quantity']!;
  final startingIdx = map['startingIdx']!;
  return [
    for (var i = 0; i < quantity; i++)
      Record(
        uuidDataset: kExampleDatasetConfig.uuid,
        uuidPkColumn: kExampleDatasetConfig.uuidPkColumn,
        mapColumnValues: {
          for (final column in kExampleDatasetConfig.columns)
            column.uuid: column.uuid == kExampleDatasetConfig.uuidPkColumn
                ? i + startingIdx
                : _generateColumnValue(column.type),
        },
      )
  ];
}

_generateColumnValue(ColumnType type) {
  final nullValue = faker.randomGenerator.integer(10) > 7;
  if (nullValue) return null;
  switch (type) {
    case ColumnType.text:
    case ColumnType.location:
      return faker.lorem.sentence();
    case ColumnType.number:
      return faker.randomGenerator.decimal();
    case ColumnType.date:
      return faker.date.dateTime().toIso8601String();
    case ColumnType.selection:
      return "[${faker.lorem.sentence().split(' ').join(',')}]";
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
