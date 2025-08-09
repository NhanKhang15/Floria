import 'package:flutter/material.dart';
import 'ques_ans_model.dart';
import 'question_service.dart';
import '../../constants/config.dart';
  
class Tracking extends StatefulWidget {
  final int questionId;
  final QuestionService service;

  Tracking({
    super.key,
    this.questionId = 1, 
    QuestionService? service,
  }) : service = service ?? QuestionService(baseUrl: AppConfig.baseUrl);

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {  
  late Future<Question> _futureQuestion;
  int _currentQuestionId = 1;
  int? _selectedAnswerId;

  @override
  void initState() {
  super.initState();
  _currentQuestionId = 1;
  _futureQuestion = widget.service.getQuestion(_currentQuestionId);
  }

  void _goNext() {
    if (_selectedAnswerId != null) {
      setState(() {
        _currentQuestionId++;
        _selectedAnswerId = null;
        _futureQuestion = widget.service.getQuestion(_currentQuestionId);
      });
    }
  }

  void _goBack() {
    if (_currentQuestionId > 1) {
      setState(() {
        _currentQuestionId--;
        _selectedAnswerId = null;
        _futureQuestion = widget.service.getQuestion(_currentQuestionId);
      });
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<Question>(
            future: _futureQuestion,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return const SizedBox(); // Không hiển thị gì khi lỗi
              }

              final question = snapshot.data!;
              final totalQuestions = 15; // lấy từ DB, fallback 15 nếu không có
              final percent = (_currentQuestionId / totalQuestions).clamp(0.0, 1.0);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header progress
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Theo dõi chu kỳ kinh nguyệt',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${(percent * 100).round()}%',
                                style: const TextStyle(fontSize: 23, color: Colors.pink, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Câu hỏi $_currentQuestionId/$totalQuestions', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              Text(percent == 1.0 ? 'Hoàn thành' : '', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(14),
                            value: percent,
                            backgroundColor: Colors.grey[300],
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(Colors.pink),
                            minHeight: 6,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // WHITE BOX: Question + Answers
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 👉 tiêu đề lấy từ DB (không const)
                          Text(
                            question.text,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),

                          ...question.answers.map((ans) {
                            final isSelected = _selectedAnswerId == ans.id;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedAnswerId = ans.id),
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.pink[50] : Colors.white,
                                  border: Border.all(
                                    color:
                                        isSelected ? Colors.pink : Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  ans.text,
                                  style: TextStyle(
                                    color: isSelected ? Colors.pink : Colors.black87,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _currentQuestionId > 1 ? _goBack : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.arrow_back),
                              SizedBox(width: 6),
                              Text('Quay lại'),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _selectedAnswerId != null ? _goNext : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Tiếp tục'),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
class _ErrorBox extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorBox({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.redAccent),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: onRetry, child: const Text('Thử lại')),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Trang tiếp theo')),
    );
  }
}
