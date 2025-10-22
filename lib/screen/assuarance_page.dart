import 'package:flutter/material.dart';

class AssurancesPage extends StatefulWidget {
  const AssurancesPage({super.key});

  @override
  State<AssurancesPage> createState() => _AssurancesPageState();
}

class _AssurancesPageState extends State<AssurancesPage> {
  final List<String> teachings = [
    "Whoever puts his feet on Shirdi soil, his sufferings would come to an end.",
    "The wretched and miserable will rise to joy and happiness as soon as they climb the steps of the mosque.",
    "I shall be ever active and vigorous even after leaving this earthly body.",
    "My tomb shall bless and speak to the needs of my devotees.",
    "I shall be active and vigorous even from my tomb.",
    "My mortal remains will speak from my tomb.",
    "I am ever living to help and guide all who come to me, who surrender to me and who seek refuge in me.",
    "If you look to me, I look to you.",
    "If you cast your burden on me, I shall surely bear it.",
    "If you seek my advice and help, it shall be given to you at once.",
    "There shall be no want in the house of my devotee.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('श्रद्धा सबुरी'),
        backgroundColor: Colors.deepPurple[700],
      ),*/
      body: ListView(
        padding: EdgeInsets.all(20),
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
          SizedBox(height: 10),
          ...teachings.map(
            (quote) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                '• $quote',
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
