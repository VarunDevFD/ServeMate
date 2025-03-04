class FormModel {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String? description;

  FormModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
     this.description,
  });

  // Initial form model (default values)
  factory FormModel.initial() {
    return FormModel(
      name: '',
      email: '',
      phone: '',
      address: '',
      description: '',
    );
  }

  // CopyWith to update specific fields
  FormModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? description,
  }) {
    return FormModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      description: description ?? this.description,
    );
  }
}
