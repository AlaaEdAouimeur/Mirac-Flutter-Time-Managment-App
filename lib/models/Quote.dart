import 'dart:convert';

class Quote {
  String content;
  bool isSelected;
  Quote({
    required this.content,
    required this.isSelected,
  });

  Quote copyWith({
    String? content,
    bool? isSelected,
  }) {
    return Quote(
      content: content ?? this.content,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'isSelected': isSelected,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      content: map['content'],
      isSelected: map['isSelected'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Quote.fromJson(String source) => Quote.fromMap(json.decode(source));

  @override
  String toString() => 'Quote(content: $content, isSelected: $isSelected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Quote &&
        other.content == content &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode => content.hashCode ^ isSelected.hashCode;
}
