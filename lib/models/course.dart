//2415051007 - I Wayan Agus Wredhi Putra
class Course {
  final int? id;
  final String code;
  final String title;
  final int credits;
  final String status;
  const Course({
    this.id,
    required this.code,
    required this.title,
    required this.credits,
    this.status = 'planned',
  });
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int?,
      code: json['code'] as String? ?? 'POST-${json['id'] ?? 0}',
      title: json['title'] as String? ?? 'No Title',
      credits: json['credits'] as int? ?? 3,
      status: (json['status'] as String?) ?? 'active',
    );
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'code': code,
      'title': title,
      'credits': credits,
      'status': status.toLowerCase(), 
    };
    if (id != null) {
      data['id'] = id;
    }

    return data;
  }
}