🌐 Orientation Linguistique – Application Mobile Flutter

📝 Description du projet

Orientation Linguistique est une application mobile Flutter qui évalue le niveau linguistique d’un utilisateur grâce à un quiz adaptatif intelligent.
L’objectif est d’offrir une orientation personnalisée avec des contenus vidéo adaptés à chaque niveau :

🟢 Débutant — 🟡 Intermédiaire — 🔵 Avancé

L’application intègre une authentification Firebase, une UI moderne, et une architecture modulaire professionnelle.

🤝 Contributeurs
Nom	Rôle
Alae Eddine Acheache	Flutter / Firebase
Mohamed Aadili	Flutter / UI & Logic
Alae Azdou	Flutter / Documentation / PPT

💬 Les contributions sont encouragées et bienvenues !

🎯 Fonctionnalités principales
🔐 1. Authentification Firebase

Email / Mot de passe

Sécurité & gestion de sessions

Stockage des profils dans Firestore

🧠 2. Quiz Adaptatif

Questions progressives

Calcul auto du score

Détermination du niveau :

🟢 Débutant

🟡 Intermédiaire

🔵 Avancé

🎓 3. Orientation Intelligente

L’application affiche automatiquement des cours YouTube selon le niveau, filtrés par :

📚 Thématique

📈 Progrès utilisateur

🏷️ Niveau linguistique

🎨 4. UI Moderne & Responsive

Design professionnel

Composants modernes Flutter

Navigation intuitive

Prêt pour thème clair/sombre

☁️ 5. Backend Firebase

Authentification

Firestore pour stocker scores et progression

Requêtes dynamiques pour les contenus selon le niveau

🏗️ Architecture du projet
lib/
 ├── models/
 ├── services/
 ├── providers/   
 ├── screens/
 │     ├── auth/
 │     ├── quiz/
 │     ├── levels/
 │     └── home/
 └── utils/


Architecture pensée pour être scalable, maintenable et propre.

🛠️ Technologies utilisées
Technologie	Description
Flutter 3.x	Framework UI multi-plateforme
Dart	Langage principal
Firebase Authentication	Auth utilisateur
Firestore	Base de données cloud
YouTube Player Flutter	Intégration des vidéos
Provider / Bloc	Gestion d’état
Git / GitHub	Collaboration & versioning
🌱 Collaboration Git
Branches principales :

main → branche de production / développement global

mohamed_branch → développement parallèle collaboratif

Workflow recommandé :

✔️ Travail dans chaque branche
✔️ Tests et revue
✔️ PR ou git merge vers main

🚀 Objectifs du projet

Offrir un outil intelligent d’orientation linguistique

Automatiser la recommandation pédagogique

Construire une app Flutter complète (UI + logique + backend)

Démontrer une architecture propre, scalable et professionnelle

🧪 Évolutions futures

📊 Dashboard de progression

🤖 Quiz intelligent (machine learning)

🔔 Notifications personnalisées

🌍 Multi-langues

📥 Mode hors-ligne pour les cours

📄 Licence

Distribué sous licence MIT.