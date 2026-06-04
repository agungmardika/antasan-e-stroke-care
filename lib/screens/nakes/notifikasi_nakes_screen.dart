import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifikasiNakesScreen extends StatelessWidget {
  const NotifikasiNakesScreen({super.key});

  static const Color primaryBlue = Color(0xFF26356E);
  static const Color primaryRed = Color(0xFFD82E1D);

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
          "Notifikasi",
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
          children: [
            _buildNotifikasiItem(
              "Pak Budi: TD 160/95",
              "Perlu perhatian segera karena tekanan darah tinggi.",
              "10 mnt lalu",
              Icons.warning_amber_rounded,
              primaryRed,
            ),
            const SizedBox(height: 12),
            _buildNotifikasiItem(
              "Caregiver Pak Budi",
              "Mengirim pesan: Pasien mengeluh pusing sejak pagi.",
              "1 jam lalu",
              Icons.message_outlined,
              primaryBlue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifikasiItem(String title, String desc, String time, IconData icon, Color color) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
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
                  desc,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
