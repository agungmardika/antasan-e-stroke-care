import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'daftar_pasien_screen.dart';
import 'notifikasi_nakes_screen.dart';
import 'profil_nakes_screen.dart';
import '../chat_screen.dart';

class NakesDashboardScreen extends StatelessWidget {
  const NakesDashboardScreen({super.key});

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
              _buildSummaryCards(),
              const SizedBox(height: 24),
              _buildPasienPrioritas(context),
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
                  'Dashboard Nakes',
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NotifikasiNakesScreen()));
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
            "Halo Dr. Siti 👋",
            style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: primaryBlue),
          ),
          const SizedBox(height: 4),
          Text(
            "Puskesmas Banjarbaru",
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700], fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: primaryBlue.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.people, color: Colors.white, size: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "12",
                    style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    "Total Pasien",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.white.withValues(alpha: 0.9)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryRed.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.warning_amber_rounded, color: primaryRed, size: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "3",
                    style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: primaryRed),
                  ),
                  Text(
                    "Perlu Perhatian",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasienPrioritas(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pasien Prioritas",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DaftarPasienScreen()));
                },
                child: Text(
                  "Lihat Semua",
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: primaryBlue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildPrioritasItem(
            "Pak Budi",
            "160/95 mmHg (Tinggi)",
            "Obat Belum",
            primaryRed,
          ),
          const SizedBox(height: 12),
          _buildPrioritasItem(
            "Ibu Ani",
            "150/90 mmHg (Tinggi)",
            "Obat Sudah",
            primaryYellow,
          ),
        ],
      ),
    );
  }

  Widget _buildPrioritasItem(String name, String td, String obatStatus, Color statusColor) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: primaryBlue.withValues(alpha: 0.1),
          highlightColor: primaryBlue.withValues(alpha: 0.05),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: primaryBlue.withValues(alpha: 0.1),
                  child: const Icon(Icons.person, color: primaryBlue, size: 28),
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
                  "TD: $td",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: statusColor),
                ),
                const SizedBox(height: 2),
                Text(
                  "Status: $obatStatus",
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
                const Icon(Icons.chevron_right, color: Colors.grey),
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
          selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12),
          currentIndex: 0, // Beranda
          elevation: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DaftarPasienScreen()));
            } else if (index == 2) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ChatScreen(targetName: "Caregiver Pak Budi", targetRole: "Caregiver")));
            } else if (index == 3) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfilNakesScreen()));
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.home_rounded)),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.people_alt_rounded)),
              label: 'Pasien',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.chat_rounded)),
              label: 'Chat',
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
