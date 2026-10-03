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
      home: const KasusDPage(), 
    );
  }
}
class KasusDPage extends StatefulWidget {
  const KasusDPage({super.key});
  @override
  State createState() => _KasusDPageState();
}
class _KasusDPageState extends State {
  final String studentName = 'I Wayan Agus Wredhi Putra';
  final String studentId = '2415051007';
  bool _isNavigating = false;
  Future _navigasiAman() async {
    if (_isNavigating) return;
    setState(() {
      _isNavigating = true;
    });
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HalamanDua()),
    );
    if (mounted) {
      setState(() {
        _isNavigating = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasus D - Navigasi Ganda'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Colors.blue.shade50,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '$studentName ($studentId)',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                const Text(
                  '1. Uji Navigasi Rentan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HalamanDua()),
                    );
                  },
                  child: const Text('Spam Klik Tombol Ini!'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                  child: Text(
                    'Jika diklik beberapa kali dengan sangat cepat, halaman akan terbuka bertumpuk. Anda harus menekan "Back" beberapa kali untuk kembali.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  '2. Uji Navigasi Aman',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade100),
                  onPressed: _isNavigating ? null : _navigasiAman,
                  child: Text(_isNavigating ? 'Memproses...' : 'Klik'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                  child: Text(
                    'Meskipun di-spam klik berkali-kali, halaman hanya akan terbuka 1x karena tombol dikunci sementara.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class HalamanDua extends StatelessWidget {
  const HalamanDua({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Tujuan')),
      body: const Center(
        child: Text('Anda berhasil pindah halaman! Silakan tekan tombol back.'),
      ),
    );
  }
}