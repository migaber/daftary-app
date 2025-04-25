import 'package:auth_repository/auth_repository.dart';
import 'package:daftary/screens/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:daftary/screens/auth/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => SupabaseAuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Daftary',
          theme: ThemeData(
            colorScheme: ColorScheme.light(
              surface: Colors.grey.shade100,
              onSurface: Colors.black,
              primary: Color(0xFF009AE7),
              secondary: Color(0xffe064f7),
              tertiary: Color(0xffff8d6c),
              outline: Colors.grey.shade500,
            ),
          ),
          home: AuthenticationWrapper(),
        ),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: context.read<AuthRepository>().isAuthenticated,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final isAuthenticated = snapshot.data ?? false;
        return isAuthenticated ? MyAppView() : LoginScreen();
      },
    );
  }
}
