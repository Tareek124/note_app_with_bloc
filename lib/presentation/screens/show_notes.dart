import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/screens.dart';
import '../../constants/colors.dart';
import '../../data/model/note_model.dart';
import '../../logic/cubit/notes_cubit.dart';
import '../widgets/show_notes_widgets.dart';

class ShowNotes extends StatefulWidget {
  const ShowNotes({Key? key}) : super(key: key);

  @override
  State<ShowNotes> createState() => _ShowNotesState();
}

class _ShowNotesState extends State<ShowNotes> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotesCubit>(context).getAllNotes();
  }

  ShowNotesWidgets? showNotesWidgets;

  List<NoteModel>? notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFF2400),
        title: const Text(
          "Notes",
          style: TextStyle(fontFamily: "myFont"),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, newNotes).then(
              (value) => BlocProvider.of<NotesCubit>(context).getAllNotes());
        },
        label: const Text(
          "New Note",
          style: TextStyle(fontFamily: "myFont"),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: MyColors.scarletRed,
      ),
      body: BlocBuilder<NotesCubit, NotesState?>(
        builder: (context, state) {
          if (state is GetAllNotes) {
            showNotesWidgets = ShowNotesWidgets(
                notes: state.notes.reversed.toList(), context: context);
            return state.notes.isEmpty
                ? showNotesWidgets!.noNotesText()
                : showNotesWidgets!.buildNotes();
          } else {
            return const Center(
              child: CircularProgressIndicator(
                  backgroundColor: MyColors.scarletRed),
            );
          }
        },
      ),
    );
  }
}
