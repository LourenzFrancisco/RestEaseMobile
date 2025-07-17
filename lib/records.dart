import 'package:flutter/material.dart';
import 'navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import 'requests.dart'; // For FileWebViewScreen
import 'package:url_launcher/url_launcher.dart';
import 'payment.dart';

// Replace RecordsCertificateScreen with a stateful version
class RecordsCertificateScreen extends StatefulWidget {
  const RecordsCertificateScreen({super.key});

  @override
  State<RecordsCertificateScreen> createState() => _RecordsCertificateScreenState();
}

class _RecordsCertificateScreenState extends State<RecordsCertificateScreen> {
  int selectedTab = 0; // 0 = Records, 1 = Certificate

  List<Map<String, dynamic>> _acceptedRequests = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAcceptedRequests();
  }

  Future<void> _loadAcceptedRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId != null) {
      final requests = await fetchAcceptedRequests(userId);
      setState(() {
        _acceptedRequests = requests;
        _loading = false;
      });
    }
  }

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
                    if (_loading)
                      const Center(child: CircularProgressIndicator())
                    else if (_acceptedRequests.isEmpty)
                      const Center(child: Text('No accepted records.'))
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _acceptedRequests.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final req = _acceptedRequests[index];
                          return Card(
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
                                        const Text(
                                          'Accepted',
                                          style: TextStyle(
                                            color: Colors.green,
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
                                                text: req['type'] ?? '',
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
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AcceptedRequestDetailScreen(request: req),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFB0C4D9),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      'View',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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

// =================== Accepted Request Detail Screen ===================
class AcceptedRequestDetailScreen extends StatelessWidget {
  final Map<String, dynamic> request;
  const AcceptedRequestDetailScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    String fileUrl = (request['file_upload_url'] ?? '').toString().trim();
    String fileName = '';
    if (fileUrl.isNotEmpty) {
      fileName = fileUrl.split('/').last;
    }
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
                    Image.asset(
                      'assets/logo.png',
                      width: 52,
                      height: 52,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Color(0xFF20435C)),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Accepted Request',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF20435C),
                          ),
                        ),
                      ],
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
                      controller: TextEditingController(text: request['type'] ?? ''),
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
                      controller: TextEditingController(
                        text: '${request['first_name'] ?? ''} ${request['middle_name'] ?? ''} ${request['last_name'] ?? ''}',
                      ),
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
                      controller: TextEditingController(text: request['age']?.toString() ?? ''),
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
                      controller: TextEditingController(text: request['dob'] ?? ''),
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
                      controller: TextEditingController(text: request['dod'] ?? ''),
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
                      controller: TextEditingController(text: request['residency'] ?? ''),
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
                      controller: TextEditingController(text: request['informant_name'] ?? ''),
                    ),
                    const SizedBox(height: 18),
                    // Uploaded File (with placeholder)
                    const SizedBox(height: 18),
                    const Text(
                      'Uploaded File',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color(0xFF20435C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFD1D5DB),
                          style: BorderStyle.solid,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          Icon(Icons.insert_drive_file_outlined, size: 40, color: Color(0xFF20435C)),
                          const SizedBox(height: 10),
                          Text(
                            fileName.isNotEmpty ? fileName : 'No file uploaded',
                            style: const TextStyle(color: Color(0xFF6B7280), fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          if (fileUrl.isNotEmpty)
                            ElevatedButton.icon(
                              onPressed: () async {
                                    final isImage = fileName.toLowerCase().endsWith('.jpg') ||
                                        fileName.toLowerCase().endsWith('.jpeg') ||
                                        fileName.toLowerCase().endsWith('.png');
                                    if (isImage) {
                                      showDialog(
                                        context: context,
                                        builder: (_) => Dialog(
                                          child: InteractiveViewer(
                                            child: Image.network(fileUrl),
                                          ),
                                        ),
                                      );
                                    } else {
                                      final uri = Uri.parse(fileUrl);
                                      bool launched = false;
                                      try {
                                        if (await canLaunchUrl(uri)) {
                                          launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
                                        }
                                        if (!launched && await canLaunchUrl(uri)) {
                                          launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
                                        }
                                      } catch (e) {
                                        launched = false;
                                      }
                                      if (!launched) {
                                        try {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FileWebViewScreen(url: fileUrl),
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Could not open file. Please check your network or file type.')),
                                          );
                                        }
                                      }
                                    }
                                  },
                              icon: const Icon(Icons.visibility, size: 20),
                              label: const Text('View File'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF20435C),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                        ),
                      ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentScreen(
                                nicheId: request['niche_id']?.toString() ?? '',
                                type: request['type']?.toString() ?? '',
                                payeeName: request['informant_name']?.toString() ?? '',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF94B2CC),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Pay',
                          style: TextStyle(fontSize: 16),
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
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}
