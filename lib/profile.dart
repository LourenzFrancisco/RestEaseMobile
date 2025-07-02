import 'package:flutter/material.dart';
import 'navbar.dart';
import 'main.dart';
import 'pending.dart'; // <-- Add this
import 'records.dart'; // <-- Add this
import 'about_us.dart'; // <-- Add this

// ...existing code...
// Add the ProfileScreen widget
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/logo.png',
                    width: 52,
                    height: 52,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  const Text(
                    'My Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                      color: Color(0xFF20435C),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: const Color(0xFFF5F6FA),
                    backgroundImage: AssetImage('assets/avatar.png'), // Replace with your avatar asset
                    child: Container(),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Antique Armor',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color(0xFF20435C),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.notifications_none, color: Color(0xFF20435C), size: 22),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'antique@gmail.com',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                children: [
                  _ProfileOption(
                    icon: Icons.receipt_long,
                    text: 'Pending Request and Payment',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PendingRequestScreen()),
                      );
                    },
                  ),
                  _ProfileOption(
                    icon: Icons.description_outlined,
                    text: 'Records and Certificate',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RecordsCertificateScreen()),
                      );
                    },
                  ),
                  _ProfileOption(
                    icon: Icons.info_outline,
                    text: 'About Us',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                      );
                    },
                  ),
                  _ProfileOption(
                    icon: Icons.logout,
                    text: 'Logout',
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  final Color? color;
  const _ProfileOption({required this.icon, required this.text, this.onTap, this.color});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      leading: Icon(icon, color: color ?? const Color(0xFF20435C)),
      title: Text(
        text,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: text == 'Logout' ? FontWeight.normal : FontWeight.w500,
        ),
      ),
      trailing: text == 'Logout' ? null : const Icon(Icons.chevron_right, color: Colors.black38),
      onTap: onTap,
    );
  }
}