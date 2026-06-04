import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class CatatDataScreen extends StatefulWidget {
  final Map<String, dynamic> patient;
  final int initialIndex;

  const CatatDataScreen({super.key, required this.patient, this.initialIndex = 0});

  @override
  State<CatatDataScreen> createState() => _CatatDataScreenState();
}

class _CatatDataScreenState extends State<CatatDataScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const Color primaryBlue = Color(0xFF26356E);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.initialIndex);
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
          "Catat Data", // In mockup it changes depending on the tab, but for simplicity we keep it static or could change
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryBlue,
          unselectedLabelColor: Colors.grey[400],
          indicatorColor: primaryBlue,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
          unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
          isScrollable: true,
          tabs: const [
            Tab(text: "Tekanan Darah"),
            Tab(text: "Keluhan"),
            Tab(text: "Obat"),
            Tab(text: "Latihan"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTekananDarahTab(context),
          _buildKeluhanTab(context),
          _buildObatTab(context),
          _buildLatihanTab(context),
        ],
      ),
    );
  }

  Widget _buildTekananDarahTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField("Sistolik (mmHg)", "160"),
          const SizedBox(height: 16),
          _buildTextField("Diastolik (mmHg)", "95"),
          const SizedBox(height: 16),
          _buildDateField(context, "Tanggal", "16/05/2025"),
          const SizedBox(height: 16),
          _buildTimeField(context, "Jam", "08:30"),
          const SizedBox(height: 24),
          _buildSimpanButton(context),
          const SizedBox(height: 32),
          Text("Grafik Tekanan Darah", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: primaryBlue)),
          const SizedBox(height: 16),
          _buildBloodPressureChart(),
          const SizedBox(height: 24),
          Text("Riwayat Data", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: primaryBlue)),
          const SizedBox(height: 12),
          _buildRiwayatItem("16/05/2025", "14:00", "170 / 90"),
          const Divider(),
          _buildRiwayatItem("14/05/2025", "08:00", "160 / 85"),
        ],
      ),
    );
  }

  Widget _buildBloodPressureChart() {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
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

  Widget _buildKeluhanTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Gejala yang Dirasakan", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: primaryBlue)),
          const SizedBox(height: 12),
          _buildCheckboxItem("Bicara pelo", true),
          _buildCheckboxItem("Wajah mencong", false),
          _buildCheckboxItem("Kelemahan tangan/kaki", true),
          _buildCheckboxItem("Pusing", false),
          _buildCheckboxItem("Kesemutan", false),
          _buildCheckboxItem("Gangguan penglihatan", false),
          _buildCheckboxItem("Lainnya", false),
          const SizedBox(height: 24),
          _buildTextField("Catatan tambahan (opsional)", "Pasien merasa lemas pada tangan kanan."),
          const SizedBox(height: 24),
          _buildSimpanButton(context),
        ],
      ),
    );
  }

  Widget _buildObatTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Jadwal Obat Harian", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: primaryBlue)),
          const SizedBox(height: 12),
          _buildObatItem("Amlodipine 5 mg", "1x1 - Setelah makan", "08:00", true),
          const SizedBox(height: 16),
          _buildObatItem("Atorvastatin 10 mg", "1x1 - Malam", "20:00", false),
          const SizedBox(height: 32),
          Text("Kepatuhan Mingguan", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700])),
          const SizedBox(height: 8),
          Row(
            children: [
              Text("90%", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: primaryBlue)),
              const SizedBox(width: 16),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: 0.9,
                    minHeight: 10,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(primaryBlue),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSimpanButton(context),
        ],
      ),
    );
  }

  Widget _buildLatihanTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Program Latihan", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: primaryBlue)),
          const SizedBox(height: 12),
          _buildLatihanItem("ROM (Range of Motion)", "10 Menit", true),
          const SizedBox(height: 12),
          _buildLatihanItem("ADL (Activity Daily Living)", "15 Menit", true),
          const SizedBox(height: 12),
          _buildLatihanItem("Ambulasi", "20 Menit", false),
          const SizedBox(height: 12),
          _buildLatihanItem("Latihan Tangan", "10 Menit", false),
          const SizedBox(height: 12),
          _buildLatihanItem("Latihan Kaki", "15 Menit", false),
          const SizedBox(height: 32),
          Text("Progress Hari ini", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700])),
          const SizedBox(height: 8),
          Row(
            children: [
              Text("75%", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: primaryBlue)),
              const SizedBox(width: 16),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: 0.75,
                    minHeight: 10,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(primaryBlue),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSimpanButton(context),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(color: Colors.black87),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context, String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: primaryBlue,
                      onPrimary: Colors.white,
                      onSurface: Colors.black,
                    ),
                  ),
                  child: child!,
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(hint, style: GoogleFonts.poppins(color: Colors.black87)),
                const Icon(Icons.calendar_today, color: primaryBlue, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField(BuildContext context, String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: primaryBlue,
                      onPrimary: Colors.white,
                      onSurface: Colors.black,
                    ),
                  ),
                  child: child!,
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(hint, style: GoogleFonts.poppins(color: Colors.black87)),
                const Icon(Icons.access_time, color: primaryBlue, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSimpanButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Data berhasil disimpan!", style: GoogleFonts.poppins(color: Colors.white)),
            backgroundColor: primaryBlue,
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        "Simpan",
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildRiwayatItem(String date, String time, String bp) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$date   $time", style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87)),
          Text(bp, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildCheckboxItem(String title, bool isChecked) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            isChecked ? Icons.check_box : Icons.check_box_outline_blank,
            color: isChecked ? primaryBlue : Colors.grey[400],
          ),
          const SizedBox(width: 12),
          Text(title, style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildObatItem(String name, String dose, String time, bool isTaken) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.medication, color: primaryBlue, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                    Text(dose, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
              Text(time, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildRadioOption("Sudah diminum", isTaken),
              const SizedBox(width: 16),
              _buildRadioOption("Belum diminum", !isTaken),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLatihanItem(String title, String duration, bool isChecked) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(
            isChecked ? Icons.check_box : Icons.check_box_outline_blank,
            color: isChecked ? primaryBlue : Colors.grey[400],
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                Text(duration, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String label, bool isSelected) {
    return Row(
      children: [
        Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: isSelected ? primaryBlue : Colors.grey[400],
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87)),
      ],
    );
  }
}
