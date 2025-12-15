import 'package:flutter_bloc/flutter_bloc.dart';

/// -------------------- EVENTS --------------------
/// Les événements représentent les actions déclenchées par l’utilisateur
/// ou par l’application (login, logout, etc.)

/// Classe abstraite de base pour tous les événements d’authentification
abstract class AuthEvent {}

/// Événement déclenché lorsqu’un utilisateur se connecte
/// Contient le rôle de l’utilisateur (student / admin)
class LoginRequested extends AuthEvent {
  final String role;
  LoginRequested(this.role);
}

/// Événement déclenché lors de la déconnexion de l’utilisateur
class LogoutRequested extends AuthEvent {}


/// -------------------- STATES --------------------
/// Les états représentent la situation actuelle de l’authentification

/// Classe abstraite de base pour tous les états d’authentification
abstract class AuthState {}

/// État initial au lancement de l’application
class AuthInitial extends AuthState {}

/// État lorsque l’utilisateur est authentifié
/// Contient le rôle pour gérer la navigation et les permissions
class AuthAuthenticated extends AuthState {
  final String role;
  AuthAuthenticated(this.role);
}

/// État lorsque l’utilisateur n’est pas connecté
class AuthUnauthenticated extends AuthState {}


/// -------------------- BLOC --------------------
/// Le BLoC fait le lien entre les Events et les States
/// Il contient la logique métier de l’authentification

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  /// Initialisation du BLoC avec l’état initial
  AuthBloc() : super(AuthInitial()) {

    /// Lorsqu’un événement LoginRequested est reçu,
    /// on émet l’état AuthAuthenticated avec le rôle
    on<LoginRequested>((event, emit) {
      emit(AuthAuthenticated(event.role));
    });

    /// Lorsqu’un événement LogoutRequested est reçu,
    /// on émet l’état AuthUnauthenticated
    on<LogoutRequested>((event, emit) {
      emit(AuthUnauthenticated());
    });
  }
}
