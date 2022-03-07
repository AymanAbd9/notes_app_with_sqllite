import 'package:flutter/material.dart';
import 'package:sqllite/src/data_models/note.dart';
import 'package:sqllite/src/db/notes_database.dart';
import 'package:intl/intl.dart';

class EditNoteScreenView extends StatefulWidget {
  const EditNoteScreenView({Key? key, required this.note}) : super(key: key);
  final Note note;
  @override
  _EditNoteScreenViewState createState() => _EditNoteScreenViewState();
}

class _EditNoteScreenViewState extends State<EditNoteScreenView> {
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.note.title;
    dateController.text = widget.note.date.toString();
    selectedDate = widget.note.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit note'),
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
                  final note = widget.note.copyWith(
                    title: titleController.text,
                    date: selectedDate,
                  );

                  // update note
                  await NotesDatabase.instance.update(note);

                  // go back to notes screen
                  Navigator.of(context).pop();
                },
                child: const Text('Update')),
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
        dateController.text = DateFormat.yMMMd().format(picked).toString();
      });
    }
  }
}
