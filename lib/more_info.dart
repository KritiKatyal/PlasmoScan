import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart'; // Icon Library
import 'package:url_launcher/url_launcher.dart';
// import 'dart:io'; // Required for Platform.isAndroid


class MoreInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More Info", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue, // App bar color
        elevation: 4, // Shadow for depth
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // About Section
              Text(
                "About the App",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "PlasmoScan can help diagnostic laboratory and doctors to detect malaria early and accurately."
                " By uploading malaria blood smear samples, users can utilize an AI-powered "
                "detection system to analyze and get malaria stage for better diagnosis and treatment.",
                style:
                    TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),

              // Key Features Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Key Features",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      SizedBox(height: 10),
                      buildFeature(Iconsax.cpu, "AI-powered malaria detection"),
                      buildFeature(
                          Iconsax.activity, "Fast and accurate analysis"),
                      buildFeature(Iconsax.devices, "User-friendly interface"),
                      buildFeature(
                          Iconsax.shield_tick, "Prevention suggestions"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Contact Section
              Text(
                "For more information, contact us:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  buildContactCard(
                    "Dr. Ritu Gill",
                    "Malaria Molecular Biology Lab, Centre for Biotechnology",
                    "Maharshi Dayanand University, Rohtak - 124001, HR, INDIA",
                    "ritu_gill@mdurohtak.ac.in",
                  ),
                  buildContactCard(
                    "Dr. Kamaldeep Joshi",
                    "Department of Computer Science and Engineering",
                    "University Institute of Engineering and Technology (UIET), Maharshi Dayanand University, Rohtak – 124001, HR, India",
                    "kduiet@mdurohtak.ac.in",
                  ),
                  buildContactCard2(
                      "Dr. Sarvajeet Singh Gill", "ssgill14@mdurohtak.ac.in"),
                  buildContactCard2(
                      "Ms. Kriti Katyal", "kritikatyal06@gmail.com")
                ],
              )
              // buildContactRow(Iconsax.sms, "Email:", "kritikatyal06@gmail.com"),
            ],
          ),
        ),
      ),
    );
  }

  // Feature List Item
  Widget buildFeature(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContactCard(
      String name, String department, String university, String email) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            SizedBox(height: 4),
            Text(
              department,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            Text(
              university,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            SizedBox(height: 8),
            Divider(),
            buildContactRow(Iconsax.sms, "Email:", email),
          ],
        ),
      ),
    );
  }

  Widget buildContactCard2(String name, String email) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            SizedBox(height: 8),
            Divider(),
            // buildContactRow(Iconsax.sms, "Email:", email),
            buildContactRow(Iconsax.sms, "Email:", email),

          ],
        ),
      ),
    );
  }

Widget buildContactRow(IconData icon, String label, String email) {
  return GestureDetector(
    onTap: () async {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
      );

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri, mode: LaunchMode.externalApplication);  // Forces opening in default email app
      } else {
        debugPrint("Could not launch email client.");
      }
    },
    child: Row(
      children: [
        Icon(icon, size: 20, color: Colors.blueAccent),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            email,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    ),
  );
}



}
//   // Contact Row with Email Click
//   Widget buildContactRow(IconData icon, String label, String email, BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text("Choose Email App"),
//             actions: [
//               // Default Email App
//               TextButton(
//                 onPressed: () async {
//                   final Uri emailUri = Uri(
//                     scheme: 'mailto',
//                     path: email,
//                     query: 'subject=${Uri.encodeComponent("About PlasmoScan")}&body=${Uri.encodeComponent("")}',
//                   );

//                   if (await canLaunchUrl(emailUri)) {
//                     await launchUrl(emailUri);
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text("No email app found."),
//                         backgroundColor: Colors.red,
//                       ),
//                     );
//                   }
//                 },
//                 child: Text("Default Email"),
//               ),

//               // Open Gmail App Directly (Only for Android)
//               if (Platform.isAndroid)
//                 TextButton(
//                   onPressed: () async {
//                     final Uri gmailUri = Uri.parse("mailto:$email?subject=About%20PlasmoScan");

//                     try {
//                       if (await canLaunchUrl(gmailUri)) {
//                         await launchUrl(gmailUri);
//                       } else {
//                         throw "Could not open Gmail app";
//                       }
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text("Gmail app not found. Opening in browser."),
//                           backgroundColor: Colors.orange,
//                         ),
//                       );

//                       // Open Gmail in browser as fallback
//                       final Uri webGmailUri = Uri.parse(
//                         "https://mail.google.com/mail/?view=cm&to=$email&su=About%20PlasmoScan&body="
//                       );
//                       await launchUrl(webGmailUri);
//                     }
//                   },
//                   child: Text("Gmail App"),
//                 ),
//             ],
//           ),
//         );
//       },
//       child: Row(
//         children: [
//           Icon(icon, size: 20, color: Colors.blueAccent),
//           SizedBox(width: 8),
//           Text(
//             label,
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
//           ),
//           SizedBox(width: 4),
//           Expanded(
//             child: Text(
//               email,
//               style: TextStyle(fontSize: 12, color: Colors.blueAccent, decoration: TextDecoration.underline),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
