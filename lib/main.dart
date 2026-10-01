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
        appBar: AppBar(title: const Text('Tahap 2: MediaQuery')),
        body: const MediaQueryDemo(),
      ),
    );
  }
}
class MediaQueryDemo extends StatelessWidget {
  const MediaQueryDemo({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final layoutType = size.width < 600 ? 'Compact' : 'Wide';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Identitas : ${MyApp.studentId} - ${MyApp.studentName}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Width: ${size.width.toStringAsFixed(0)}'),
                  Text('Height: ${size.height.toStringAsFixed(0)}'),
                  Text('Orientation: $orientation'),
                  const Divider(),
                  Text(
                    'Layout Category: $layoutType',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: layoutType == 'Compact' ? Colors.orange : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}