import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/screens.dart';
import '../../data/model/note_model.dart';
import '../../logic/cubit/notes_cubit.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';

class ShowNotesWidgets {
  List<NoteModel>? notes;
  BuildContext? context;

  ShowNotesWidgets({required this.notes, required this.context});

  Widget buildNotes() {
    return _buildListView();
  }

  Widget _buildListView() {
    return ListView.builder(
        itemCount: notes!.length,
        itemBuilder: (context, index) {
          return _dismissNote(index);
        });
  }

  Widget _dismissNote(int index) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Dismissible(
        secondaryBackground: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.only(left: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Icon(
                  Icons.delete,
                  // color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.only(right: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Icon(
                  Icons.delete,
                  // color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        onDismissed: (direction) {
          BlocProvider.of<NotesCubit>(context!).deleteNote(notes![index].id!);
        },
        child: _buildItem(index),
      ),
    );
  }

  Widget _buildItem(int index) {
    return Card(
      color: const Color(0xffe3f2fd),
      elevation: 5,
      child: ListTile(
        title: Wrap(
          direction: Axis.horizontal,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  notes![index].noteTitle!,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    fontFamily: "myFont",
                    color: MyColors.mintGreen,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  notes![index].noteDesc!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: MyColors.royalBlue,
                    fontFamily: "myFont",
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  DateFormat.yMMMEd().format(notes![index].noteDate!),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: "myFont",
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            Navigator.pushNamed(context!, editNote,
                    arguments: NoteModel(
                        noteTitle: notes![index].noteTitle,
                        noteDesc: notes![index].noteDesc,
                        noteDate: notes![index].noteDate,
                        id: notes![index].id))
                .then((value) =>
                    BlocProvider.of<NotesCubit>(context!).getAllNotes());
          },
          icon: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
