import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String fullname;
  final String? avatarUrl;

  User({
    required this.id,
    required this.fullname,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, fullname, avatarUrl];
}
