import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tahap 16 - Debugging',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const KasusAPage(), 
    );
  }
}
class KasusAPage extends StatelessWidget {
  const KasusAPage({super.key});
  final String studentName = 'I Wayan Agus Wredhi Putra';
  final String studentId = '2415051007';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasus A - RenderFlex Fix'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$studentName ($studentId)',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.info, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '$studentId - $studentName - Ini adalah teks yang sangat panjang untuk menguji penyelesaian masalah RenderFlex overflow pada widget Row.',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}