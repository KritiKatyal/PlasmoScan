import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:iconsax/iconsax.dart';
// import 'dart:ui'; // Import for ImageFilter (blur effect)
import 'package:firebase_auth/firebase_auth.dart';
import 'package:PlasmoScan/more_info.dart';
import 'package:PlasmoScan/preventions_page.dart';
import 'package:PlasmoScan/profile_page.dart';
import 'package:PlasmoScan/important_links.dart';
import 'package:PlasmoScan/symptoms_page.dart';
import 'login.dart';
// import 'dart:math';
import 'camera_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final User? user = FirebaseAuth.instance.currentUser;
  final _advancedDrawerController = AdvancedDrawerController();
  late ScrollController _scrollController;
  bool _isScrolled = false;

  List<dynamic> _services = [
    ['Scan Image', Iconsax.camera, Colors.blue],
    ['Symptoms', Iconsax.activity, Colors.orange],
    ['Prevention', Iconsax.shield_cross, Colors.green],
    ['More Info', Iconsax.info_circle, Colors.purple],
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
  }

  @override
  void _listenToScrollChange() {
    setState(() {
      _isScrolled = _scrollController.offset >= 100.0;
    });
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return AdvancedDrawer(
      backdropColor: Colors.blue[50],
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),

      // Drawer Content
      drawer: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
              ),
              const SizedBox(height: 10),

              // User Greeting
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Hi ${user?.displayName?.isNotEmpty == true ? user!.displayName : "User"},",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[900],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Divider(color: Colors.grey),

              // Drawer Menu Items
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                leading: const Icon(Iconsax.home),
                title: Text('Home', style: TextStyle(color: Colors.grey[900])),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SymptomsPage()));
                },
                leading: const Icon(Iconsax.activity),
                title:
                    Text('Symptoms', style: TextStyle(color: Colors.grey[900])),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreventionPage()));
                },
                leading: const Icon(Iconsax.shield_cross),
                title: Text('Prevention',
                    style: TextStyle(color: Colors.grey[900])),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                leading: const Icon(Iconsax.setting_2),
                title:
                    Text('Settings', style: TextStyle(color: Colors.grey[900])),
              ),

              const Spacer(),

              // Logout Button
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  );
                },
                leading: const Icon(Iconsax.logout, color: Colors.redAccent),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),

      // **Main App Screen**
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // AppBar
            SliverAppBar(
              expandedHeight: 100.0,
              elevation: 0,
              pinned: true,
              stretch: true,
              toolbarHeight: 80,
              backgroundColor: Colors.grey[100],
              leading: IconButton(
                color: Colors.black,
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Iconsax.close_square : Iconsax.menu_1,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
              centerTitle: true,
              title: LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = MediaQuery.of(context).size.width;
                  // double logoSize = screenWidth * 0.12; // Adjusts logo size proportionally
                  double spacing = screenWidth * 0.07; // Adjusts spacing between text and logo

                  return Row(
                    mainAxisSize: MainAxisSize.min, // Ensures compact spacing
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 25),
                          Text(
                            'PlasmoScan',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            "AI-powered Malaria Detection",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //     width:
                      //         spacing), // Dynamic space between text and logo
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 25), // Moves logo down
                      //   child: Image.asset(
                      //     'assets/MDU_logo.png', // Ensure correct path to the image
                      //     height: logoSize, // Dynamically set height
                      //   ),
                      // ),
                    ],
                  );
                },
              ),
            ),

            // Elevated Image Box inside SliverToBoxAdapter
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15), // Subtle shadow
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 5), // Shadow below the box
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/diagram.png',
                      fit: BoxFit.contain, // Keeps image aspect ratio
                    ),
                  ),
                ),
              ),
            ),

            
          
            // Grid View
           SliverToBoxAdapter(
  child: Transform.translate( // Moves content up
    offset: Offset(0, -20), // Move up by x pixels
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.3,
        ),
        itemCount: _services.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (_services[index][0] == 'Scan Image') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraPage()),
                );
              } else if (_services[index][0] == 'More Info') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MoreInfo()),
                );
              } else if (_services[index][0] == 'Symptoms') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SymptomsPage()),
                );
              } else if (_services[index][0] == 'Prevention') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreventionPage()),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: _services[index][2],
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_services[index][1], color: Colors.white, size: 35),
                  SizedBox(height: 20),
                  Text(
                    _services[index][0],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  ),
),

            SliverToBoxAdapter(
  child: Transform.translate( // Moves content up
    offset: Offset(0, -20),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(2, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.link, size: 40, color: Colors.blue),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Important Links",
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Get more information on malaria prevention, treatment, and research.",
                    style: TextStyle(
                        fontSize: 11, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImportantLinksPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Visit",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ),
  ),
),            
          ],
        ),
      ),
    );
  }
}
