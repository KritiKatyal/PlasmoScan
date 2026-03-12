import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart'; // Import Iconsax package
import 'auth.dart';
import 'home_page.dart'; // Ensure this is imported

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  TextEditingController _nameController = TextEditingController();
  FocusNode _nameFocus = FocusNode(); // Focus node for the text field

  @override
  void initState() {
    super.initState();
    _nameController.text = user?.displayName ?? "No Name";
  }

  // Function to update display name
  Future<void> _updateName() async {
    if (user != null && _nameController.text.isNotEmpty) {
      await user!.updateDisplayName(_nameController.text);
      await user!.reload();
      setState(() {}); // Refresh UI
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Name updated successfully!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

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
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left,
              size: 24, color: Colors.black), // Iconsax back button
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        elevation: 3,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image (Fixed Default Image)
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/avatar.png"),
              ),
              SizedBox(height: 20),

              // Editable Name Field
              TextField(
                controller: _nameController,
                focusNode: _nameFocus, // Attach focus node to TextField
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon: IconButton(
                    icon: Icon(Iconsax.edit, color: Colors.blue),
                    onPressed: () {
                      FocusScope.of(context)
                          .requestFocus(_nameFocus); // Open keyboard
                    },
                  ),
                ),
                onSubmitted: (value) {
                  _updateName(); // Save name when user presses "Enter"
                },
                onEditingComplete: () {
                  _updateName(); // Save when user taps outside
                  FocusScope.of(context).unfocus(); // Close keyboard
                },
              ),

              SizedBox(height: 20),

              // Email Display (Read-Only)
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                readOnly: true,
                controller:
                    TextEditingController(text: user?.email ?? "No Email"),
              ),
              SizedBox(height: 30),

              SizedBox(height: 20),

              // Save Changes Button
              ElevatedButton.icon(
                onPressed: _updateName,
                icon: Icon(Iconsax.save_2,
                    color: Colors.white, size: 20), // Iconsax Save Icon
                label: Text(
                  "Save Changes",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Stylish blue color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
              ),

              SizedBox(height: 20),

              // Logout Button (Modern Style)
              ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AuthScreen()), // Redirect to Auth Page
                  );
                },
                icon: Icon(Iconsax.logout,
                    color: Colors.white, size: 20), // Iconsax Logout Icon
                label: Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red.shade600, // Deeper red shade for a modern look
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );

  }
}
