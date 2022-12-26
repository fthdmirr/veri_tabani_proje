import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:veri_tabani_proje/main.dart';
import 'package:veri_tabani_proje/member/add_member.dart';
import 'package:veri_tabani_proje/member/member_model.dart';
import 'package:veri_tabani_proje/sql/member_sql.dart';

class Members extends StatefulWidget {
  const Members({super.key});

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  final membersDatabase = MemberDatabase();
  bool isLoading = false;
  List<Member> members = [];
  late final MemberDataSource dataSoruce;
  bool isQuery = false;

  changeQueryStatus() {
    isQuery = !isQuery;
    setState(() {});
  }

  Future getAllDatas() async {
    setLoading();
    members = await membersDatabase.getAllMember();
    dataSoruce = MemberDataSource(members: members);
    setLoading();
  }

  setLoading() {
    isLoading = !isLoading;
    setState(() {});
  }

  Future getHeightQuery(int height) async {
    members = await membersDatabase.queryHeight(height);
    setState(() {});
  }

  Future getWeightQuery(int height) async {
    members = await membersDatabase.queryWeight(height);
    setState(() {});
  }

  Future getNameQuery(String name) async {
    members = await membersDatabase.queryName(name);
    setState(() {});
  }

  Future getQueryStatus(String name) async {
    members = await membersDatabase.queryStatus(name);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllDatas();
  }

  final style = const TextStyle(fontSize: 14, fontWeight: FontWeight.w800);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: changeQueryStatus,
        child: const Icon(Icons.query_stats_sharp),
      ),
      appBar: globalAppBar(
          title: 'Members',
          colors: Colors.blue[200],
          icon: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMembers(membersDatabase: membersDatabase),
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
                    const Text('height: '),
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Height'),
                        ),
                        onFieldSubmitted: (value) async {
                          await getHeightQuery(int.parse(value));
                        },
                      ),
                    ),
                    const SizedBox(width: 25),
                    const Text('weight: '),
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Weight'),
                        ),
                        onFieldSubmitted: (value) async {
                          await getWeightQuery(int.parse(value));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('name: '),
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Name'),
                        ),
                        onFieldSubmitted: (value) async {
                          await getNameQuery(value);
                        },
                      ),
                    ),
                    const SizedBox(width: 25),
                    const Text('status: '),
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Status'),
                        ),
                        onFieldSubmitted: (value) async {
                          await getQueryStatus(value);
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
                          columnWidthMode: ColumnWidthMode.fill,
                          columnName: 'id',
                          label: Container(
                              padding: const EdgeInsets.all(16.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'ID',
                                style: TextStyle(fontSize: 12.5),
                              ))),
                      GridColumn(
                          columnWidthMode: ColumnWidthMode.fill,
                          columnName: 'name',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'Name',
                                style: TextStyle(fontSize: 12.5),
                              ))),
                      GridColumn(
                          columnWidthMode: ColumnWidthMode.fill,
                          columnName: 'height',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'Height',
                                style: TextStyle(fontSize: 12.5),
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          columnWidthMode: ColumnWidthMode.fill,
                          columnName: 'weight',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'Weight',
                                style: TextStyle(fontSize: 12.5),
                              ))),
                      GridColumn(
                          columnWidthMode: ColumnWidthMode.fill,
                          columnName: 'phone',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'Phone',
                                style: TextStyle(fontSize: 12.5),
                              ))),
                      GridColumn(
                          columnWidthMode: ColumnWidthMode.fill,
                          columnName: 'trainer',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'Trainer',
                                style: TextStyle(fontSize: 12.5),
                              ))),
                    ],
                  ),
                ),
        ]),
      ),
    );
  }
}

class MemberDataSource extends DataGridSource {
  MemberDataSource({required List<Member> members}) {
    _members = members
        .map((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'height', value: e.height),
              DataGridCell<String>(columnName: 'weight', value: e.weight),
              DataGridCell<String>(columnName: 'phone number', value: e.phone),
              DataGridCell<String>(columnName: 'status', value: e.status),
            ]))
        .toList();
  }

  List<DataGridRow> _members = [];

  @override
  List<DataGridRow> get rows => _members;

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
