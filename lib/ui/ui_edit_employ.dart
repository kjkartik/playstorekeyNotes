import 'package:flutter/material.dart';
import 'package:keynotes/data/db_employ.dart';

import '../company_repository.dart';

class EditNotes extends StatefulWidget {
  final Employ getNotesData;

  const EditNotes({
    required this.getNotesData,
  }) : super();

  @override
  _EditNotesState createState() => _EditNotesState(getNotesData);
}

class _EditNotesState extends State<EditNotes> {
  final _repository = CompanyRepository();
  final Employ worker;
  var notesController = TextEditingController();
  var idController = TextEditingController();
  var fatherController = TextEditingController();
  var motherController = TextEditingController();

  _EditNotesState(this.worker);
  @override
  void initState() {
    super.initState();
    setState(() {
      motherController.text = widget.getNotesData.id;
      notesController.text = widget.getNotesData.notes;
      idController.text = widget.getNotesData.id;
    });
  }

  date() {
    var dates = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute,
            DateTime.now().second)
        .toString();
    return dates;
  }

  Future<String> editMember() async {
    // try {
    var notes = notesController.text;
    var id = idController.text;
    var done = _repository.updateMember(Employ(
      date: date(),
      id: id,
      notes: notes,
    ));
    return done;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Edit Notes '),
      ),
      body: Container(
        color: Colors.black38,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                ),
                controller: notesController,
              ),
              const SizedBox(
                height: 5,
              ),
              RaisedButton(
                onPressed: () {
                  editMember();
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
