import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthEvent {}
class LoginRequested extends AuthEvent {
  final String role;
  LoginRequested(this.role);
}
class LogoutRequested extends AuthEvent {}

abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthAuthenticated extends AuthState {
  final String role;
  AuthAuthenticated(this.role);
}
class AuthUnauthenticated extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>((event, emit) {
      emit(AuthAuthenticated(event.role));
    });

    on<LogoutRequested>((event, emit) {
      emit(AuthUnauthenticated());
    });
  }
}
