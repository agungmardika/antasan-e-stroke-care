import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<Map<String, dynamic>> _latihanList = [
  {"title": "ROM (Range of Motion)", "duration": "10 Menit", "isChecked": true},
  {"title": "ADL (Activity Daily Living)", "duration": "15 Menit", "isChecked": true},
  {"title": "Ambulasi", "duration": "20 Menit", "isChecked": false},
  {"title": "Latihan Tangan", "duration": "10 Menit", "isChecked": false},
  {"title": "Latihan Kaki", "duration": "15 Menit", "isChecked": false},
];

class LatihanHariIniScreen extends StatefulWidget {
  const LatihanHariIniScreen({super.key});

  @override
  State<LatihanHariIniScreen> createState() => _LatihanHariIniScreenState();
}

class _LatihanHariIniScreenState extends State<LatihanHariIniScreen> {
  static const Color primaryBlue = Color(0xFF26356E);
  static const Color primaryGreen = Color(0xFF007A33);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Latihan Hari Ini",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Program Latihan",
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            ..._latihanList.asMap().entries.map((entry) {
              int idx = entry.key;
              var latihan = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildLatihanCard(latihan["title"], latihan["duration"], latihan["isChecked"], () {
                  setState(() {
                    _latihanList[idx]["isChecked"] = !_latihanList[idx]["isChecked"];
                  });
                }),
              );
            }),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Data latihan berhasil disimpan!", style: GoogleFonts.poppins(color: Colors.white)),
                      backgroundColor: primaryBlue,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Simpan",
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLatihanCard(String title, String duration, bool isChecked, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              color: isChecked ? primaryBlue : Colors.grey[400],
              size: 28,
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
      ),
    );
  }
}
