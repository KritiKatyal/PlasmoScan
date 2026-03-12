import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImportantLinksPage extends StatelessWidget {
  final List<Map<String, dynamic>> links = [
    {
      "title": "World Health Organization",
      "url": "https://www.who.int/",
      "icon": Icons.public,
    },
    {
      "title": "WHO Malaria Reports",
      "url": "https://www.who.int/teams/global-malaria-programme/reports",
      "icon": Icons.article,
    },
    {
      "title": "PlasmoDB",
      "url": "https://plasmodb.org/plasmo/app",
      "icon": Icons.science,
    },
    {
      "title": "Medicines for Malaria Venture",
      "url": "https://www.mmv.org/",
      "icon": Icons.medical_services,
    },
     {
      "title": "National Center for Vector Borne Diseases Control",
      "url": "https://ncvbdc.mohfw.gov.in/index1.php?lang=1&level=1&sublinkid=5784&lid=3689",
      "icon": Icons.medical_services,
    },
  ];

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Important Links", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        elevation: 2,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: links.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(links[index]["icon"], color: Colors.blue, size: 30),
                title: Text(
                  links[index]["title"],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                onTap: () => _launchURL(links[index]["url"]),
              ),
            );
          },
        ),
      ),
    );
  }
}
