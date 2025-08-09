class Answer {
  final int id;
  final String text;
  Answer({required this.id, required this.text});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'] as int,
      text: (json['answerText'] as String?)?.trim() ?? '',
    );
  }
}

class Question {
  final int id;
  final String text;
  final List<Answer> answers;
  Question({required this.id, required this.text, required this.answers});

  factory Question.fromJson(Map<String, dynamic> json) {
    final answersJson = (json['answers'] as List<dynamic>? ?? []);
    return Question(
      id: json['id'] as int,
      text: (json['questionText'] as String?)?.trim() ?? 'Không có tiêu đề',
      answers: answersJson.map((e) => Answer.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
