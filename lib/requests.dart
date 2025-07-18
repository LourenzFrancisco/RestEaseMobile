import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'navbar.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _dobController = TextEditingController();
  final _dodController = TextEditingController();
  final _residencyController = TextEditingController();
  final _informantController = TextEditingController();
  final _nicheIdController = TextEditingController();

  String? _requestType; // null by default
  bool _loading = false;
  File? _deathCertificateFile;

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _dobController.dispose();
    _dodController.dispose();
    _residencyController.dispose();
    _informantController.dispose();
    _nicheIdController.dispose();
    super.dispose();
  }

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

  Future<bool> _requestStoragePermission() async {
    // For Android 13+ use Permission.photos, for older use Permission.storage
    if (await Permission.photos.isGranted || await Permission.storage.isGranted) {
      debugPrint('Permission already granted.');
      return true;
    }
    var status = await Permission.photos.request();
    if (status.isGranted) {
      debugPrint('Permission.photos granted after request.');
      return true;
    }
    if (status.isPermanentlyDenied) {
      debugPrint('Permission.photos permanently denied.');
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text('Storage permission is permanently denied. Please enable it in your phone\'s app settings.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.of(ctx).pop();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
      return false;
    }
    status = await Permission.storage.request();
    if (status.isGranted) {
      debugPrint('Permission.storage granted after request.');
      return true;
    }
    if (status.isPermanentlyDenied) {
      debugPrint('Permission.storage permanently denied.');
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text('Storage permission is permanently denied. Please enable it in your phone\'s app settings.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.of(ctx).pop();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
      return false;
    }
    debugPrint('Permission not granted.');
    return false;
  }

  Future<void> _pickDeathCertificate() async {
    // Request storage permission first
    final granted = await _requestStoragePermission();
    if (!granted) {
      debugPrint('Permission not granted, not opening file picker.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission is required to select an image.')),
      );
      return;
    }
    debugPrint('Opening file picker...');
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _deathCertificateFile = File(result.files.single.path!);
      });
      debugPrint('File selected: \\${result.files.single.path}');
    } else {
      debugPrint('No image selected or permission denied in picker.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected or permission denied.')),
      );
    }
  }

  Future<void> _submitRequest() async {
    setState(() => _loading = true);
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in. Please login again.')),
      );
      setState(() => _loading = false);
      return;
    }

    final url = Uri.parse('http://192.168.100.27/RestEase/ClientSide/clientrequest.php');


    var request = http.MultipartRequest('POST', url);
    request.fields['type'] = _requestType ?? '';
    request.fields['first_name'] = _firstNameController.text;
    request.fields['middle_name'] = _middleNameController.text;
    request.fields['last_name'] = _lastNameController.text;
    request.fields['age'] = _ageController.text;
    request.fields['dob'] = _dobController.text;
    request.fields['dod'] = _dodController.text;
    request.fields['residency'] = _residencyController.text;
    request.fields['informant_name'] = _informantController.text;
    request.fields['user_id'] = userId.toString();

    if (_requestType == 'Transfer' || _requestType == 'Exhumation') {
      request.fields['niche_id'] = _nicheIdController.text;
    }

    if (_deathCertificateFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'file_upload',
        _deathCertificateFile!.path,
      ));
    }

    final response = await request.send();
    setState(() => _loading = false);

    if (response.statusCode == 200) {
      _showSubmittedDialog(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submission failed. Please try again.')),
      );
    }
  }

  String? _validateNameField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    
    // Check for numbers and symbols
    final RegExp invalidChars = RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]');
    if (invalidChars.hasMatch(value)) {
      return '$fieldName should only contain letters and spaces';
    }
    
    return null;
  }

  String? _validateAgeField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Age is required';
    }
    
    // Check if it's a valid number
    if (int.tryParse(value.trim()) == null) {
      return 'Age should only contain numbers';
    }
    
    int age = int.parse(value.trim());
    if (age <= 0 || age > 150) {
      return 'Please enter a valid age';
    }
    
    return null;
  }

  Future<void> _confirmAndSubmitRequest() async {
    // Validate all fields
    String? firstNameError = _validateNameField(_firstNameController.text, 'First Name');
    String? middleNameError = _validateNameField(_middleNameController.text, 'Middle Name');
    String? lastNameError = _validateNameField(_lastNameController.text, 'Last Name');
    String? informantError = _validateNameField(_informantController.text, 'Informant Name');
    String? ageError = _validateAgeField(_ageController.text);
    String? nicheIdError;
    if (_requestType == 'Transfer' || _requestType == 'Exhumation') {
      if (_nicheIdController.text.trim().isEmpty) {
        nicheIdError = 'Niche ID is required for this request type';
      }
    }

    if (_requestType == null ||
        firstNameError != null ||
        middleNameError != null ||
        lastNameError != null ||
        informantError != null ||
        ageError != null ||
        _dobController.text.trim().isEmpty ||
        _dodController.text.trim().isEmpty ||
        _residencyController.text.trim().isEmpty ||
        _deathCertificateFile == null ||
        nicheIdError != null) {
      
      String errorMessage = 'Please fix the following errors:\n';
      List<String> errors = [];
      
      if (_requestType == null) errors.add('- Select a request type');
      if (firstNameError != null) errors.add('- $firstNameError');
      if (middleNameError != null) errors.add('- $middleNameError');
      if (lastNameError != null) errors.add('- $lastNameError');
      if (informantError != null) errors.add('- $informantError');
      if (ageError != null) errors.add('- $ageError');
      if (_dobController.text.trim().isEmpty) errors.add('- Date of Birth is required');
      if (_dodController.text.trim().isEmpty) errors.add('- Date of Death is required');
      if (_residencyController.text.trim().isEmpty) errors.add('- Residency is required');
      if (_deathCertificateFile == null) errors.add('- Death certificate file is required');
      if (nicheIdError != null) errors.add('- $nicheIdError');
      
      errorMessage += errors.join('\n');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 4),
        ),
      );
      return;
    }
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Submission'),
        content: const Text('Are you sure you want to submit this request?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await _submitRequest();
    }
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
                    value: _requestType,
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      border: InputBorder.none,
                    ),
                    items: const [
                      DropdownMenuItem(value: null, child: Text('Select Type')),
                      DropdownMenuItem(value: 'Interment', child: Text('Internment')),
                       DropdownMenuItem(value: 'Transfer', child: Text('Transfer')),
                      DropdownMenuItem(value: 'Exhumation', child: Text('Exhumation')),
                    ],
                    onChanged: (v) {
                      setState(() {
                        _requestType = v;
                      });
                    },
                    validator: (value) => value == null ? 'Please select a type' : null,
                  ),
                ),
                if (_requestType == 'Transfer' || _requestType == 'Exhumation') ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nicheIdController,
                    decoration: InputDecoration(
                      labelText: 'Niche ID',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: 'Enter Niche ID for this request',
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                // Replace the _RequestField widgets with editable TextFields
                const Text(
                  'Deceased Information',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF20435C),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _firstNameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _middleNameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Middle Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _lastNameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _ageController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Age',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          _dobController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _dodController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date Died',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          _dodController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _residencyController,
                  decoration: InputDecoration(
                    labelText: 'Residency',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _informantController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Informant Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
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
                GestureDetector(
                  onTap: _pickDeathCertificate,
                  child: Container(
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
                        Icon(Icons.cloud_upload_outlined, size: 40, color: Color(0xFF20435C)),
                        const SizedBox(height: 10),
                        Text(
                          _deathCertificateFile != null
                              ? 'Selected: \'${_deathCertificateFile!.path.split('/').last}\''
                              : 'Tap to upload death certificate',
                          style: const TextStyle(color: Color(0xFF6B7280), fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF20435C),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Choose File',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _confirmAndSubmitRequest,
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
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const MapHomeScreen()),
                        // );
                      }
                    },
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
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
    );
  }
}

class RequestField extends StatelessWidget {
  final String label;
  final String value;
  const RequestField({super.key, required this.label, required this.value});
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

class FileWebViewScreen extends StatelessWidget {
  final String url;
  const FileWebViewScreen({super.key, required this.url});

  bool _isImage(String url) {
    final lower = url.toLowerCase();
    return lower.endsWith('.jpg') || lower.endsWith('.jpeg') || lower.endsWith('.png');
  }

  @override
  Widget build(BuildContext context) {
    final isImage = _isImage(url);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('View Uploaded File', style: TextStyle(color: Color(0xFF20435C), fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF20435C)),
        elevation: 1,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: isImage
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InteractiveViewer(
                    minScale: 1,
                    maxScale: 1, // disables zoom
                    child: Image.network(
                      url,
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.8,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) => const Text('Failed to load image'),
                    ),
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: WebViewWidget(
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..setBackgroundColor(const Color(0xFFF5F6FA))
                      ..loadRequest(Uri.parse(url)),
                  ),
                ),
        ),
      ),
    );
  }
}