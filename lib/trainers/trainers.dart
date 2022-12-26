import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:veri_tabani_proje/main.dart';
import 'package:veri_tabani_proje/sql/trainer_sql.dart';
import 'package:veri_tabani_proje/trainers/add_trainers.dart';
import 'package:veri_tabani_proje/trainers/trainer_model.dart';

class Trainers extends StatefulWidget {
  const Trainers({super.key});

  @override
  State<Trainers> createState() => _TrainersState();
}

class _TrainersState extends State<Trainers> {
  final trainersDatabase = TrainerDatabase();
  bool isLoading = false;
  List<Trainer> trainers = [];
  bool isQuery = false;
  late final TrainerDataSource dataSoruce;

  Future getAllDatas() async {
    setLoading();
    await trainersDatabase.initializeDatabase();

    trainers = await trainersDatabase.getAllTrainer();
    dataSoruce = TrainerDataSource(trainers: trainers);

    setLoading();
  }

  setLoading() {
    isLoading = !isLoading;
    setState(() {});
  }

  changeQueryStatus() {
    isQuery = !isQuery;
    setState(() {});
  }

  Future getIdQuery(int id) async {
    trainers = await trainersDatabase.queryID(id);
    setState(() {});
  }

  Future getSalaryQuery(int id) async {
    trainers = await trainersDatabase.quetySalary(id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getAllDatas();
  }

  final style = const TextStyle(fontSize: 14, fontWeight: FontWeight.w800);
  List<TableRow> get datas => trainers
      .map((e) => TableRow(children: [
            Text(e.id.toString()),
            Text(e.name),
            Text(e.salary),
            Text(e.year),
            // Text(e.profession),
          ]))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: changeQueryStatus,
        child: const Icon(Icons.query_stats_sharp),
      ),
      appBar: globalAppBar(
          title: 'Trainers',
          colors: Colors.red[200],
          icon: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTrainers(
                        trainersDatabase: trainersDatabase,
                      ),
                    ));
              },
              icon: const Icon(Icons.add))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          if (isQuery)
            Column(
              children: [
                Row(
                  children: [
                    const Text('id: '),
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('id'),
                        ),
                        onFieldSubmitted: (value) async {
                          await getIdQuery(int.parse(value));
                        },
                      ),
                    ),
                    const SizedBox(width: 25),
                    const Text('salary: '),
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Salary'),
                        ),
                        onFieldSubmitted: (value) async {
                          await getSalaryQuery(int.parse(value));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 10),
          isLoading
              ? const CircularProgressIndicator.adaptive()
              : Expanded(
                  child: SfDataGrid(
                    source: dataSoruce,
                    columnWidthMode: ColumnWidthMode.fill,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'id',
                          label: Container(
                              padding: const EdgeInsets.all(16.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'ID',
                              ))),
                      GridColumn(
                          columnName: 'name',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Name'))),
                      GridColumn(
                          columnName: 'year',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'Year',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          columnName: 'salary',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Salary'))),
                      GridColumn(
                          columnName: 'profession',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'Profession',
                                overflow: TextOverflow.ellipsis,
                              ))),
                    ],
                  ),
                ),
        ]),
      ),
    );
  }
}

class TrainerDataSource extends DataGridSource {
  TrainerDataSource({required List<Trainer> trainers}) {
    _trainers = trainers
        .map((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'year', value: e.year),
              DataGridCell<String>(columnName: 'salary', value: e.salary),
              DataGridCell<String>(columnName: 'profession', value: e.profession),
            ]))
        .toList();
  }

  List<DataGridRow> _trainers = [];

  @override
  List<DataGridRow> get rows => _trainers;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
