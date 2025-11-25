import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

// ====================== IMPORT DES MODULES ======================
import 'module/mainprovider.dart'; // ✅ Votre provider
import 'module/widget.dart';       // ✅ Vos widgets (EditBox, etc.)

// ====================== MAIN ======================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'lang/',
      fallbackLocale: const Locale('en'),
      child: ChangeNotifierProvider(
        create: (_) => MainProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

// ====================== MY APP ======================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: provider.theme,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: LoginPage(),
        );
      },
    );
  }
}

// ====================== LOGIN PAGE - PROFESSIONAL & CENTERED ======================
class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentLocale = context.locale.languageCode;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Votre logo school
                Image.asset(
                  'images/school.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 30),

                // 🔲 CADRE PROFESSIONNEL AUTOUR DU FORMULAIRE
                Container(
                  width: 400,
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[850] : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.4 : 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Champs
                      EditBox(
                        hint: 'username'.tr(),
                        prefixIcon: Icons.person_outline,
                        controller: _usernameController,
                      ),
                      EditBox(
                        hint: 'password'.tr(),
                        password: true,
                        prefixIcon: Icons.lock_outline,
                        controller: _passwordController,
                      ),

                      // Mot de passe oublié
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO
                          },
                          child: Text(
                            'Forgot password?'.tr(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Bouton Login
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Logique
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'login'.tr(),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ===== GOOGLE / FACEBOOK =====
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: isDark ? Colors.grey[700] : Colors.grey[300],
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                color: isDark ? Colors.grey[500] : Colors.grey[500],
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: isDark ? Colors.grey[700] : Colors.grey[300],
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Google
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Image.asset('images/Google.png', width: 20, height: 20),
                          label: const Text('Google'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            foregroundColor: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Facebook
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Image.asset('images/Facebook.png', width: 20, height: 20),
                          label: const Text('Facebook'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            foregroundColor: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // 🌐 BOUTON LANGUE EN HAUT À DROITE (DISCRET ET PRO)
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          if (currentLocale == 'en') {
            context.setLocale(const Locale('tr'));
          } else {
            context.setLocale(const Locale('en'));
          }
        },
        tooltip: currentLocale == 'en' ? 'Switch to Turkish' : 'Switch to English',
        child: currentLocale == 'en'
            ? Image.asset('images/Turkey.png', width: 24, height: 24)
            : Image.asset('images/English.png', width: 24, height: 24),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}