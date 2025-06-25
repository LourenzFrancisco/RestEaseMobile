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
      home: const SplashScreen(),
    );
  }
}

// SplashScreen widget
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF94B2CC), // 20%
              Color(0xFF617E96), // 96%
              Color(0xFF506C84), // 100%
            ],
            stops: [0.2, 0.96, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 90,
                height: 90,
              ),
              
            ],
          ),
        ),
      ),
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
      body: Stack(
        children: [
          // Top and bottom blue background
          Positioned.fill(
            child: Container(
              color: const Color(0xFF20435C),
            ),
          ),
          // White card with custom border radius and blue accent
          Align(
            alignment: Alignment.center,
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
                  border: Border.all(
                    color: const Color(0xFF94B2CC),
                    width: 5,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    const SizedBox(height: 8),
                    Image.asset(
                      'assets/logo.png',
                      width: 90,
                      height: 60,
                    ),
                    const SizedBox(height: 18),
                    // Login title
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF20435C),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Email field
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Color(0xFF8CAFC9)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Color(0xFF8CAFC9), width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Color(0xFF20435C), width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Password field
                    TextField(
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Color(0xFF8CAFC9)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Color(0xFF8CAFC9), width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(color: Color(0xFF20435C), width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF8CAFC9),
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
                    // Remember Me and Forgot Password
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (val) {
                            setState(() {
                              _rememberMe = val ?? false;
                            });
                          },
                          activeColor: const Color(0xFF8CAFC9),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        const Text('Remember Me', style: TextStyle(fontSize: 14)),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color(0xFF8CAFC9),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF94B2CC),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Divider with or
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
                    // Google button
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: OutlinedButton.icon(
                        icon: Image.asset(
                          'assets/google_logo.webp',
                          width: 20,
                          height: 20,
                        ),
                        label: const Text(
                          'Sign in with google',
                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF8CAFC9)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account? ", style: TextStyle(fontSize: 14)),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF8CAFC9),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom blue accent curve
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF20435C),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
            ),
          ),
        ],
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
                      'Okay',
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
                    Image.asset(
                      'assets/logo.png', // Replace with your logo asset
                      width: 52,
                      height: 52,
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Aligns to the left
                  children: [
                    const SizedBox(width: 4),
                    const Text(
                      'Submit Request',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF20435C),
                      ),
                    ),
                  ],
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
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                    onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MapHomeScreen()),
                      );
                    }
                  }
                  ,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE5E7EB),
                        foregroundColor: Colors.black54,
                        padding: EdgeInsets.symmetric(vertical: 14),
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
                      fontSize: 22,
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
      bottomNavigationBar: _BottomNavBar(currentIndex: 2),
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
      bottomNavigationBar: _BottomNavBar(currentIndex: 2),
    );
  }
}

// Add the PaymentScreen widget
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

 void _showPaymentSuccessDialog(BuildContext context) {
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
                child: const Icon(Icons.check, color: Color(0xFF10B981), size: 48),
              ),
              const SizedBox(height: 18),
              const Text(
                'Payment Submitted!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF10B981),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 120,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF10B981),
                    side: const BorderSide(color: Color(0xFFD6EEDD)),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    'Okay',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF10B981),
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
                    // Logo
                    Row(
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: 52,
                          height: 52,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Back arrow and title
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Color(0xFF20435C)),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Payment',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF20435C),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 32), // for symmetry
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Niche Id
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Niche Id',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      controller: TextEditingController(text: '1F-01FB'),
                    ),
                    const SizedBox(height: 12),
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
                    const SizedBox(height: 12),
                    // Payee Name
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Payee Name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      controller: TextEditingController(text: 'Josephine Damdam Y.'),
                    ),
                    const SizedBox(height: 18),
                    // Upload Receipt label
                    const Text(
                      'Upload Receipt',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color(0xFF20435C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Upload Receipt box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFD1D5DB),
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        // Dashed border not natively supported, so use solid for now
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Upload Receipt here',
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
                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showPaymentSuccessDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB0C4D9),
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
                    // Cancel button
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
        ),
      ),
      bottomNavigationBar: _BottomNavBar(currentIndex: 2),
    );
  }
}

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
                  // Logo, back button, and title (as per your latest layout)
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
                    // Certificate tab: show large gray box
                    Container(
                      width: double.infinity,
                      height: 350,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(currentIndex: 2),
    );
  }
}

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
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RestEase',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF20435C),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'RestEase is dedicated to providing a seamless and respectful experience for managing memorial records and certificates. Our mission is to help families and communities with easy access to important information and services, all in one place.',
                          style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.4),
                        ),
                        SizedBox(height: 18),
                        Text(
                          'Contact Us:',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF20435C)),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Email: support@restease.com\nPhone: +1 234 567 8900',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
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
      bottomNavigationBar: const _BottomNavBar(currentIndex: 2),
    );
  }
}

