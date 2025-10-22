import 'package:flutter/material.dart';

class DirectorsScreen extends StatelessWidget {
  final List<Map<String, String>> executiveTeam = [
    {
      'name': 'Anand Ramakrishna',
      'role': 'President & Purchase/Inventory',
      'image': 'assets/images/directors/anand_ramakrishna.png',
    },
    {
      'name': 'Sangita Yete',
      'role': 'Vice President & Prasadam Chair',
      'image': 'assets/images/directors/sangita_yete.png',
    },
    {
      'name': 'Rao Nanduri',
      'role': 'Treasurer',
      'image': 'assets/images/directors/rao_nanduri.png',
    },
    {
      'name': 'Radha Pazhaveeri',
      'role': 'General Secretary & Bala Vikas',
      'image': 'assets/images/directors/radha_pazhaveeri.png',
    },
    {
      'name': 'Latha Tenneti',
      'role': 'Religious',
      'image': 'assets/images/directors/latha_tenneti.png',
    },
    {
      'name': 'Chithra Loganathan',
      'role': 'Religious',
      'image': 'assets/images/directors/chithra_loganathan.png',
    },
    {
      'name': 'Kumar Srinivasan',
      'role': 'Cultural & Volunteer',
      'image': 'assets/images/directors/kumar_srinivasan.png',
    },
    {
      'name': 'Sandeep Dongre',
      'role': 'Communication',
      'image': 'assets/images/directors/sandeep_dongre.png',
    },
    {
      'name': 'Dhivya Pydimarry',
      'role': 'Sai Care',
      'image': 'assets/images/directors/dhivya_pydimarry.png',
    },
    {
      'name': 'Balaji Komera',
      'role': 'Facilities',
      'image': 'assets/images/directors/balaji_komera.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Leadership Team'),
        backgroundColor: Colors.indigo[900],
      ),*/
      body: Container(
        color: Color(0xFFfff1d9),
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: executiveTeam.length,
          itemBuilder: (context, index) {
            final leader = executiveTeam[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 12),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    /*CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(leader['image']!),
                    ),*/
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // Adjust corner mold here
                      child: Image.asset(
                        leader['image']!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leader['name']!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 200, // Adjust width to control wrapping
                          child: Text(
                            leader['role']!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow
                                .ellipsis, // Optional: adds "..." if too long
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
