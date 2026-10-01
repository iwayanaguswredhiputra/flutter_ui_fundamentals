import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String studentName = 'I Wayan Agus Wredhi Putra';
  static const String studentId = '2415051007';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tahap 1: Responsive Problem'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.amber.shade100,
                child: Container(
                  width: 500, 
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    '$studentId - $studentName (Hard-coded width: 500)',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.green.shade100,
                child: Container(
                  width: double.infinity, 
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    '$studentId - $studentName (Responsive width: double.infinity)',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}