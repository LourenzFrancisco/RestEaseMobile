import 'package:flutter/material.dart';
import 'navbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

// ...existing code...

// Add the PaymentScreen widget
class PaymentScreen extends StatefulWidget {
  final String nicheId;
  final String type;
  final String payeeName;
  const PaymentScreen({super.key, required this.nicheId, required this.type, required this.payeeName});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  File? _receiptFile;
  String? _fileName;
  bool _loading = false;

  Future<bool> _requestStoragePermission() async {
    if (await Permission.photos.isGranted || await Permission.storage.isGranted) {
      return true;
    }
    var status = await Permission.photos.request();
    if (status.isGranted) return true;
    if (status.isPermanentlyDenied) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text('Storage permission is permanently denied. Please enable it in your phone\'s app settings.'),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
            TextButton(onPressed: () { openAppSettings(); Navigator.of(ctx).pop(); }, child: const Text('Open Settings')),
          ],
        ),
      );
      return false;
    }
    status = await Permission.storage.request();
    if (status.isGranted) return true;
    if (status.isPermanentlyDenied) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text('Storage permission is permanently denied. Please enable it in your phone\'s app settings.'),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
            TextButton(onPressed: () { openAppSettings(); Navigator.of(ctx).pop(); }, child: const Text('Open Settings')),
          ],
        ),
      );
      return false;
    }
    return false;
  }

  Future<void> _pickReceiptFile() async {
    final granted = await _requestStoragePermission();
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Storage permission is required to select a file.')));
      return;
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf']);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _receiptFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No file selected.')));
    }
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Center(
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
        );
      },
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
                    // Back arrow and title BELOW the logo
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Color(0xFF20435C)),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                            'Payment',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF20435C),
                          ),
                        ),
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
                      controller: TextEditingController(text: widget.nicheId),
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
                      controller: TextEditingController(text: widget.type),
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
                      controller: TextEditingController(text: widget.payeeName),
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
                    // Modern Upload Receipt box
                    GestureDetector(
                      onTap: _pickReceiptFile,
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
                              _fileName != null ? 'Selected: $_fileName' : 'Tap to upload receipt file',
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
                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _receiptFile == null || _loading ? null : () {
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
                        child: _loading
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('Submit', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Cancel button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _loading ? null : () => Navigator.pop(context),
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
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}
