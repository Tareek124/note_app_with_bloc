part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class GetAllNotes extends NotesState {
  List<NoteModel> notes = [];
  GetAllNotes({
    required this.notes,
  });
}
