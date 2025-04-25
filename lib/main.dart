import 'package:daftary/app.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'simple_bloc_observer.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Load environment variables
    await dotenv.load(fileName: ".env");

    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
      debug: true, // Remove this in production
    );

    // Instabug.init(
    //   token: "a3315a3beb70e6178af64804c10d6788", // Replace with your actual token
    //   invocationEvents: [InvocationEvent.shake, InvocationEvent.floatingButton],
    // );

    Bloc.observer = SimpleBlocObserver();
    runApp(const MyApp());
  } catch (error) {
    debugPrint('Error initializing app: $error');
    rethrow;
  }
}

// Get Supabase client
final supabase = Supabase.instance.client;
