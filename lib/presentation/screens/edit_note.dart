import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note_app_with_bloc/data/model/note_model.dart';
import 'package:note_app_with_bloc/presentation/widgets/edit_notes_widgets.dart';

class EditNote extends StatefulWidget {
  EditNote({Key? key, required this.noteModel}) : super(key: key);

  NoteModel noteModel;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  DateTime? date;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.noteModel.noteTitle!;
    descController.text = widget.noteModel.noteDesc!;
    date = widget.noteModel.noteDate!;
  }

  @override
  Widget build(BuildContext context) {
    final EditNotesWidgets editNotesWidgets = EditNotesWidgets(
        id: widget.noteModel.id,
        context: context,
        titleController: titleController,
        descController: descController,
        noteDate: date);
    return Scaffold(
      appBar: editNotesWidgets.appBar(),
      floatingActionButton: editNotesWidgets.floatingActionButton(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            editNotesWidgets.textField(isTitle: true),
            editNotesWidgets.textField(isTitle: false),
            editNotesWidgets.datePicker(),
          ],
        ),
      ),
    );
  }
}
