import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_medis_screen.dart';
import 'nakes_dashboard_screen.dart';

class DaftarPasienScreen extends StatefulWidget {
  const DaftarPasienScreen({super.key});

  @override
  State<DaftarPasienScreen> createState() => _DaftarPasienScreenState();
}

class _DaftarPasienScreenState extends State<DaftarPasienScreen> {
  static const Color primaryBlue = Color(0xFF26356E);
  static const Color primaryGreen = Color(0xFF007A33);
  static const Color primaryRed = Color(0xFFD82E1D);
  static const Color primaryYellow = Color(0xFFF2B100);

  final List<Map<String, dynamic>> _patients = [
    {"name": "Pak Budi", "status": "Risiko Tinggi", "color": primaryRed, "td": "160/95"},
    {"name": "Ibu Aisyah", "status": "Stabil", "color": primaryGreen, "td": "120/80"},
    {"name": "Pak Rahmat", "status": "Risiko Sedang", "color": primaryYellow, "td": "140/90"},
    {"name": "Ibu Ani", "status": "Risiko Tinggi", "color": primaryRed, "td": "150/90"},
  ];

  String _searchQuery = "";

  List<Map<String, dynamic>> get _filteredPatients {
    if (_searchQuery.isEmpty) return _patients;
    return _patients.where((p) {
      final name = p["name"].toString().toLowerCase();
      return name.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Navigator.canPop(context),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NakesDashboardScreen()));
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NakesDashboardScreen()));
            }
          },
        ),
        title: Text(
          "Daftar Pasien",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(
            child: _filteredPatients.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded, size: 60, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          "Pasien tidak ditemukan",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Coba kata kunci lain",
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemCount: _filteredPatients.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final p = _filteredPatients[index];
                      return _buildPatientCard(context, p["name"], p["status"], p["color"], p["td"]);
                    },
                  ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
        child: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: "Cari pasien...",
            hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.grey[400]),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildChip("Semua", true),
          const SizedBox(width: 8),
          _buildChip("Risiko Tinggi", false),
          const SizedBox(width: 8),
          _buildChip("Stabil", false),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? primaryBlue : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? primaryBlue : Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? Colors.white : Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildPatientCard(BuildContext context, String name, String status, Color statusColor, String td) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailMedisScreen()));
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
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        status,
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "TD Terakhir",
                  style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[500]),
                ),
                Text(
                  td,
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: statusColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
