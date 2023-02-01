import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:offline_poc_hive/data/models/dataset_config/dataset_model.dart';
import 'package:offline_poc_hive/data/models/record/record_model.dart';
import 'package:offline_poc_hive/presentation/screens/home/widgets/home_drawer_widget.dart';

import '../../../data/local/db/database.dart';
import '../../../data/models/dataset_config/dataset_column_model.dart';
import '../../../data/models/filter/filter_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController tec = TextEditingController();
  final dropDownValues = kExampleDatasetConfig.columns
      .map(
        (e) => DropdownMenuItem<DatasetColumn>(
          value: e,
          child: Text(e.title),
        ),
      )
      .toList();
  List<Record> recordsList = [];
  DatasetColumn selectedColumn = kExampleDatasetConfig.columns.first;
  List<Filter> searchFilters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive db test'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Container(
            height: constraints.maxHeight,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // const SystemInfo(),
                TextField(
                  controller: tec,
                ),
                DropdownButton(
                  items: dropDownValues,
                  onChanged: selectColumn,
                  value: selectedColumn,
                  selectedItemBuilder: (BuildContext context) {
                    return kExampleDatasetConfig.columns
                        .map<Widget>((DatasetColumn column) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        constraints: const BoxConstraints(minWidth: 100),
                        child: Text(
                          column.title,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList();
                  },
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          recordsList = [];
                        });

                        if (tec.text.isEmpty) {
                          return;
                        }

                        log('Selected Value: ${tec.text}');
                        log('Selected Column: ${selectedColumn.title}');

                        searchFilters.add(
                          Filter(
                            uuidCol: selectedColumn.uuid,
                            title: selectedColumn.title,
                            searchValue: tec.text,
                          ),
                        );

                        setState(() {
                          changeSearch();
                        });
                      },
                      child: const Text(
                        'Add search filter',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        searchFilters = [];

                        setState(() {
                          changeSearch();
                        });
                      },
                      child: const Text(
                        'clear search filters',
                      ),
                    ),
                  ],
                ),
                Wrap(
                  children: searchFilters
                      .map(
                        (e) => Chip(
                          label: Text(
                            '${e.title}: ${e.searchValue.toString()}',
                          ),
                        ),
                      )
                      .toList(),
                ),
                //query results
                Expanded(
                  child: RecordsList(
                    recordsList: recordsList,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: const HomeDrawer(),
    );
  }

  void selectColumn(DatasetColumn? column) {
    if (column == null) return;

    setState(() {
      selectedColumn = column;
    });
  }

  void changeSearch() async {
    //set state with search and recordList setter
    final records = await dbSingleton.queryDataset(
      kExampleDatasetConfig,
      searchFilters,
    );

    log(records.length.toString());

    setState(() {
      recordsList = records;
    });
  }
}

class RecordsList extends StatelessWidget {
  final List<Record> recordsList;

  const RecordsList({
    super.key,
    required this.recordsList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: recordsList.length,
      itemBuilder: (context, index) {
        final record = recordsList[index];
        final datasetColumnMap = kExampleColumns.asMap().map(
              (_, col) => MapEntry(col.uuid, col),
            );
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: record.mapColumnValues.entries
                  .map(
                    (entry) => Row(
                      children: [
                        Text('${datasetColumnMap[entry.key]!.title}: '),
                        Expanded(
                          child: Text(
                            entry.value is String
                                ? entry.value
                                : entry.value.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
