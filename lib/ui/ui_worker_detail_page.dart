import 'package:flutter/material.dart';
import 'package:keynotes/data/db_employ.dart';
import 'package:keynotes/ui/ui_edit_employ.dart';

import '../company_repository.dart';

class WorkerDetailPage extends StatefulWidget {
  @override
  _WorkerDetailPageState createState() => _WorkerDetailPageState();
}

class _WorkerDetailPageState extends State<WorkerDetailPage> {
  // final employ = Employ(names: '');
  final _repository = CompanyRepository();
  late List<Employ> workerList;
  late bool _loading;

  // class _loadData

  Future<void> _loadData() async {
    var employList = await _repository.getCompanyList();
    setState(() {
      workerList = employList!;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail of Notes'),
        backgroundColor: Color.fromRGBO(33, 44, 57, 1),
      ),
      body: Container(
        color: Colors.grey,
        child: ListView.builder(
          itemCount: null == workerList ? 0 : workerList.length,
          itemBuilder: (context, index) {
            Employ workerDetail = workerList[index];
            return Column(
              children: [
                Card(
                  color: Colors.brown,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(workerDetail.notes),
                          subtitle: Text(workerDetail.date),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditNotes(
                                  getNotesData: workerDetail,
                                ),
                              ),
                            );
                            _loadData();
                          },
                        ),
                        Text(
                          "Edit",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                // RaisedButton(
                //   onPressed: () async {
                //     await Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => EditEmploy(
                //           getWorkerData: workerDetail,
                //         ),
                //       ),
                //     );
                //     _loadData();
                //   },
                //   child: Text('Edit'),
                // )
              ],
            );
          },
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      // ),
    );
  }
}
