import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'bloc/auth_bloc.dart';
import 'module/mainprovider.dart';
import 'providers/quiz_provider.dart';
import 'pages/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
/// Point d’entrée principal de l’application Flutter
/// - Initialise Flutter
/// - Initialise Firebase
/// - Configure la localisation (EasyLocalization)
/// - Configure l’injection des Providers (state management)
void main() async {
  // Assure que les bindings Flutter sont prêts avant toute initialisation
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation du système de localisation
  await EasyLocalization.ensureInitialized();

  // Initialisation de Firebase selon la plateforme (Web / Android / iOS)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
await Hive.initFlutter();
await Hive.openBox('appBox');
  // Lancement de l’application avec :
  // - Localisation
  // - Providers globaux
 runApp(
  EasyLocalization(
    supportedLocales: const [
      Locale('en'),
      Locale('tr'),
    ],
    path: 'lang/',
    fallbackLocale: const Locale('en'),
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc()),
        ],
        child: const MyApp(),
      ),
    ),
  ),
);
}

/// Widget racine de l’application
/// Gère :
/// - Le thème (clair/sombre)
/// - La localisation
/// - La page d’accueil
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
        // Écoute les changements du MainProvider (thème, paramètres globaux)
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          // Thème dynamique fourni par le provider
          theme: provider.theme,

          // Configuration de la localisation
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          // Page d’entrée : écran de login
          home: const SplashScreen(),
        );
      },
    );
  }
}
