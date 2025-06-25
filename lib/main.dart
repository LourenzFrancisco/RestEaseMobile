import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restease',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool _obscurePassword = true;

  void _login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MapHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF20435C),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF20435C),
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (val) {
                        setState(() {
                          _rememberMe = val ?? false;
                        });
                      },
                    ),
                    const Text('Remember Me'),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xFF20435C),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8CAFC9),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('or'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: Image.asset(
                      'google_logo.webp',
                      width: 20,
                      height: 20,
                    ),
                    label: const Text(
                      'Sign in with google',
                      style: TextStyle(color: Colors.black87),
                    ),
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF8CAFC9)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have account? "),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF8CAFC9),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// New screen after login
class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  String? selectedNicheId;

  // Example static data for demonstration
  final Map<String, Map<String, String>> nicheDetails = {
    '1F-01A': {
      'name': 'Josephine Damdam Y.',
      'age': '1',
      'dob': 'January 12, 2023',
      'dod': 'September 24, 2023',
    },
    // Add more static data for other niches if needed
  };

  void onNicheTap(String id) {
    setState(() {
      selectedNicheId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          // Map area
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(height: 24),
                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(Icons.search, color: Colors.black38),
                        ),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tap to search',
                              hintStyle: TextStyle(color: Colors.black38),
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Map controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // Zoom controls
                      Column(
                        children: [
                          _MapControlButton(icon: Icons.add),
                          const SizedBox(height: 4),
                          _MapControlButton(icon: Icons.remove),
                        ],
                      ),
                      const Spacer(),
                      // Layers/settings button
                      _MapControlButton(icon: Icons.layers_outlined),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Niche grid map with legend overlay
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0EDE6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 32),
                              Container(
                                width: 270,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Color(0xFFE9A94A), width: 1),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              _NicheGrid(
                                onNicheTap: onNicheTap,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Legend in the bottom left corner
                      Positioned(
                        left: 18,
                        bottom: 18,
                        child: _LegendCard(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80), // Space for bottom nav
              ],
            ),
          ),
          // Draggable bottom sheet for details
          DraggableScrollableSheet(
            initialChildSize: 0.10,
            minChildSize: 0.10,
            maxChildSize: 0.35,
            builder: (context, scrollController) {
              if (selectedNicheId == null) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    children: const [
                      Center(
                        child: SizedBox(
                          width: 40,
                          height: 4,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color(0xFFCCCCCC),
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: Text(
                          'No niche selected',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              final details = nicheDetails[selectedNicheId!] ??
                  {
                    'name': 'Unknown',
                    'age': '-',
                    'dob': '-',
                    'dod': '-',
                  };
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  children: [
                    const Center(
                      child: SizedBox(
                        width: 40,
                        height: 4,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color(0xFFCCCCCC),
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        'Niche Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _DetailField(label: 'Niche Id', value: selectedNicheId!),
                    const SizedBox(height: 8),
                    _DetailField(label: 'Name', value: details['name']!),
                    const SizedBox(height: 8),
                    _DetailField(label: 'Age', value: details['age']!),
                    const SizedBox(height: 8),
                    _DetailField(label: 'Date of Birth', value: details['dob']!),
                    const SizedBox(height: 8),
                    _DetailField(label: 'Date Died', value: details['dod']!),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: _BottomNavBar(currentIndex: 0),
    );
  }
}

// Niche grid widget as in the screenshot, now with tap support
class _NicheGrid extends StatelessWidget {
  static const List<List<String>> labels = [
    ['1F-01A', '1F-02A', '1F-03A'],
    ['1F-11A', '1F-12A', '1F-13A'],
    ['1F-21A', '1F-22A', '1F-23A'],
    ['1F-31A', '1F-32A', '1F-33A'],
  ];

  final void Function(String)? onNicheTap;

  const _NicheGrid({this.onNicheTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(labels.length, (row) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(labels[row].length, (col) {
            final id = labels[row][col];
            return GestureDetector(
              onTap: onNicheTap != null ? () => onNicheTap!(id) : null,
              child: Container(
                width: 80,
                height: 60,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Center(
                  child: Text(
                    id,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}

// Niche detail field widget
class _DetailField extends StatelessWidget {
  final String label;
  final String value;
  const _DetailField({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
        const SizedBox(height: 2),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6FA),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black12),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

class _MapControlButton extends StatelessWidget {
  final IconData icon;
  const _MapControlButton({required this.icon});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, color: Colors.black38, size: 22),
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const _BottomNavBar({this.currentIndex = 0});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF20435C),
      unselectedItemColor: Colors.black38,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on_outlined),
          label: 'Niche',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_outlined),
          label: 'Request',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      onTap: (i) {
        if (i == currentIndex) return;
        if (i == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MapHomeScreen()),
          );
        } else if (i == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RequestScreen()),
          );
        } else if (i == 2) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        }
      },
    );
  }
}

// Legend card widget (matches your image)
class _LegendCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      child: Container(
        width: 130,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Vacant',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Color(0xFFD8434C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Sold',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Add the RequestScreen widget
class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  void _showSubmittedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 320,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFF6FFF7),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: const Color(0xFFD6EEDD)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2F7E7),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Icon(Icons.check, color: Color(0xFF4BB543), size: 48),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Request Submitted!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4BB543),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 120,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF4BB543),
                      side: const BorderSide(color: Color(0xFFD6EEDD)),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4BB543),
                      ),
                    ),
                  ),
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
      body: Center(
        child: Container(
          width: 370,
          margin: const EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Color(0xFF20435C)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Image.asset(
                      'logo.png', // Replace with your logo asset
                      width: 36,
                      height: 36,
                    ),
                    const SizedBox(width: 8),
                    
                  ],
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Submit Request',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF20435C),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6FA),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFFE0E0E0)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: DropdownButtonFormField<String>(
                    value: 'Transfer',
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      border: InputBorder.none,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Transfer', child: Text('Transfer')),
                      DropdownMenuItem(value: 'New', child: Text('New')),
                    ],
                    onChanged: (v) {},
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Deceased Information',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF20435C),
                  ),
                ),
                const SizedBox(height: 12),
                _RequestField(label: 'Full Name', value: 'Jobert Manabots X.'),
                const SizedBox(height: 12),
                _RequestField(label: 'Age', value: '34'),
                const SizedBox(height: 12),
                _RequestField(label: 'Date of Born', value: 'April 27, 1977'),
                const SizedBox(height: 12),
                _RequestField(label: 'Date Died', value: 'April 19, 2012'),
                const SizedBox(height: 12),
                _RequestField(label: 'Residency', value: 'Ohio, Mexico Pampanga'),
                const SizedBox(height: 12),
                _RequestField(label: 'Informant Name', value: 'Antique Amor'),
                const SizedBox(height: 20),
                const Text(
                  'Upload Files',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color(0xFF20435C),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFD1D5DB), style: BorderStyle.solid, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFF5F6FA),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Upload birth certificate here',
                        style: TextStyle(color: Color(0xFF6B7280)),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'choose files',
                          style: TextStyle(
                            color: Color(0xFF20435C),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showSubmittedDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8CAFC9),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE5E7EB),
                      foregroundColor: Colors.black54,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _BottomNavBar(currentIndex: 1),
    );
  }
}

class _RequestField extends StatelessWidget {
  final String label;
  final String value;
  const _RequestField({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
        const SizedBox(height: 2),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6FA),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black12),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

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
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Color(0xFF20435C)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'logo.png',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'My Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Color(0xFF20435C),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
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
                    onTap: () {},
                  ),
                  _ProfileOption(
                    icon: Icons.description_outlined,
                    text: 'Records and Certificate',
                    onTap: () {},
                  ),
                  _ProfileOption(
                    icon: Icons.info_outline,
                    text: 'About Us',
                    onTap: () {},
                  ),
                  _ProfileOption(
                    icon: Icons.logout,
                    text: 'Logout',
                    onTap: () {},
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNavBar(currentIndex: 2),
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

