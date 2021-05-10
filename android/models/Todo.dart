import 'dart:convert';

class Todo {
  String content;
  bool isDone;
  int priority;
  Todo({
    required this.content,
    this.isDone = false,
    this.priority = 0,
  });

  Todo copyWith({
    String? content,
    bool? isDone,
    int? priority,
  }) {
    return Todo(
      content: content ?? this.content,
      isDone: isDone ?? this.isDone,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'isDone': isDone,
      'priority': priority,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      content: map['content'],
      isDone: map['isDone'],
      priority: map['priority'],
    );
  }

  String toJson() => json.encode(toMap());
  void toggleTodo() => isDone = !isDone;

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() =>
      'Todo(content: $content, isDone: $isDone, priority: $priority)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.content == content &&
        other.isDone == isDone &&
        other.priority == priority;
  }

  @override
  int get hashCode => content.hashCode ^ isDone.hashCode ^ priority.hashCode;
}
