import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/database/database_provider.dart';
import '../../data/model/note_model.dart';
import '../../logic/cubit/notes_cubit.dart';
import '../widgets/new_notes.widgets.dart';

class NewNote extends StatelessWidget {
  const NewNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    final NewNotesWidgets newNotesWidgets = NewNotesWidgets(
        context: context,
        titleController: titleController,
        descController: descController);

    return Scaffold(
      appBar: newNotesWidgets.appBar(),
      floatingActionButton: newNotesWidgets.floatingActionButton(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              newNotesWidgets.textField(isTitle: true),
              newNotesWidgets.textField(isTitle: false),
              newNotesWidgets.datePicker(),
            ],
          ),
        ),
      )),
    );
  }
}
