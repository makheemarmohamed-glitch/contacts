class Contact {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? imagePath; // local file path picked by the user

  const Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.imagePath,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'imagePath': imagePath,
      };

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        imagePath: json['imagePath'] as String?,
      );
}
