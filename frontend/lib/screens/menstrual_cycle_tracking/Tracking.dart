import 'package:flutter/material.dart';

class Tracking extends StatefulWidget {
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  String? _selectedStatus;

  final List<String> _statusOptions = [
    'Không có thai',
    'Đang mang thai',
    'Đang cho con bú',
    'Đang cố gắng có thai',
  ];

  void _goNext() {
    if (_selectedStatus != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => NextPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                        const Text(
                          '13%',
                          style: TextStyle(fontSize: 23,color: Colors.pink, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Câu hỏi 2/15',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const Text(
                          'Hoàn thành',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(14),
                      value: 0.13,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.pink),
                      minHeight: 6,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // WHITE BOX: Answers
              Container(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tình trạng thai kỳ hiện tại?',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    ..._statusOptions.map((status) {
                      final isSelected = _selectedStatus == status;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedStatus = status;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.pink[50] : Colors.white,
                            border: Border.all(
                              color: isSelected ? Colors.pink : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: isSelected ? Colors.pink : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              const Spacer(),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context), 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back, color: Colors.black),
                        const SizedBox(width: 6),
                        Text('Quai lại'),
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: _selectedStatus != null ? _goNext : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Tiếp tục'),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward,
                          color: _selectedStatus != null ? Colors.white : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Trang tiếp theo')),
    );
  }
}
