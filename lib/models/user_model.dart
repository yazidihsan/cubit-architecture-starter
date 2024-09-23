import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int? id;
  final String name;
  final String email;
  final String phone;
  const UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      email: json['email'],
      phone: json['phone']);

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone};
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, phone];
}
