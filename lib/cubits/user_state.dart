class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoginSuccess extends UserState {}

class UserError extends UserState {
  final String errmessage;

  UserError({required this.errmessage});
}
