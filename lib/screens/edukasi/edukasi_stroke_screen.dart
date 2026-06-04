import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../caregiver/detail_edukasi_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../monitoring/monitoring_pasien_screen.dart';
import '../dashboard/profil_kader_screen.dart';

class EdukasiStrokeScreen extends StatelessWidget {
  const EdukasiStrokeScreen({super.key});

  static const Color primaryBlue = Color(0xFF26356E);
  static const Color primaryGreen = Color(0xFF007A33);
  static const Color primaryRed = Color(0xFFD82E1D);
  static const Color primaryYellow = Color(0xFFF2B100);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Navigator.canPop(context),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
              }
            },
          ),
          title: Text(
            "Edukasi Stroke",
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
              _buildEdukasiCard(context, "Kenali Tanda Stroke (FAST)", Icons.warning_amber_rounded, primaryRed),
              const SizedBox(height: 12),
              _buildEdukasiCard(context, "Apa itu Stroke", Icons.info_outline, primaryBlue),
              const SizedBox(height: 12),
              _buildEdukasiCard(context, "Pencegahan Stroke", Icons.health_and_safety_outlined, primaryBlue),
              const SizedBox(height: 12),
              _buildEdukasiCard(context, "Perawatan Pasca Stroke", Icons.medical_services_outlined, primaryBlue),
              const SizedBox(height: 12),
              _buildEdukasiCard(context, "TOGA Bawang Dayak", Icons.eco_outlined, primaryGreen),
              const SizedBox(height: 12),
              _buildEdukasiCard(context, "Latihan Rehabilitasi", Icons.directions_walk, primaryYellow),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNav(context),
      ),
    );
  }

  Widget _buildEdukasiCard(BuildContext context, String title, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailEdukasiScreen(title: title, icon: icon, color: color)));
      },
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
            Hero(
              tag: 'edukasi_icon_$title',
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
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
          currentIndex: 2, // Edukasi selected
          elevation: 0,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
            } else if (index == 1) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MonitoringPasienScreen()));
            } else if (index == 3) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfilKaderScreen()));
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.home_rounded),
              ),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.people_alt_rounded),
              ),
              label: 'Pasien',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.menu_book_rounded),
              ),
              label: 'Edukasi',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.person_rounded),
              ),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }
}
