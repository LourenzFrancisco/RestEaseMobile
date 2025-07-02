import 'package:flutter/material.dart';
import 'navbar.dart';
import 'payment.dart';

// ...existing code...

// Add PendingRequestScreen widget
class PendingRequestScreen extends StatelessWidget {
  const PendingRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           // Logo stays in its own row
Padding(
  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
  child: Image.asset(
    'assets/logo.png',
    width: 52,
    height: 52,
  ),
),

const SizedBox(height: 8),

// Back button + text in one row
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Row(
    children: [
      IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Color(0xFF20435C)),
        onPressed: () => Navigator.pop(context),
      ),
      const SizedBox(width: 4),
      const Text(
        'Pending Request',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Color(0xFF20435C),
        ),
      ),
    ],
  ),
),

            const SizedBox(height: 16), 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _PendingRequestCard(
                    status: 'Request Pending',
                    statusColor: Colors.red,
                    type: 'Transfer',
                    buttonText: 'View',
                    buttonColor: const Color(0xFFB0C4D9),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PendingRequestDetailScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _PendingRequestCard(
                    status: 'Request Approve',
                    statusColor: Colors.green,
                    type: 'Internment',
                    buttonText: 'Pay',
                    buttonColor: const Color(0xFF4285F4),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PaymentScreen()),
                      );
                    },
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

class _PendingRequestCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String type;
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPressed;

  const _PendingRequestCard({
    required this.status,
    required this.statusColor,
    required this.type,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  RichText(
                    text: TextSpan(
                      text: 'Type: ',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: type,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 0,
              ),
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Add PendingRequestDetailScreen widget
class PendingRequestDetailScreen extends StatelessWidget {
  const PendingRequestDetailScreen({super.key});

  void _showCancelConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 320,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9C7C7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(Icons.close, color: Colors.red, size: 44),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Are you sure you want to\ncancel your request?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        // Add your cancel logic here
                        Navigator.of(context).pop(); // Go back after cancel
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4285F4),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                      ),
                      child: const Text('Confirm'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black54,
                        side: const BorderSide(color: Color(0xFFD1D5DB)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      ),
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Container(
                width: 370,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   // Logo stays as is
                      Image.asset(
                        'assets/logo.png',
                        width: 52,
                        height: 52,
                      ),

                      const SizedBox(height: 8),

                      // Back button + Text in one row
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Color(0xFF20435C)),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Pending Request',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF20435C),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF6DB),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFFDE68A)),
                      ),
                      child: const Text(
                        'Your request is still pending please wait...',
                        style: TextStyle(
                          color: Color(0xFFB08900),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Type
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
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showCancelConfirmation(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF9C7C7),
                          foregroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Cancel Request',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
    );
  }
}