class Placement {
  final String id;
  final String role;
  final String company;
  final String city;
  final String date;
  final String package;

  Placement({
    required this.id,
    required this.role,
    required this.company,
    required this.city,
    required this.date,
    required this.package,
  });

  factory Placement.fromJson(Map<String, dynamic> json) {
    return Placement(
      id: json['id']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      company: json['company']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      package: json['package']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'company': company,
      'city': city,
      'date': date,
      'package': package,
    };
  }

  Placement copyWith({
    String? id,
    String? role,
    String? company,
    String? city,
    String? date,
    String? package,
  }) {
    return Placement(
      id: id ?? this.id,
      role: role ?? this.role,
      company: company ?? this.company,
      city: city ?? this.city,
      date: date ?? this.date,
      package: package ?? this.package,
    );
  }
}
