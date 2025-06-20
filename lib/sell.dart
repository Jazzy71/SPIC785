import 'package:carnest/chatbot.dart';
import 'package:carnest/notification.dart';
import 'package:carnest/profile.dart';
import 'package:carnest/renault2.dart';
import 'package:carnest/suzuki2.dart';
import 'package:carnest/tata2.dart';
import 'package:carnest/toyota2.dart';
import 'package:flutter/material.dart';

import 'buy.dart';
import 'home.dart';
import 'honda2.dart';
import 'hyun2.dart';

class SellCarScreen extends StatelessWidget {
  const SellCarScreen({super.key});

  final List<Map<String, String>> carBrands = const [
    {'name': 'HYUNDAI', 'asset': 'assets/hyun.png'},
    {'name': 'TATA', 'asset': 'assets/tata.png'},
    {'name': 'HONDA', 'asset': 'assets/honda.png'},
    {'name': 'SUZUKI', 'asset': 'assets/suzuki.png'},
    {'name': 'RENAULT', 'asset': 'assets/renault.png'},
    {'name': 'TOYOTA', 'asset': 'assets/toyota.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.grey.shade800,
              size: 20,
            ),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(), // or just NotificationScreen() if not const
            ),
          ),
        ),
        title: Text(
          'Sell Your Car',
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: 0,
          selectedItemColor: Colors.orangeAccent,
          unselectedItemColor: Colors.grey.shade500,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          onTap: (index) {
            switch (index) {
              case 0:
              // Sell - current page, do nothing
                break;
              case 1:
              // Home - navigate to HomeScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
                break;
              case 2:
              // Carsbot - add navigation if needed
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatScreen(),
                  ),
                );
                break;
              case 3:
              // Profile - add navigation if needed
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.sell_outlined),
              label: 'Sell',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.smart_toy_outlined),
              label: 'Carsbot',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enhanced Banner Section
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade400,
                      Colors.green.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade400.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: -10,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.sell_outlined,
                            color: Colors.white,
                            size: 32,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Sell your car at\nbest price',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Get instant valuation in minutes',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Section header with enhanced styling - FIXED OVERFLOW ISSUE
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header text section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select your car brand',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Choose from popular brands',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Button section - moved below and made full width
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade400, Colors.blue.shade600],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade400.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarHomePage(
                                // ... other undefined parameters
                              ),
                            ),
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Switch to buy',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Enhanced Car brand grid - FIXED SPACING
              LayoutBuilder(
                builder: (context, constraints) {
                  double availableWidth = constraints.maxWidth;
                  double crossAxisSpacing = 12;
                  double itemWidth = (availableWidth - (2 * crossAxisSpacing)) / 3;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: carBrands.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: crossAxisSpacing,
                      mainAxisSpacing: 12,
                      childAspectRatio: itemWidth / itemWidth, // Square aspect ratio
                    ),
                    itemBuilder: (context, index) {
                      final brand = carBrands[index];
                      return EnhancedBrandCard(
                        name: brand['name']!,
                        assetPath: brand['asset']!,
                        onTap: () {
                          // Navigate to CarModelSelectionScreen with brand info
                          if (brand['name'] == 'HYUNDAI') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CarModelSelectionScreen(
                                  brandName: brand['name']!,
                                  brandAsset: brand['asset']!,
                                ),
                              ),
                            );

                          }
                          else if (brand['name'] == 'TATA') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TataSelectionScreen(
                                  brandName: brand['name']!,
                                  brandAsset: brand['asset']!,
                                ),
                              ),
                            );} else if (brand['name'] == 'HONDA') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HondaSelectionScreen(
                                  brandName: brand['name']!,
                                  brandAsset: brand['asset']!,
                                ),
                              ),
                            );}
                          else if (brand['name'] == 'SUZUKI') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuzukiSelectionScreen(
                                  brandName: brand['name']!,
                                  brandAsset: brand['asset']!,
                                ),
                              ),
                            );}
                          else if (brand['name'] == 'RENAULT') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RenaultSelectionScreen(
                                  brandName: brand['name']!,
                                  brandAsset: brand['asset']!,
                                ),
                              ),
                            );}
                          else if (brand['name'] == 'TOYOTA') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ToyotaSelectionScreen(
                                  brandName: brand['name']!,
                                  brandAsset: brand['asset']!,
                                ),
                              ),
                            );}
                          else {
                            // Handle other brands - you can create similar screens for them
                            print('Selected brand: ${brand['name']}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${brand['name']} selected'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 32),

              // Additional features section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Why sell with us?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Expanded(
                          child: FeatureItem(
                            icon: Icons.verified_outlined,
                            title: 'Verified',
                            subtitle: 'Buyers',
                          ),
                        ),
                        Expanded(
                          child: FeatureItem(
                            icon: Icons.speed_outlined,
                            title: 'Quick',
                            subtitle: 'Process',
                          ),
                        ),
                        Expanded(
                          child: FeatureItem(
                            icon: Icons.monetization_on_outlined,
                            title: 'Best',
                            subtitle: 'Price',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EnhancedBrandCard extends StatelessWidget {
  final String name;
  final String assetPath;
  final VoidCallback onTap;

  const EnhancedBrandCard({
    super.key,
    required this.name,
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade100,
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12), // Reduced padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        assetPath,
                        width: 32,
                        height: 32,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback to icon if image fails to load
                          return Icon(
                            Icons.directions_car,
                            size: 32,
                            color: Colors.grey.shade600,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 11, // Reduced font size
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orangeAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: Colors.orangeAccent,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.grey.shade800,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}