import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

// ====================== MAIN PROVIDER ======================
class MainProvider extends ChangeNotifier {
  ThemeData theme = ThemeData.light();

  void setDarkMode(ThemeData thm) {
    theme = thm;
    notifyListeners();
  }
}

// ====================== WIDGETS ======================
class EditBox extends StatelessWidget {
  final String hint;
  final bool password;

  const EditBox({super.key, required this.hint, this.password = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: password,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade50,  // PLUS CLAIR
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.grey.shade300, // contour léger et clean
          ),
        ),
      ),
    );
  }
}

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
          home: const HomePage(),
        );
      },
    );
  }
}

// ====================== HOME PAGE ======================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Choose Language",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text("English"),
                value: context.locale.languageCode == 'en',
                onChanged: (val) {
                  context.setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
                secondary:
                    Image.asset('images/English.png', width: 30, height: 30),
              ),
              SwitchListTile(
                title: const Text("Turkish"),
                value: context.locale.languageCode == 'tr',
                onChanged: (val) {
                  context.setLocale(const Locale('tr'));
                  Navigator.pop(context);
                },
                secondary:
                    Image.asset('images/Turkey.png', width: 30, height: 30),
              ),
            ],
          ),
        ),
      ),

      // ====================== BODY ======================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/school.png', width: 120, height: 120),
              const SizedBox(height: 30),

              // ====================== LOGIN CARD ======================
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    EditBox(hint: 'username'.tr()),
                    const SizedBox(height: 20),
                    EditBox(hint: 'password'.tr(), password: true),
                    const SizedBox(height: 25),

                    // LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'login'.tr(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Text("OR", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 20),

                    // ====================== FACEBOOK BUTTON ======================
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/Facebook.png',
                                width: 22, height: 22),
                            const SizedBox(width: 10),
                            const Text(
                              "Facebook",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // ====================== GOOGLE BUTTON ======================
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/Google.png',
                                width: 22, height: 22),
                            const SizedBox(width: 10),
                            const Text(
                              "Google",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: Builder(
                  builder: (ctx) => IconButton(
                    icon: const Icon(Icons.settings,
                        color: Colors.black, size: 30),
                    onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
