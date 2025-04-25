import 'dart:async';
import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<AuthState> _authStateSubscription;
  final _supabase = Supabase.instance.client;

  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthLoading()) {
    on<AuthUserChanged>(_onAuthUserChanged);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);

    _authStateSubscription = _supabase.auth.onAuthStateChange.map((event) {
      return event.session != null
          ? Authenticated(event.session?.user)
          : Unauthenticated();
    }).listen((state) {
      add(AuthUserChanged(state is Authenticated ? state.user : null));
    });
  }

  void _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) {
    if (event.user != null) {
      emit(Authenticated(event.user));
    } else {
      emit(Unauthenticated());
    }
  }

  void _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.signUp(
        email: event.email,
        password: event.password,
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authRepository.signOut();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
