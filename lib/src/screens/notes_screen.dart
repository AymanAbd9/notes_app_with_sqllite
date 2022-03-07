import 'package:flutter/material.dart';
import 'package:sqllite/src/data_models/note.dart';
import 'package:sqllite/src/db/notes_database.dart';
import 'package:sqllite/src/screens/add_new_note_screen.dart';
import 'package:sqllite/src/screens/edit_note_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotesScreenView extends StatefulWidget {
  const NotesScreenView({Key? key}) : super(key: key);

  @override
  State<NotesScreenView> createState() => _NotesScreenViewState();
}

class _NotesScreenViewState extends State<NotesScreenView> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    super.dispose();
    NotesDatabase.instance.close();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: addNewNoteButton(),
      appBar: AppBar(
        title: const Text('Notes'),
        // actions: const [
        //   ChangeThemeButtonWidget(),
        // ],
        centerTitle: true,
      ),
      body: isLoading
          ? const CircularProgressIndicator()
          : notes.isEmpty
              ? const Center(child: Text('no notes'))
              : Container(
                  alignment: Alignment.center,
                  child: buildNotes(),
                ),
    );
  }

  Widget buildNotes() => ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditNoteScreenView(note: note),
              ));

              refreshNotes();
            },
            child: noteCardWidget(note: note),
          );
        },
      );

  Widget noteCardWidget({required Note note}) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      child: Container(
        //margin: EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Slidable(
          key: ValueKey(note.id),
          child: ListTile(
            title: Text(note.title),
            subtitle: Text(DateFormat.yMMMd().format(note.date).toString()),
            // trailing: IconButton(
            //     icon: const Icon(Icons.delete, color: Colors.red),
            //     onPressed: () async {
            //       await NotesDatabase.instance.delete(note.id!);
            //       refreshNotes();
            //     }),
          ),
          endActionPane: ActionPane(
            dismissible: DismissiblePane(
              onDismissed: () async {
                await NotesDatabase.instance.delete(note.id!);
                refreshNotes();
              },
            ),
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) async {
                  await NotesDatabase.instance.delete(note.id!);
                  refreshNotes();
                },
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: 'delete',
              ),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton addNewNoteButton() {
    return FloatingActionButton(
      onPressed: () async {
        // added the await keyword to push function to update the screen after the note had been created
        await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddNewNoteScreenView()));
        refreshNotes();
      },
      child: const Icon(Icons.add),
    );
  }
}
