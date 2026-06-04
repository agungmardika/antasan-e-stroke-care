import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'caregiver_dashboard_screen.dart';
import 'riwayat_harian_screen.dart';
import 'caregiver_edukasi_screen.dart';
import '../auth/login_screen.dart';

class ProfilCaregiverScreen extends StatelessWidget {
  const ProfilCaregiverScreen({super.key});

  static const Color primaryBlue = Color(0xFF26356E);
  static const Color primaryRed = Color(0xFFD82E1D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Profil Caregiver",
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
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: primaryBlue.withValues(alpha: 0.1),
                    child:
                        const Icon(Icons.person, size: 60, color: primaryBlue),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Ibu Siti",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Caregiver Pak Budi",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildProfileMenu(Icons.person_outline, "Profil Saya", () {}),
            const SizedBox(height: 16),
            _buildProfileMenu(Icons.lock_outline, "Ubah Password", () {}),
            const SizedBox(height: 16),
            _buildProfileMenu(Icons.info_outline, "Tentang Aplikasi", () {}),
            const SizedBox(height: 16),
            _buildProfileMenu(
              Icons.logout,
              "Keluar",
              () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
              },
              isLogout: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildProfileMenu(IconData icon, String title, VoidCallback onTap,
      {bool isLogout = false}) {
    final color = isLogout ? primaryRed : Colors.black87;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ),
                if (!isLogout) const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
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
          selectedLabelStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12),
          currentIndex: 3, // Akun
          elevation: 0,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CaregiverDashboardScreen()));
            } else if (index == 1) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RiwayatHarianScreen()));
            } else if (index == 2) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CaregiverEdukasiScreen()));
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.home_rounded)),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.history)),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.menu_book_rounded)),
              label: 'Edukasi',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(Icons.person_rounded)),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }
}
