/*class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
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
      body: Center(child: Text('This is the About Us page. ???')),
    );
  }
}*/

import 'package:flutter/material.dart';
import '../data/patron_data.dart';
import '../model/patron_category.dart';

class PatronsPage extends StatelessWidget {
  const PatronsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('SSMNC Patrons / Members'),
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
      ),*/
      body: ListView.builder(
        itemCount: allPatronData.length,
        itemBuilder: (context, index) {
          final PatronCategory category = allPatronData[index];
          return ExpansionTile(
            title: Text(
              category.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: category.members.map((member) {
              return ListTile(title: Text(member));
            }).toList(),
          );
        },
      ),
    );
  }
}
