import 'package:flutter/material.dart';
import 'navbar.dart';

// Add AboutUsScreen widget
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 370,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo, back button, and title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 52,
                          height: 52,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Color(0xFF20435C)),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'About Us',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF20435C),
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // About content
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Who we are',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'RestEase is an innovative online ossuary vault management system designed to streamline record-keeping, certificate issuance, and renewal processes for the Municipal Planning and Development Offices of Padre Garcia, Batangas. It simplifies tracking vaults, renewals, and documents while providing a front-view vault mapping feature for easy reference without the need for real-world tracking.',
                          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
                        ),
                        SizedBox(height: 18),
                        Text(
                          'Our Mission',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'To make cemetery and vault management easier, faster, and more transparent through digital tools.',
                          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
                        ),
                        SizedBox(height: 18),
                        Text(
                          'Our Vision',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'A future where cemetery records are fully digital, reducing stress and saving time for both offices and families.',
                          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
                        ),
                        SizedBox(height: 18),
                        Text(
                          'What We Offer',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 6),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('• ', style: TextStyle(fontSize: 16)),
                                  Expanded(child: Text('Easy vault search and map view', style: TextStyle(fontSize: 15, color: Colors.black87))),
                                ],
                              ),
                              SizedBox(height: 2),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('• ', style: TextStyle(fontSize: 16)),
                                  Expanded(child: Text('Digital certificate issuance and renewal', style: TextStyle(fontSize: 15, color: Colors.black87))),
                                ],
                              ),
                              SizedBox(height: 2),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('• ', style: TextStyle(fontSize: 16)),
                                  Expanded(child: Text('Organized record-keeping', style: TextStyle(fontSize: 15, color: Colors.black87))),
                                ],
                              ),
                              SizedBox(height: 2),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('• ', style: TextStyle(fontSize: 16)),
                                  Expanded(child: Text('Secure and centralized data', style: TextStyle(fontSize: 15, color: Colors.black87))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 18),
                        Text(
                          'RestEase is committed to transforming how cemetery and ossuary vault records are managed. By integrating modern technology into traditional processes, we eliminate inefficiencies and ensure that every record is well-documented, easily accessible, and securely stored.',
                          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}