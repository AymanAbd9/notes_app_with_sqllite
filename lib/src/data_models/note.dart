
const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    id,
    title,
    date,
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String date = 'date';
}

class Note {
  final int? id;
  String title;
  DateTime date;
  Note({
    this.id,
    required this.title,
    required this.date,
  });

  Note copyWith({
    int? id,
    String? title,
    DateTime? date,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
    );
  }

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.date: date.toIso8601String(),
      };

  static Note fromJson(Map<String, Object?> json ) => Note(
   id: json[NoteFields.id] as int,
      title: json[NoteFields.title] as String,
      date: DateTime.parse(json[NoteFields.date] as String),
  );
}
