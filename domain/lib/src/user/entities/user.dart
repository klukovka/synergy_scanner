import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String fullname;
  final String email;
  final String? avatarUrl;

  User({
    required this.id,
    required this.fullname,
    this.avatarUrl,
    required this.email,
  });

  @override
  List<Object?> get props => [id, fullname, avatarUrl];
}
