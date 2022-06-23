import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/database/database_provider.dart';
import '../../data/model/note_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState?> {
  NotesCubit() : super(null);

  List<NoteModel> notes = [];

  List<NoteModel> getAllNotes() {
    DatabaseProvider.instance.readAllElements().then((value) {
      emit(GetAllNotes(notes: value));
      notes = value;
    });
    return notes;
  }

  void newNote(NoteModel noteModel) {
    DatabaseProvider.instance.createUser(noteModel);
  }

  void deleteNote(int id) {
    DatabaseProvider.instance.deleteUser(id);
  }

  void editNote(NoteModel noteModel) {
    DatabaseProvider.instance.updateUser(noteModel);
  }
}
