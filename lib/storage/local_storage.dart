import 'package:hive/hive.dart';

class LocalStorage {
  //→ Ouvre une box Hive servant de stockage persistant.
  static final Box box = Hive.box('appBox');
//→ Sauvegarde le rôle utilisateur (admin / student, etc.).
  static void saveRole(String role) {
    box.put('role', role);
  }
//→ Récupère le rôle stocké localement.
  static String? getRole() {
    return box.get('role');
  }
//→ Supprime toutes les données locales (utile lors du logout).
  static void clear() {
    box.clear();
  }
}
