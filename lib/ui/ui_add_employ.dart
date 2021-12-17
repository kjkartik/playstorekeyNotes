import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:keynotes/data/db_employ.dart';
import 'package:keynotes/ui/ui_worker_list_page.dart';
import 'package:intl/intl.dart';
import '../company_repository.dart';

class AddEmploy extends StatefulWidget {
  @override
  _AddEmployState createState() => _AddEmployState();
}

class _AddEmployState extends State<AddEmploy> {
  final workerListPage = WorkerListPage();
  final _repository = CompanyRepository();
  var nameController = TextEditingController();
  var fatherController = TextEditingController();
  var motherController = TextEditingController();
  var teshController = TextEditingController();
  date() {
    var date = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute,
            DateTime.now().second)
        .toString();
    return date;
  }

  Future<void> addKeyNotes() async {
    try {
      var id = DateTime.now().microsecondsSinceEpoch.toString();
      var nameEmploy = nameController.text;
      var father = fatherController.text;
      await _repository.addMember(
        Employ(
          id: id,
          notes: nameEmploy,
          date: date(),
        ),
      );
    } catch (e) {
      print(e);
      print('Something Went Wrong');
    }
  }

  Widget build(BuildContext context) {
    // time(){
    var time = DateTime.now().toString();
    new DateFormat('yyyy-MM-dd').toString();
    // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Add Notes'),
      ),
      body: Container(
        color: Colors.black38,
        child: Column(
          children: [
            SizedBox(
              height: 3,
            ),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(time),
            )),
            Expanded(
              flex: 1,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: nameController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            RaisedButton(
              onPressed: () {
                addKeyNotes();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
