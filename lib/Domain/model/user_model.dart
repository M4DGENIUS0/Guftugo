import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  String? picture;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.picture,
  });

  /// Empty user which represents an unauthenticated user.
  static final empty = UserModel(id: '', email: '', name: '', picture: '');

  /// Modify MyUser parameters
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? picture,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      picture: picture ?? this.picture,
    );
  }

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserModel.empty;

  UserEntities toEntity() {
    return UserEntities(
      id: id,
      email: email,
      name: name,
      picture: picture,
    );
  }

  static UserModel fromEntity(UserEntities entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      picture: entity.picture,
    );
  }

  @override
  List<Object?> get props => [id, email, name, picture];
}
