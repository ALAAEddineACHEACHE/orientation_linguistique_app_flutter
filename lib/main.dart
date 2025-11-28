import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'services/auth_service.dart';
import 'module/mainprovider.dart';
import 'module/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/student_home.dart';
import 'providers/quiz_provider.dart'; // <-- Import QuizProvider


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'lang/',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MainProvider()),
          ChangeNotifierProvider(create: (_) => QuizProvider()), // <-- ajouté
        ],
        child: const MyApp(),
      ),
    ),
  );
}


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
          home: const LoginPage(),
        );
      },
    );
  }
}

// ====================== LOGIN PAGE ======================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  final AuthService _auth = AuthService();

  void loginWithEmailPassword() async {
    setState(() => isLoading = true);

    String? role = await _auth.login(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (role == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invalid credentials")));
      return;
    }

    redirect(role);
  }

  void loginWithGoogle() async {
  setState(() => isLoading = true);
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      setState(() => isLoading = false);
      return; // utilisateur annule
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    String email = userCredential.user?.email ?? '';
    String role = email.contains("admin") ? "admin" : "student";

    setState(() => isLoading = false);
    redirect(role);
  } catch (e) {
    setState(() => isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In Failed: $e")));
  }
}

  void loginWithFacebook() async {
    setState(() => isLoading = true);
    String? role = await _auth.loginWithFacebook();
    setState(() => isLoading = false);
    if (role != null) redirect(role);
  }

  void redirect(String role) {
    if (role == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminDashboard()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => StudentHomePage()),
      );
    }
  }

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
                Image.asset('images/school.png', width: 100, height: 100),
                const SizedBox(height: 30),
                Container(
                  width: 400,
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot password?'.tr(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed:
                              isLoading ? null : loginWithEmailPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(
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
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                                  color: isDark
                                      ? Colors.grey[700]
                                      : Colors.grey[300])),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text("OR"),
                          ),
                          Expanded(
                              child: Divider(
                                  color: isDark
                                      ? Colors.grey[700]
                                      : Colors.grey[300])),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Google
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: isLoading ? null : loginWithGoogle,
                          icon: Image.asset('images/Google.png', width: 20),
                          label: const Text('Google'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Facebook
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: isLoading ? null : loginWithFacebook,
                          icon: Image.asset('images/Facebook.png', width: 20),
                          label: const Text('Facebook'),
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
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          if (currentLocale == 'en') {
            context.setLocale(const Locale('tr'));
          } else {
            context.setLocale(const Locale('en'));
          }
        },
        child: currentLocale == 'en'
            ? Image.asset('images/Turkey.png', width: 24)
            : Image.asset('images/English.png', width: 24),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}

// ====================== STUDENT DASHBOARD ======================


// ====================== ADMIN DASHBOARD ======================
class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()));
            },
          )
        ],
      ),
      body: const Center(
        child: Text(
          "Bienvenue Admin 👑\nInterface de gestion vide pour l'instant.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
