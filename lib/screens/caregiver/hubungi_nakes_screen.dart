import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HubungiNakesScreen extends StatelessWidget {
  const HubungiNakesScreen({super.key});

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
          "Hubungi Nakes",
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
              "Tenaga Kesehatan",
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            _buildContactCard("Dr. Siti", "Dokter Penanggung Jawab", Icons.person),
            const SizedBox(height: 12),
            _buildContactCard("Fisio Andi", "Fisioterapis", Icons.person),
            const SizedBox(height: 12),
            _buildContactCard("Ns. Rina", "Perawat", Icons.person_3),
            const SizedBox(height: 12),
            _buildContactCard("Apt. Dwi", "Apoteker", Icons.person_3),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(String name, String role, IconData icon) {
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
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: primaryBlue.withValues(alpha: 0.1),
            child: Icon(icon, color: primaryBlue, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  role,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryGreen.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.chat, color: primaryGreen, size: 20),
          ),
        ],
      ),
    );
  }
}
