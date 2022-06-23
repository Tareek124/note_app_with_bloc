import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_with_bloc/data/model/note_model.dart';

import 'constants/screens.dart';
import 'logic/cubit/notes_cubit.dart';
import 'presentation/screens/edit_note.dart';
import 'presentation/screens/new_note.dart';
import 'presentation/screens/show_notes.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case showNotes:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => NotesCubit(),
                  child: ShowNotes(),
                ));

      case newNotes:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => NotesCubit(),
                  child: NewNote(),
                ));

      case editNote:
        final editNoteArguments = routeSettings.arguments as NoteModel;

        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => NotesCubit(),
                  child: EditNote(
                    noteModel: editNoteArguments,
                  ),
                ));
    }
  }
}
