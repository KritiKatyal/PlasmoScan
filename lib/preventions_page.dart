import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the HomePage

class PreventionPage extends StatelessWidget {
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
        title: Text("Prevention & Diagnosis",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
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
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCard("Diagnosis", [
                  "Microscopy examination of thin and thick blood smears is the gold standard for malaria diagnosis.",
                  "Rapid Diagnostic Test for detection of malaria antigen in a person’s blood.",
                  "Molecular Detection Using Polymerase Chain Reaction (PCR).",
                ]),
                SizedBox(height: 15),
                _buildPreventionCard(),
              ],
            ),
          ),
        ),
      ),
    )
    );
  }

  Widget _buildCard(String title, List<String> content) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  content.map((text) => _buildJustifiedText(text)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreventionCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Prevention",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            SizedBox(height: 10),
            _buildSectionTitle("1. Avoiding mosquito bites by using:"),
            _buildJustifiedText(" - Mosquito nets"),
            _buildJustifiedText(" - Mosquito repellent and coils"),
            _buildJustifiedText(" - Protective clothing"),
            SizedBox(height: 10),
            _buildSectionTitle("2. Vector Control by using:"),
            _buildJustifiedText(" - Insecticide-treated nets (ITNs)"),
            _buildJustifiedText(" - Indoor residual spraying (IRS)"),
            SizedBox(height: 10),
            _buildSectionTitle("3. Chemoprophylaxis:"),
            _buildJustifiedText(
                "- Travelers to malaria-endemic countries should consult a doctor for suitable prophylactic medication."),
            _buildJustifiedText(
                "- Prophylactic drugs should be taken during the visit and continued for 4 weeks after the last possible exposure."),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _buildJustifiedText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
