import 'package:flutter/material.dart';

class LeadershipScreen extends StatelessWidget {
  final List<Map<String, String>> leaders = [
    {
      'name': 'Manitha Reddy',
      'title': 'Chairman',
      'image': 'assets/images/leaders/manitha_reddy.png',
    },
    {
      'name': 'Ganesh Subramanian',
      'title': 'Vice Chairman',
      'image': 'assets/images/leaders/ganesh_subramanian.png',
    },
    {
      'name': 'Gopi Sundaram',
      'title': 'Treasurer',
      'image': 'assets/images/leaders/gopi_sundaram.png',
    },
    {
      'name': 'Sujatha Jetty',
      'title': 'General Secretary',
      'image': 'assets/images/leaders/sujatha_jetty.png',
    },
    {
      'name': 'Chaithanya Pola',
      'title': 'Religious',
      'image': 'assets/images/leaders/chaithanya_pola.png',
    },
    {
      'name': 'Poornima Budda',
      'title': 'Cultural & Volunteer',
      'image': 'assets/images/leaders/poornima_budda.png',
    },
    {
      'name': 'Siva Natarajan',
      'title': 'Purchase & Inventory',
      'image': 'assets/images/leaders/siva_natarajan.png',
    },
    {
      'name': 'Narmada Bommareddi',
      'title': 'Prasadam',
      'image': 'assets/images/leaders/narmada_bommareddi.png',
    },
    {
      'name': 'Gourinath Jammu',
      'title': 'Facilities & Construction',
      'image': 'assets/images/leaders/gourinath_jammu.png',
    },
    {
      'name': 'Ramesh Vaddi',
      'title': 'Construction Advisory',
      'image': 'assets/images/leaders/ramesh_vaddi.png',
    },
    {
      'name': 'Vijay Agarwal',
      'title': 'Communication',
      'image': 'assets/images/leaders/vijay_agarwal.png',
    },
    {
      'name': 'Jignasa Patel',
      'title': 'Honorary BOT',
      'image': 'assets/images/leaders/jignasa_patel.png',
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
          itemCount: leaders.length,
          itemBuilder: (context, index) {
            final leader = leaders[index];
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
                        Text(
                          leader['title']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
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
