import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailEdukasiScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const DetailEdukasiScreen({super.key, required this.title, required this.icon, required this.color});

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
          "Detail Edukasi",
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
              title,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: primaryBlue),
            ),
            const SizedBox(height: 16),
            Center(
              child: Hero(
                tag: 'edukasi_icon_$title',
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 60),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              "Perawatan yang tepat di rumah dapat membantu mempercepat pemulihan dan mencegah komplikasi.",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            Text(
              "Beberapa hal yang perlu diperhatikan:",
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            _buildCheckItem("Pastikan minum obat sesuai jadwal"),
            const SizedBox(height: 8),
            _buildCheckItem("Lakukan latihan secara rutin"),
            const SizedBox(height: 8),
            _buildCheckItem("Jaga pola makan sehat"),
            const SizedBox(height: 8),
            _buildCheckItem("Kontrol tekanan darah"),
            const SizedBox(height: 8),
            _buildCheckItem("Rutin kontrol ke fasilitas kesehatan"),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
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
                  "Tandai Selesai",
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check, color: primaryGreen, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
