import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'beri_feedback_screen.dart';
import 'update_program_screen.dart';

class DetailMedisScreen extends StatefulWidget {
  const DetailMedisScreen({super.key});

  @override
  State<DetailMedisScreen> createState() => _DetailMedisScreenState();
}

class _DetailMedisScreenState extends State<DetailMedisScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const Color primaryBlue = Color(0xFF26356E);
  static const Color primaryGreen = Color(0xFF007A33);
  static const Color primaryRed = Color(0xFFD82E1D);
  static const Color primaryYellow = Color(0xFFF2B100);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          "Detail Medis",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileSection(),
            _buildTabBar(),
            SizedBox(
              height: 400, // Fixed height for tab content
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildRiwayatTab(),
                  _buildObatTab(),
                  _buildLatihanTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(context),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFFE8F0FE),
            child: Icon(Icons.person, color: primaryBlue, size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            "Pak Budi",
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            "65 Tahun | Laki-laki | ID: 630104***",
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: primaryRed,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Risiko Tinggi",
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: primaryBlue,
        unselectedLabelColor: Colors.grey[400],
        indicatorColor: primaryBlue,
        labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
        unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
        tabs: const [
          Tab(text: "Riwayat"),
          Tab(text: "Obat"),
          Tab(text: "Latihan"),
        ],
      ),
    );
  }

  Widget _buildRiwayatTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Text(
          "Grafik Tekanan Darah",
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        _buildBloodPressureChart(),
        const SizedBox(height: 24),
        Text(
          "Catatan Caregiver",
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: primaryYellow.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: primaryYellow.withValues(alpha: 0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded, color: primaryYellow, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Pasien mengeluh pusing dan lemas sejak pagi. Tekanan darah cenderung naik.",
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBloodPressureChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
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
                FlSpot(4, 170),
              ],
              isCurved: true,
              color: primaryRed,
              barWidth: 3,
              dotData: const FlDotData(show: true),
            ),
            LineChartBarData(
              spots: const [
                FlSpot(0, 90),
                FlSpot(1, 85),
                FlSpot(2, 85),
                FlSpot(3, 90),
                FlSpot(4, 90),
              ],
              isCurved: true,
              color: primaryBlue,
              barWidth: 3,
              dotData: const FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildObatTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildDummyItem("Amlodipine 5 mg", "1x1 - Setelah Makan", Icons.medication, primaryBlue),
        const SizedBox(height: 12),
        _buildDummyItem("Atorvastatin 10 mg", "1x1 - Malam", Icons.medication, primaryBlue),
        const SizedBox(height: 12),
        _buildDummyItem("Clopidogrel 75 mg", "1x1 - Pagi", Icons.medication, primaryBlue),
      ],
    );
  }

  Widget _buildLatihanTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildDummyItem("ROM (Range of Motion)", "10 Menit", Icons.directions_walk, primaryGreen),
        const SizedBox(height: 12),
        _buildDummyItem("ADL (Activity Daily Living)", "15 Menit", Icons.directions_walk, primaryGreen),
        const SizedBox(height: 12),
        _buildDummyItem("Ambulasi", "20 Menit", Icons.directions_walk, primaryGreen),
      ],
    );
  }

  Widget _buildDummyItem(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
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
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const BeriFeedbackScreen()));
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: primaryBlue),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  "Beri Feedback",
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: primaryBlue),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProgramScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  "Update Program",
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
