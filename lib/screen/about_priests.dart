import 'package:flutter/material.dart';

class PriestProfilesPage extends StatefulWidget {
  const PriestProfilesPage({super.key});

  @override
  State<PriestProfilesPage> createState() => _PriestProfilesPageState();
}

class _PriestProfilesPageState extends State<PriestProfilesPage> {
  final List<Map<String, dynamic>> priests = [
    {
      'name': 'Pandit RajaSwamy Kummarigunta',
      'title': 'Vedic Priest – Sai Mandir',
      'image': 'assets/images/rajaswamy_kummarigunta.png',
      'bio': '''
Pandit RajaSwamy Kummarigunta, a native of Guntur in Andhra Pradesh, joined Sai Mandir in April 2024. He holds extensive qualifications in Vedic rituals and religious services, completing Pancharatra Agama Pravesa (1998), Vara (2002), and Pravara (2013) from the Andhra Pradesh Endowments Department.

He previously served at The Hindu Temple of St. Louis (2014–2024), Shri Shiridi Saibaba Temple in Hyderabad (1996–2014), and SeetaramaSwamy Devasthanam in Guntur (1983–1996), performing major rituals like Kumbhabhishekam, Sudharshana Yagam, Vigraha Pratistas, and Lakshmi Ganapathi Homam.

His expertise includes Homams (Ganapathy, Rudra, Chandi), Pujas (Satyanarayana Vratam, Namakaranam), and ceremonies like Gruha Pravesham, Bhoomi Pooja, Sashtipoorthi, and Laksha Tulasi Archana.
''',
      'languages': 'Telugu, English, Hindi, Tamil',
    },
    {
      'name': 'Shri V. Anil Kumar Sarma',
      'title': 'Vedic Priest – Krishna Yajurveda',
      'image': 'assets/images/anil_kumar_sarma.png',
      'bio': '''
Shri V. Anil Kumar Sarma is a highly experienced Vedic priest with deep expertise in Krishna Yajurveda, Smartha traditions, and Vaidika Agama practices. Originally from Hyderabad, he served at Shri Shirdi Sai Baba Mandir in Chicago (2018–2024) and other temples across India and the U.S.

With over 18 years of service, he has performed Nityothsavam, Brahmotsavam, Kumbhabhishekam, Kalayanothsavam, and Vaidika karmas like Upanayanam, Vivaha, Gruhapravesam, and Bhumipooja.

His calm demeanor and spiritual depth make him a beloved priest among devotees of all backgrounds.
''',
      'languages': 'English, Hindi, Telugu',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('श्रद्धा सबुरी'),
        backgroundColor: Colors.deepPurple[700],
      ),*/
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: priests.length + 1, // +1 for the heading
        itemBuilder: (context, index) {
          if (index == 0) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'श्रद्धा         सबुरी',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            );
          }

          final priest = priests[index - 1]; // Adjust index for data
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          priest['image']!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              priest['name']!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              priest['title']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    priest['bio']!,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Languages Fluent: ${priest['languages']}',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
