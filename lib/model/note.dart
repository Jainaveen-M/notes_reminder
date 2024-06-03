import 'dart:convert';

class Note {
  int id;
  String title;
  String content;
  String createAt;
  String timeToRemind;
  bool isVisited;
  bool isOverDue;
  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createAt,
    required this.timeToRemind,
    this.isVisited = false,
    this.isOverDue = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createAt': createAt,
      'timeToRemind': timeToRemind,
      'isVisited': isVisited,
      'isOverDue': isOverDue,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      createAt: map['createAt'] ?? '',
      timeToRemind: map['timeToRemind'] ?? '',
      isVisited: map['isVisited'] ?? false,
      isOverDue: map['isOverDue'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.createAt == createAt &&
        other.timeToRemind == timeToRemind &&
        other.isVisited == isVisited &&
        other.isOverDue == isOverDue;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        createAt.hashCode ^
        timeToRemind.hashCode ^
        isVisited.hashCode ^
        isOverDue.hashCode;
  }
}
