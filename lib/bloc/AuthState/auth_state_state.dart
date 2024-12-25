part of 'auth_state_bloc.dart';

class AuthStateState extends Equatable {
  final User? user;
  final AuthStateStatus authstate;
  const AuthStateState._({this.user, this.authstate = AuthStateStatus.unknown});

  /// No Update about the current user
  const AuthStateState.unknown() : this._();

  /// current user is Authenticated
  const AuthStateState.Authenticate(User user)
      : this._(authstate: AuthStateStatus.Authenticate, user: user);

  /// Current user is Not Authenticate
  const AuthStateState.unAuthenticate()
      : this._(
          authstate: AuthStateStatus.unAuthenticate,
        );
  @override
  List<Object?> get props => [user, authstate];
}
