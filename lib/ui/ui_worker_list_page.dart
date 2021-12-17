import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keynotes/data/db_employ.dart';
import 'package:keynotes/ui/ui_add_employ.dart';
import 'package:keynotes/ui/ui_worker_detail_page.dart';

import '../company_repository.dart';
// mport 'package:flutter_bloc/flutter_bloc.dart';

class WorkerListPage extends StatefulWidget {
  @override
  _WorkerListPageState createState() => _WorkerListPageState();
}

class _WorkerListPageState extends State<WorkerListPage> {
  final _repository = CompanyRepository();
  late List<Employ> noteList;
  late bool _loading;

  Future<void> loadData() async {
    print('Enter in load data setState');
    try {
      var list = await _repository.getCompanyList();
      setState(() {
        noteList = list!;
        // list = workerList;
      });
    } catch (e) {
      // TODO
      print(e);
      print("Failed to LoadData");
    }
  }

  Future<int?> deleteData(String id) async {
    try {
      await _repository.deleteKeyNotes(id);
      print(id);
      print('delete Data');
      _loading = false;
      loadData();
    } catch (e) {
      print(e);
      print('error');
    }
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    final DateTime id = DateTime.fromMillisecondsSinceEpoch(1546553448639);
    loadData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 44, 57, 1),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEmploy(),
                ),
              );
              loadData();
            },
          ),
        ],
        title: Text('Notes List'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: null == noteList ? 0 : noteList.length,
          itemBuilder: (context, index) {
            Employ workers = noteList[index];
            showAlertDialog(BuildContext context) {
              // set up the button

              AlertDialog alert = AlertDialog(
                title: Text("key Notes"),
                content: Text("Are You Sure Want To Delete"),
                actions: [
                  TextButton(
                    child: Text('Cancle'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text("Delete"),
                    onPressed: () {
                      deleteData(workers.id);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );

              // show the dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }

            return Card(
              color: Color.fromRGBO(33, 44, 57, 1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  trailing: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.lightGreenAccent,
                          ),
                          onPressed: () {
                            showAlertDialog(context);
                          },
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    workers.notes.trim(),
                    style: const TextStyle(fontSize: (20), color: Colors.white),
                  ),
                  subtitle: Text(
                    workers.date,
                    style: const TextStyle(fontSize: (14), color: Colors.white),
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkerDetailPage(),
                      ),
                    );
                    loadData();
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
