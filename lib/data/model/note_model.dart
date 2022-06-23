import '../../constants/sqflite_constants.dart';

class NoteModel {
  final int? id;
  final String? noteTitle;
  final String? noteDesc;
  final DateTime? noteDate;

  NoteModel({
    this.id,
    this.noteTitle,
    this.noteDesc,
    this.noteDate,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map[columnID],
      noteTitle: map[columnTitle],
      noteDesc: map[columnDesc],
      noteDate: DateTime.parse(map[columnDate]),
    );
  }

  Map<String, dynamic> toMap() => {
        columnID: id,
        columnTitle: noteTitle,
        columnDesc: noteDesc,
        columnDate: noteDate.toString(),
      };
}
