import 'package:flutter/material.dart';

void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String studentName = 'I Wayan Agus Wredhi Putra';
  static const String studentId = '2415051007';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Tahap 4: Expanded & Wrap')),
        body: const ExpandedWrapDemo(),
      ),
    );
  }
}
class ExpandedWrapDemo extends StatelessWidget {
  const ExpandedWrapDemo({super.key});
  final List skills = const [
    'Flutter',
    'Dart',
    'OOP (PBO)',
    'Algorithm',
    'HTML & CSS',
    'MySQL',
    'Git',
  ];
  Widget buildBox(String label, Color color) {
    return Container(
      height: 60,
      color: color,
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${MyApp.studentId} - ${MyApp.studentName}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 20),
          const Text(
            'Expanded Flex 2 : 1',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: buildBox('Panel A', Colors.indigo),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: buildBox('Panel B', Colors.teal),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Wrap Chip Skill',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: skills.map((skill) {
              return Chip(
                avatar: const Icon(Icons.check_circle, size: 18, color: Colors.indigo),
                label: Text(skill),
                backgroundColor: Colors.indigo.shade50,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}