import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'obat_harian_screen.dart';
import 'latihan_hari_ini_screen.dart';
import 'caregiver_edukasi_screen.dart';
import 'hubungi_nakes_screen.dart';
import 'riwayat_harian_screen.dart';
import 'profil_caregiver_screen.dart';

class CaregiverDashboardScreen extends StatelessWidget {
  const CaregiverDashboardScreen({super.key});

  static const Color primaryBlue = Color(0xFF26356E);
  static const Color primaryGreen = Color(0xFF007A33);
  static const Color primaryRed = Color(0xFFD82E1D);
  static const Color primaryYellow = Color(0xFFF2B100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 16),
              _buildWelcomeSection(),
              const SizedBox(height: 20),
              _buildStatusCard(),
              const SizedBox(height: 24),
              _buildMenuUtama(context),
              const SizedBox(height: 24),
              _buildNotifikasi(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Image.asset('assets/images/logo_antasan.png', height: 45),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                    children: const [
                      TextSpan(text: 'ANTASAN ', style: TextStyle(color: primaryBlue)),
                      TextSpan(text: 'e-Stroke Care', style: TextStyle(color: primaryRed)),
                    ],
                  ),
                ),
                Text(
                  'Telenursing System',
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: primaryBlue),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RiwayatHarianScreen()));
                  },
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: primaryRed,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Halo Ibu Siti 👋",
            style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: primaryBlue),
          ),
          const SizedBox(height: 4),
          Text(
            "Caregiver: Pak Budi",
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700], fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status Hari Ini",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Stabil",
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: primaryGreen),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusItem(Icons.favorite, "Tekanan Darah\nTerakhir", "140/95", "mmHg", primaryRed),
              _buildStatusItem(Icons.medication, "Obat", "Sudah", "", primaryBlue),
              _buildStatusItem(Icons.directions_walk, "Latihan", "Sudah", "", primaryGreen),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(IconData icon, String title, String value, String unit, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
            children: [
              TextSpan(text: value),
              if (unit.isNotEmpty) TextSpan(text: " $unit", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuUtama(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Menu Utama",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMenuIcon(context, "Obat\nHarian", Icons.medication, primaryBlue, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ObatHarianScreen()));
              }),
              _buildMenuIcon(context, "Latihan\nHari Ini", Icons.directions_walk, primaryGreen, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LatihanHariIniScreen()));
              }),
              _buildMenuIcon(context, "Edukasi\nStroke", Icons.menu_book, primaryRed, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CaregiverEdukasiScreen()));
              }),
              _buildMenuIcon(context, "Hubungi\nNakes", Icons.headset_mic, primaryYellow, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HubungiNakesScreen()));
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuIcon(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      splashColor: color.withValues(alpha: 0.2),
      highlightColor: color.withValues(alpha: 0.1),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4)),
              ],
              border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildNotifikasi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notifikasi",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          _buildNotifItem(Icons.medication, "Minum Amlodipine jam 08:00", primaryBlue),
          _buildNotifItem(Icons.directions_walk, "Latihan ROM jam 09:00", primaryGreen),
          _buildNotifItem(Icons.local_hospital, "Kontrol ke Puskesmas besok", primaryRed),
        ],
      ),
    );
  }

  Widget _buildNotifItem(IconData icon, String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ),
          const Icon(Icons.check_circle_outline, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryBlue,
          unselectedItemColor: Colors.grey[400],
          selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12),
          currentIndex: 0, // Beranda
          elevation: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RiwayatHarianScreen()));
            } else if (index == 2) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CaregiverEdukasiScreen()));
            } else if (index == 3) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfilCaregiverScreen()));
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.home_rounded)),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.history)),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.menu_book_rounded)),
              label: 'Edukasi',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.person_rounded)),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }
}
