import 'package:flutter/material.dart';
import 'package:root2route/core/theme/app_colors.dart';

class AddMemberScreen extends StatelessWidget {
  const AddMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Color.fromARGB(255, 39, 89, 226),
                  child: Icon(
                    Icons.business,
                    size: 36,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "ITI ",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 11, 11, 11),
                  ),
                ),

                const SizedBox(height: 40),

                InviteForm(),

                const SizedBox(height: 32),

                PendingInvitations(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget InviteForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.person_add_alt_1, color: Color(0xFF1E3A8A)),
              SizedBox(width: 10),
              Text(
                "Member Invitation",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text("  Email", style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: "example@gmail.com",
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.OrganizationColor,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "  Send an invitation",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget PendingInvitations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "  Pending invitations",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "1 Active",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListTile(
          contentPadding: const EdgeInsets.all(12),
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade100),
          ),
          leading: const CircleAvatar(
            child: Icon(Icons.person, size: 24, color: Colors.white),
          ),
          title: const Text(
            "anton@gmail.com",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),

          trailing: TextButton(
            onPressed: () {},
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.blue),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
