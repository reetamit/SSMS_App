import 'package:flutter/material.dart';

class MandirSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Mandir Schedule'),
        backgroundColor: Colors.deepPurple[700],
      ),*/
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
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
            SizedBox(height: 32),
            Text(
              '🕉️ Aarti Timings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text('• Kakad Aarti – 8:30 AM (All days)'),
            Text('• Madhyana Aarti – 12:00 PM (All days)'),
            Text('• Dhoop Aarti – 6:00 PM (All days)'),
            Text('• Shej Aarti – 8:30 PM (Sun, Mon, Tue, Wed, Fri, Sat)'),
            Text('• Shej Aarti – 9:00 PM (Thursday)'),
            SizedBox(height: 24),
            Text(
              '🛕 Mandir Hours',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text('• Mon, Tue, Wed, Fri:'),
            Text('   8:30 AM to 12:30 PM'),
            Text('   6:00 PM to 8:30 PM'),
            Text('• Sat, Sun: 8:30 AM to 8:30 PM'),
            Text('• Thursday:'),
            Text('   8:00 AM to 2:00 PM'),
            Text('   4:00 PM to 9:30 PM'),
            SizedBox(height: 24),
            Text(
              '🪔 Weekly Abhishekams',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text('• Thursday – 9:30 AM'),
            Text('  All Diety (Shakala Devata) Abhishekam'),
            Text(
              '  (Baba Mula Virat, Dwarakmai Baba, Ganesh, Datta & Anaga Devi)',
            ),
            SizedBox(height: 12),
            Text('• Monday – 7:00 PM'),
            Text('  Shiva Rudrabhishekam'),
            SizedBox(height: 24),
            Text(
              '🌸 Monthly Abhishekams',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text('• Every Month Krithika Nakstram day'),
            Text('  Karthikeya Swamy Abhishekam'),
            SizedBox(height: 12),
            Text('• Every Month Uttara Phalguni Nakstram day'),
            Text('  Ayyappa Swamy Abhishekam'),
            Text('  (Weekly from Nov 15 – Jan 15 during Ayyappa Mandalam)'),
          ],
        ),
      ),
    );
  }
}
