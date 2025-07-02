import 'package:flutter/material.dart';
import 'navbar.dart';
// ...existing code...

// Replace RecordsCertificateScreen with a stateful version
class RecordsCertificateScreen extends StatefulWidget {
  const RecordsCertificateScreen({super.key});

  @override
  State<RecordsCertificateScreen> createState() => _RecordsCertificateScreenState();
}

class _RecordsCertificateScreenState extends State<RecordsCertificateScreen> {
  int selectedTab = 0; // 0 = Records, 1 = Certificate

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
                      // Logo on the left
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 52,
                          height: 52,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Back button and Title aligned vertically
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
                              'Records & Certificate',
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
                  const SizedBox(height: 18),
                  // Tab bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => selectedTab = 0),
                        child: Column(
                          children: [
                            Text(
                              'Records',
                              style: TextStyle(
                                fontWeight: selectedTab == 0 ? FontWeight.w600 : FontWeight.w400,
                                fontSize: 16,
                                color: selectedTab == 0 ? const Color(0xFF20435C) : Colors.black54,
                              ),
                            ),
                            if (selectedTab == 0)
                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                height: 2,
                                width: 60,
                                color: const Color(0xFF20435C),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      GestureDetector(
                        onTap: () => setState(() => selectedTab = 1),
                        child: Column(
                          children: [
                            Text(
                              'Certificate',
                              style: TextStyle(
                                fontWeight: selectedTab == 1 ? FontWeight.w600 : FontWeight.w400,
                                fontSize: 16,
                                color: selectedTab == 1 ? const Color(0xFF20435C) : Colors.black54,
                              ),
                            ),
                            if (selectedTab == 1)
                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                height: 2,
                                width: 80,
                                color: const Color(0xFF20435C),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Content area
                  if (selectedTab == 0) ...[
                    // Records form (as before)
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Type',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      controller: TextEditingController(text: 'Transfer'),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Deceased  Information',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF20435C),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Full Name
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      controller: TextEditingController(text: 'Jobert Manabots X.'),
                    ),
                    const SizedBox(height: 12),
                    // Age
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      controller: TextEditingController(text: '34'),
                    ),
                    const SizedBox(height: 12),
                    // Date of Born
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Date of Born',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      controller: TextEditingController(text: 'April 27, 1977'),
                    ),
                    const SizedBox(height: 12),
                    // Date Died
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Date Died',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      controller: TextEditingController(text: 'April 19, 2012'),
                    ),
                    const SizedBox(height: 12),
                    // Residency
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Residency',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      controller: TextEditingController(text: 'Ohio, Mexico Pampanga'),
                    ),
                    const SizedBox(height: 12),
                    // Informant Name
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Informant Name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      controller: TextEditingController(text: 'Antique Amor'),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Uploaded Files',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color(0xFF20435C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFD1D5DB), style: BorderStyle.solid, width: 1),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.picture_as_pdf, color: Colors.red, size: 28),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'BirthCert.pdf',
                              style: TextStyle(
                                color: Color(0xFF20435C),
                                decoration: TextDecoration.underline,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    // Certificate tab: show a styled certificate
                    Center(
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(minHeight: 350),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Color(0xFF20435C), width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Logo and app name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/logo.png',
                                  width: 40,
                                  height: 40,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'RestEase',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xFF20435C),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'Certificate of Interment',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF20435C),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'This is to certify that',
                              style: TextStyle(fontSize: 16, color: Colors.black87),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Jobert Manabots X.',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF20435C),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'has been interred in niche',
                              style: TextStyle(fontSize: 16, color: Colors.black87),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Niche ID: 1F-01A',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF20435C),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Date of Interment: April 27, 1977',
                              style: TextStyle(fontSize: 16, color: Colors.black87),
                            ),
                            const SizedBox(height: 18),
                            const Divider(thickness: 1.2, color: Color(0xFF20435C)),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Date Issued:', style: TextStyle(fontSize: 14, color: Colors.black54)),
                                    SizedBox(height: 4),
                                    Text('April 27, 2024', style: TextStyle(fontSize: 15, color: Colors.black87)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    Text('Authorized Signature', style: TextStyle(fontSize: 14, color: Colors.black54)),
                                    SizedBox(height: 18),
                                    SizedBox(
                                      width: 100,
                                      child: Divider(thickness: 1, color: Colors.black38),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
