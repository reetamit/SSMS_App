import 'package:flutter/material.dart';

class ContactInfoPage extends StatelessWidget {
  const ContactInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Information'),
        backgroundColor: Colors.deepOrange,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Image.asset(
              'assets/icon/icon.png', // Replace with your actual image path
              height: 45,
              width: 45,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ContactRow(
              icon: Icons.location_on,
              title: 'Address',
              details: ['7450 SW Maynard Rd', 'Cary, NC 27513'],
            ),
            const SizedBox(height: 20),
            ContactRow(
              icon: Icons.email,
              title: 'Mail',
              details: [
                'info@shirdisaimandirnc.org',
                'treasurer@shirdisaimandirnc.org',
                'priest-service@shirdisaimandirnc.org',
              ],
            ),
            const SizedBox(height: 20),
            ContactRow(
              icon: Icons.phone,
              title: 'Phone',
              details: ['(919) 386-1085'],
            ),
          ],
        ),
      ),
    );
  }
}

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> details;

  const ContactRow({
    super.key,
    required this.icon,
    required this.title,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 32, color: Colors.deepOrange),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              ...details.map(
                (line) => Text(line, style: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
