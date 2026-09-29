import 'package:flutter/material.dart';

const String studentName = 'I Wayan Agus Wredhi Putra';
const String studentId = '2415051007';

void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tahap 10: List & Collection'),
          backgroundColor: Colors.blue,
        ),
        body: const TopicListScreen(),
      ),
    );
  }
}

class TopicListScreen extends StatelessWidget {
  const TopicListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final topics = [
      {
        'title': 'Git & GitHub',
        'subtitle': 'Version control',
        'done': true,
      },
      {
        'title': 'Dart Fundamentals',
        'subtitle': 'Language basics',
        'done': true,
      },
      {
        'title': 'Flutter UI Fundamentals',
        'subtitle': 'Widgets & layout',
        'done': false,
      },
      {
        'title': '$studentId - $studentName',
        'subtitle': 'Pemilik aplikasi',
        'done': true,
      },
    ];
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.blue.shade50,
          padding: const EdgeInsets.all(12.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        studentName,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        studentId,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: topics.length,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            itemBuilder: (context, index) {
              final item = topics[index];
              final bool isDone = item['done'] == true;

              return Card(
                elevation: 1,
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(
                    isDone ? Icons.check_circle : Icons.circle_outlined,
                    color: isDone ? Colors.green : Colors.grey,
                  ),
                  title: Text(
                    item['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      decoration: isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(item['subtitle'] as String),
                  trailing: Icon(
                    isDone ? Icons.done_all : Icons.pending,
                    size: 18,
                    color: isDone ? Colors.green : Colors.orange,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}