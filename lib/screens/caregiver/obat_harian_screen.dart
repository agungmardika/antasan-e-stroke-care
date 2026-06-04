import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<Map<String, dynamic>> _obatList = [
  {"title": "Amlodipine 5 mg", "subtitle": "1x1 - Setelah Makan", "time": "08:00", "isChecked": true},
  {"title": "Atorvastatin 10 mg", "subtitle": "1x1 - Malam", "time": "20:00", "isChecked": true},
  {"title": "Clopidogrel 75 mg", "subtitle": "1x1 - Setelah Makan", "time": "08:00", "isChecked": false},
];

class ObatHarianScreen extends StatefulWidget {
  const ObatHarianScreen({super.key});

  @override
  State<ObatHarianScreen> createState() => _ObatHarianScreenState();
}

class _ObatHarianScreenState extends State<ObatHarianScreen> {
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
          "Obat Harian",
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
              "Daftar Obat",
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            ..._obatList.asMap().entries.map((entry) {
              int idx = entry.key;
              var obat = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildObatCard(obat["title"], obat["subtitle"], obat["time"], obat["isChecked"], () {
                  setState(() {
                    _obatList[idx]["isChecked"] = !_obatList[idx]["isChecked"];
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
                      content: Text("Data obat berhasil disimpan!", style: GoogleFonts.poppins(color: Colors.white)),
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

  Widget _buildObatCard(String title, String subtitle, String time, bool isChecked, VoidCallback onTap) {
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
                  subtitle,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
      ),
    );
  }
}
