import 'package:flutter/material.dart';
import 'home_page.dart';

class SymptomsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return PopScope(
  canPop: false, // Prevent default back navigation
  onPopInvoked: (didPop) {
    if (!didPop) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  },
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Symptoms",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false,
            );
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildInfoCard(
                  "Symptoms",
                  "Malaria symptoms generally start within 10-15 days of getting bitten by infected Anopheles mosquitoes. "
                      "Symptoms may be mild but, in some cases, malaria can cause severe illness and even death of the patient. "
                      "Children, pregnant women and immune-compromised people are at higher risk.",
                ),
                SizedBox(height: 20),
                _buildInfoCard(
                  "General Symptoms",
                  "The most common malaria symptoms are fever and chills. Other symptoms include headaches, muscle aches, anemia, "
                      "tiredness, nausea, vomiting, and diarrhea.",
                ),
                SizedBox(height: 20),
                _buildInfoCard(
                  "Symptoms of Severe Malaria",
                  "Anemia, Jaundice, Kidney failure, Mental confusion, Seizures, Coma, and Death.",
                ),
              ],
            ),
          ),
        ),
      ),
    )
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(title),
            SizedBox(height: 10),
            Text(
              content,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16.5, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade800,
      ),
    );
  }
}
