📘 Orientation Linguistique – Application Mobile Flutter
📝 Description du projet

Orientation Linguistique est une application mobile développée en Flutter permettant d’évaluer et d’orienter les utilisateurs selon leur niveau de langue grâce à un quiz adaptatif intelligent.
L’objectif est de proposer une expérience personnalisée où chaque utilisateur reçoit des ressources vidéo adaptées à son niveau : Débutant, Intermédiaire ou Avancé.

L’application repose sur une authentification sécurisée via Firebase, un système de scoring dynamique et une interface moderne inspirée des standards du design mobile.

🎯 Fonctionnalités principales
🔐 1. Authentification Firebase

Inscription et connexion par e-mail/mot de passe

Gestion sécurisée des sessions utilisateur

Enregistrement des profils dans Firestore

🧠 2. Quiz Adaptatif

Série de questions personnalisées

Calcul automatique du score

Classification du niveau :

+ Débutant

+ Intermédiaire

+ Avancé

🎓 3. Orientation Intelligente

Selon le score obtenu, l’utilisateur est redirigé automatiquement vers une page contenant des cours YouTube adaptés à son niveau.
Les vidéos sont regroupées et filtrées selon :

Thématiques

Progrès de l’utilisateur

Niveau linguistique

🎨 4. UI Moderne et Responsive

Design professionnel avec Flutter

Interface user-friendly et intuitive

Thème clair/sombre (si ajouté plus tard)

☁️ 5. Intégration Backend (Firebase)

Authentification

Stockage des résultats du quiz

Récupération dynamique des cours selon le niveau

🏗️ Architecture du projet

Le projet suit une architecture claire et modulaire :

lib/
 ├── models/
 ├── services/
 ├── providers/ (ou blocs/)
 ├── screens/
 │     ├── auth/
 │     ├── quiz/
 │     ├── levels/
 │     └── home/
 └── utils/

🛠️ Technologies utilisées

Flutter 3.x (Dart)

Firebase Authentication

Cloud Firestore

Firebase Core

YouTube Player Flutter

Git & GitHub pour la collaboration

Provider / Bloc (selon choix) pour la gestion d’état

🌿 Gestion de projet & Collaboration Git

Deux branches principales :

main → branche principale (développement général)

mohamed_branch → branche secondaire pour le travail collaboratif

Workflow recommandé :

Chaque développeur travaille sur sa branche

Tests + validations

Fusion dans main via pull request ou git merge

🚀 Objectifs du projet

Offrir un outil d’orientation linguistique professionnel

Automatiser la recommandation de ressources d’apprentissage

Démontrer une architecture Flutter propre et scalable

Construire une application complète (UI + logique + backend)

🧪 Évolutions futures

Dashboard de progression

Quiz plus intelligent (machine learning)

Notifications

Ajout de plusieurs langues

Mode hors ligne pour les cours (si licences autorisées)
