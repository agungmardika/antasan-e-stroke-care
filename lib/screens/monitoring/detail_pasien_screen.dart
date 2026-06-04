import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'catat_data_screen.dart';
import '../edukasi/edukasi_stroke_screen.dart';

class DetailPasienScreen extends StatelessWidget {
  final Map<String, dynamic> patient;

  const DetailPasienScreen({super.key, required this.patient});

  static const Color primaryBlue = Color(0xFF26356E);
  static const Color primaryGreen = Color(0xFF007A33);
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
          "Detail Pasien",
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            CircleAvatar(
              radius: 40,
              backgroundColor: primaryBlue.withValues(alpha: 0.1),
              child: Icon(
                patient["icon"] as IconData,
                color: primaryBlue,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),

            // Patient Info
            Text(
              patient["name"] as String,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              patient["subtitle1"] as String,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "ID: 630104*****",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: patient["color"] as Color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                patient["status"] as String,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),

            // Ringkasan Kondisi
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ringkasan Kondisi",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
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
              child: Column(
                children: [
                  _buildSummaryRow("Tekanan Darah", "${patient["bp"]} mmHg", valueColor: patient["color"] as Color),
                  const Divider(height: 24),
                  _buildSummaryRow("Keluhan", "Lemas, Bicara pelo"),
                  const Divider(height: 24),
                  _buildSummaryRow("Obat", "Amlodipine 1x1"),
                  const Divider(height: 24),
                  _buildSummaryRow("Latihan", "ROM 10 Menit"),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Grafik Tekanan Darah
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tren Tekanan Darah",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildBloodPressureChart(),

            const SizedBox(height: 24),

            // Riwayat Penyakit
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Riwayat Penyakit",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBulletPoint("Hipertensi"),
                  const SizedBox(height: 8),
                  _buildBulletPoint("Diabetes Mellitus"),
                  const SizedBox(height: 8),
                  _buildBulletPoint("Dislipidemia"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomAction(
                context,
                Icons.edit_document,
                "Catat Data",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CatatDataScreen(patient: patient, initialIndex: 0)));
                },
              ),
              _buildBottomAction(
                context,
                Icons.directions_walk,
                "Rehab",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CatatDataScreen(patient: patient, initialIndex: 3)));
                },
              ),
              _buildBottomAction(
                context,
                Icons.medication,
                "Obat",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CatatDataScreen(patient: patient, initialIndex: 2)));
                },
              ),
              _buildBottomAction(
                context,
                Icons.menu_book,
                "Edukasi",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EdukasiStrokeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBloodPressureChart() {
    return Container(
      height: 200,
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
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 20),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30, interval: 40)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 22, interval: 1, getTitlesWidget: (value, meta) {
              const dates = ['12/5', '13/5', '14/5', '15/5', '16/5'];
              if (value.toInt() >= 0 && value.toInt() < dates.length) {
                return Text(dates[value.toInt()], style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey));
              }
              return const Text('');
            })),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 4,
          minY: 60,
          maxY: 200,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 150),
                FlSpot(1, 145),
                FlSpot(2, 160),
                FlSpot(3, 155),
                FlSpot(4, 170), // sistolik
              ],
              isCurved: true,
              color: const Color(0xFFD82E1D), // primaryRed
              barWidth: 3,
              dotData: const FlDotData(show: true),
            ),
            LineChartBarData(
              spots: const [
                FlSpot(0, 90),
                FlSpot(1, 85),
                FlSpot(2, 85),
                FlSpot(3, 90),
                FlSpot(4, 90), // diastolik
              ],
              isCurved: true,
              color: const Color(0xFF26356E), // primaryBlue
              barWidth: 3,
              dotData: const FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color valueColor = Colors.black87}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 8, color: primaryBlue),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction(BuildContext context, IconData icon, String label, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: primaryBlue, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}
