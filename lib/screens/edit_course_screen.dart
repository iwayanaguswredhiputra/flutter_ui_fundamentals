// 2415051007 - I Wayan Agus Wredhi Putra
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
class EditCourseScreen extends StatefulWidget {
  final Course course;
  const EditCourseScreen({super.key, required this.course});
  @override
  State<EditCourseScreen> createState() => _EditCourseScreenState();
}
class _EditCourseScreenState extends State<EditCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late int _credits;
  late String _status;
  @override
  void initState() {
    super.initState();
    _title = widget.course.title;
    _credits = widget.course.credits;
    _status = widget.course.status;
  }
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final String studentName = "I Wayan Agus Wredhi Putra";
    final String studentId = "2415051007";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Course', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 1, 154, 249),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$studentId • $studentName',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: widget.course.code,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Kode Course (Read-Only)',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(
                  labelText: 'Judul Course',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Judul wajib diisi' : null,
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _credits.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Kredit / SKS',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Kredit harus berupa angka valid';
                  }
                  return null;
                },
                onSaved: (value) => _credits = int.parse(value!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue : _status.toLowerCase(),
                decoration: const InputDecoration(
                  labelText: 'Status Course',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: 'planned', child: Text('Planned')),
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'done', child: Text('Done')),
                ],
                onChanged: (value) => setState(() => _status = value!),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 154, 249),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: provider.isSaving
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final success = await provider.updateCourse(
                            widget.course.id ?? 1,
                            Course(
                              code: widget.course.code,
                              title: _title,
                              credits: _credits,
                              status: _status,
                            ),
                          );
                          if (!context.mounted) return;
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Course berhasil diperbarui!')),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(provider.error ?? 'Gagal memperbarui')),
                            );
                          }
                        }
                      },
                child: provider.isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Simpan Perubahan', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}