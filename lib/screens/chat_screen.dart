import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'nakes/nakes_dashboard_screen.dart';

class ChatScreen extends StatelessWidget {
  final String targetName;
  final String targetRole;

  const ChatScreen({super.key, this.targetName = "Dr. Siti", this.targetRole = "Dokter Penanggung Jawab"});

  static const Color primaryBlue = Color(0xFF26356E);

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
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: primaryBlue.withValues(alpha: 0.1),
              child: const Icon(Icons.person, color: primaryBlue, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  targetName,
                  style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  targetRole,
                  style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: primaryBlue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: primaryBlue),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildMessageBubble("Selamat pagi dok, tekanan darah Pak Budi pagi ini agak tinggi 160/95. Obat belum diminum.", true, "08:30"),
                const SizedBox(height: 16),
                _buildMessageBubble("Selamat pagi. Segera berikan obat Amlodipine nya sekarang ya. Tolong pantau lagi 2 jam ke depan.", false, "08:35"),
                const SizedBox(height: 16),
                _buildMessageBubble("Baik dok, sudah saya berikan.", true, "08:40"),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isMe, String time) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            constraints: const BoxConstraints(maxWidth: 250),
            decoration: BoxDecoration(
              color: isMe ? null : Colors.white,
              gradient: isMe
                  ? const LinearGradient(
                      colors: [Color(0xFF26356E), Color(0xFF3B4E99)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              border: isMe ? null : Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isMe ? 20 : 4),
                bottomRight: Radius.circular(isMe ? 4 : 20),
              ),
              boxShadow: [
                BoxShadow(
                  color: (isMe ? primaryBlue : Colors.black).withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: isMe ? Colors.white : Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time,
                style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[500]),
              ),
              if (isMe) ...[
                const SizedBox(width: 4),
                const Icon(Icons.done_all, size: 14, color: Colors.blue),
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          children: [
            IconButton(
              icon: Icon(Icons.attach_file, color: Colors.grey[500]),
              onPressed: () {},
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Ketik pesan...",
                    hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[500]),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: const BoxDecoration(
                color: primaryBlue,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 20),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
