import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future loadJsonWithError() async {
    return await rootBundle.loadString('assets/data/student_salah_path.json');
  }
  @override
  Widget build(BuildContext context) {
    const String studentNim = "2415051007";
    const String studentName = "I Wayan Agus Wredhi Putra";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kasus C - Error State Test'),
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Mahasiswa: $studentName ($studentNim)',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder(
                    future: loadJsonWithError(),
                    builder: (context, snapshot) {
                      // 1. Loading State
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Card(
                            color: Colors.red.shade50,
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'Gagal Memuat Data JSON!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Detail Eror: ${snapshot.error}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return const Center(child: Text('Data Berhasil Dimuat'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}