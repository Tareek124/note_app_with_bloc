import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../constants/colors.dart';
import '../../data/model/note_model.dart';
import '../../logic/cubit/notes_cubit.dart';

class EditNotesWidgets {
  final BuildContext context;
  final TextEditingController titleController;
  final TextEditingController descController;
  DateTime? noteDate;
  int? id;

  EditNotesWidgets(
      {required this.context,
      required this.titleController,
      required this.descController,
      required this.noteDate,
      required this.id});

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: MyColors.mintGreen,
      title: const Text(
        "Edit Note",
        style: TextStyle(fontFamily: "myFont"),
      ),
    );
  }

  Widget floatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        BlocProvider.of<NotesCubit>(context).editNote(NoteModel(
            id: id,
            noteTitle: titleController.text,
            noteDesc: descController.text,
            noteDate: noteDate));

        Navigator.pop(context);
      },
      label: const Text(
        "Edit Note",
        style: TextStyle(fontFamily: "myFont"),
      ),
      icon: const Icon(Icons.create),
      backgroundColor: MyColors.mintGreen,
    );
  }

  Widget textField({required bool isTitle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: TextFormField(
        maxLines: isTitle ? 2 : 15,
        controller: isTitle ? titleController : descController,
        style: const TextStyle(
            fontSize: 18,
            fontFamily: "myFont",
            color: MyColors.royalBlue,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          icon:
              isTitle ? const Icon(Icons.title) : const Icon(Icons.description),
          hintText: isTitle ? "Note Title" : " Note Description",
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(11))),
        ),
        onChanged: (value) {},
      ),
    );
  }

  Widget datePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Pick Date-->",
          style: TextStyle(fontSize: 21, fontFamily: "myFont"),
        ),
        TextButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime(3000, 6, 7),
                  onChanged: (date) {}, onConfirm: (value) {
                value == null ? noteDate = DateTime.now() : noteDate = value;
              }, currentTime: DateTime.now(), locale: LocaleType.ar);
            },
            child: const Icon(
              Icons.date_range_sharp,
              size: 35,
            )),
      ],
    );
  }
}
