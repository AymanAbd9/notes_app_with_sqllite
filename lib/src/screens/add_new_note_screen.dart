import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqllite/src/data_models/note.dart';
import 'package:sqllite/src/db/notes_database.dart';

class AddNewNoteScreenView extends StatefulWidget {
  const AddNewNoteScreenView({Key? key}) : super(key: key);

  @override
  _AddNewNoteScreenViewState createState() => _AddNewNoteScreenViewState();
}

class _AddNewNoteScreenViewState extends State<AddNewNoteScreenView> {
  late Note note;
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new note'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            noteTextField(),
            pickDateCardButton(),
            ElevatedButton(
                onPressed: () async {
                  // declare the new note
                  note = Note(title: titleController.text, date: selectedDate);

                  // create the new note
                  await NotesDatabase.instance.create(note);

                  // go back to notes screen
                  Navigator.of(context).pop();
                },
                child: const Text('Add note')),
          ],
        ),
      ),
    );
  }


  Widget noteTextField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: 'Note',
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.text,
          maxLines: 2,
        ),
      ),
    );
  }

  Widget pickDateCardButton() {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: dateController,
            decoration: const InputDecoration(
              hintText: 'Pick a date',
              border: InputBorder.none,
            ),
            enabled: false,
            keyboardType: TextInputType.text,
            maxLines: 2,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat.yMMMd().format(picked);
      });
    }
  }
}
