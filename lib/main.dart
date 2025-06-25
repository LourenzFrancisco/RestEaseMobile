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
      bottomNavigationBar: const _BottomNavBar(),
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
  const _BottomNavBar();
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF20435C),
      unselectedItemColor: Colors.black38,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: 0,
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
      onTap: (i) {},
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

