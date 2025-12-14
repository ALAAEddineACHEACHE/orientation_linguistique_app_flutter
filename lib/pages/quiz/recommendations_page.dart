import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // <-- ajout nécessaire
/// Page de recommandations pédagogiques
/// - Vidéos YouTube selon le niveau
/// - Ouverture externe via url_launcher
class RecommendationsPage extends StatelessWidget {
  final String level;
  const RecommendationsPage({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final videos = {
      "Débutant": [
        "https://www.youtube.com/watch?v=QGWjKpV9U_w",
        "https://www.youtube.com/watch?v=gJrjgg1KVL4&t=392s"
      ],
      "Intermédiaire": [
        "https://www.youtube.com/watch?v=kIdMfBkl3_o",
        "https://www.youtube.com/watch?v=Ey554n5odLk"
      ],
      "Avancé": [
        "https://www.youtube.com/watch?v=VXdZhy4e4zE",
        "https://www.youtube.com/watch?v=lTAcCNbJ7KE"
      ],
    };

    return Scaffold(
      appBar: AppBar(title: Text("Recommandations ($level)")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          for (final link in videos[level]!)
            Card(
              child: ListTile(
                title: Text(link),
                trailing: const Icon(Icons.open_in_new),
                onTap: () async {
                  final Uri url = Uri.parse(link);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Impossible d'ouvrir le lien")),
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
