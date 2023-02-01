import 'package:flutter/material.dart';

import '../../../../data/local/db/database.dart';
import '../../../../data/models/dataset_config/dataset_model.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool dbBusy = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Ações',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // ListTile( //!not needed
          //   leading: dbBusy
          //       ? const CircularProgressIndicator(
          //           strokeWidth: 1,
          //         )
          //       : const Icon(Icons.data_object),
          //   title: const Text('Salvar dataset'),
          //   onTap: () async {
          //     if (dbBusy) return;
          //     setState(() {
          //       dbBusy = true;
          //     });
          //     await dbSingleton.saveDataset(kExampleDatasetConfig);
          //     setState(() {
          //       dbBusy = false;
          //     });
          //   },
          // ),
          ListTile(
            leading: dbBusy
                ? const CircularProgressIndicator(
                    strokeWidth: 1,
                  )
                : const Icon(Icons.insert_chart),
            title: const Text('Popular 1.000 registros'),
            onTap: () async {
              if (dbBusy) return;
              setState(() {
                dbBusy = true;
              });
              await dbSingleton.insertRandomRecords(
                kExampleDatasetConfig,
                1000,
              );
              setState(() {
                dbBusy = false;
              });
            },
          ),
          ListTile(
            leading: dbBusy
                ? const CircularProgressIndicator(
                    strokeWidth: 1,
                  )
                : const Icon(Icons.insert_drive_file),
            title: const Text('Popular 10.000 registros'),
            onTap: () async {
              if (dbBusy) return;
              setState(() {
                dbBusy = true;
              });
              await dbSingleton.insertRandomRecords(
                kExampleDatasetConfig,
                10000,
              );
              setState(() {
                dbBusy = false;
              });
            },
          ),
          ListTile(
            leading: dbBusy
                ? const CircularProgressIndicator(
                    strokeWidth: 1,
                  )
                : const Icon(Icons.account_circle),
            title: const Text('Popular 100.000 registros'),
            onTap: () async {
              if (dbBusy) return;
              setState(() {
                dbBusy = true;
              });
              await dbSingleton.insertRandomRecords(
                kExampleDatasetConfig,
                100000,
              );
              setState(() {
                dbBusy = false;
              });
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 20,
              child: dbBusy
                  ? const CircularProgressIndicator(
                      strokeWidth: 1,
                    )
                  : const Icon(Icons.account_circle),
            ),
            title: const Text('Popular 500.000 registros'),
            onTap: () async {
              if (dbBusy) return;
              setState(() {
                dbBusy = true;
              });
              await dbSingleton.insertRandomRecords(
                kExampleDatasetConfig,
                500000,
              );
              setState(() {
                dbBusy = false;
              });
            },
          ),
          const Divider(),
          // ListTile( //TODO! not needed
          //   leading: dbBusy
          //       ? const CircularProgressIndicator(
          //           strokeWidth: 1,
          //         )
          //       : const Icon(Icons.data_object),
          //   title: const Text('Salvar outro dataset'),
          //   onTap: () async {
          //     if (dbBusy) return;
          //     setState(() {
          //       dbBusy = true;
          //     });
          //     await dbSingleton.saveDataset(kExampleDatasetConfig);
          //     setState(() {
          //       dbBusy = false;
          //     });
          //   },
          // ),
          ListTile(
            leading: dbBusy
                ? const CircularProgressIndicator(
                    strokeWidth: 1,
                  )
                : const Icon(Icons.insert_chart),
            title: const Text('Popular 1.000 registros'),
            onTap: () async {
              if (dbBusy) return;
              setState(() {
                dbBusy = true;
              });
              await dbSingleton.insertRandomRecords(
                kExampleAnotherDatasetConfig,
                1000,
              );
              setState(() {
                dbBusy = false;
              });
            },
          ),
          ListTile(
            leading: dbBusy
                ? const CircularProgressIndicator(
                    strokeWidth: 1,
                  )
                : const Icon(Icons.insert_drive_file),
            title: const Text('Popular 10.000 registros'),
            onTap: () async {
              if (dbBusy) return;
              setState(() {
                dbBusy = true;
              });
              await dbSingleton.insertRandomRecords(
                kExampleAnotherDatasetConfig,
                10000,
              );
              setState(() {
                dbBusy = false;
              });
            },
          ),
          ListTile(
            leading: dbBusy
                ? const CircularProgressIndicator(
                    strokeWidth: 1,
                  )
                : const Icon(Icons.account_circle),
            title: const Text('Popular 100.000 registros'),
            onTap: () async {
              if (dbBusy) return;
              setState(() {
                dbBusy = true;
              });
              await dbSingleton.insertRandomRecords(
                kExampleAnotherDatasetConfig,
                100000,
              );
              setState(() {
                dbBusy = false;
              });
            },
          ),
          ListTile(
            leading: dbBusy
                ? const CircularProgressIndicator(
                    strokeWidth: 1,
                  )
                : const Icon(Icons.account_circle),
            title: const Text('Popular 500.000 registros'),
            onTap: () async {
              if (dbBusy) return;
              setState(() {
                dbBusy = true;
              });
              await dbSingleton.insertRandomRecords(
                kExampleAnotherDatasetConfig,
                500000,
              );
              setState(() {
                dbBusy = false;
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: dbBusy
                ? const CircularProgressIndicator(
                    strokeWidth: 1,
                  )
                : const Icon(Icons.account_circle),
            title: const Text('Deletar todo o banco'),
            onTap: () async {
              if (dbBusy) return;
              setState(() {
                dbBusy = true;
              });
              await dbSingleton.clear();
              setState(() {
                dbBusy = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
