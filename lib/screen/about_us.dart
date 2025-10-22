import 'package:flutter/material.dart';
import 'package:temple_app/screen/about_priests.dart';
import 'package:temple_app/screen/assuarance_page.dart';
import 'package:temple_app/screen/director_page.dart';
import 'package:temple_app/screen/leadership_page.dart';
import 'package:temple_app/screen/patrons_page.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // A DefaultTabController is needed to manage the TabBar and TabBarView.
    return DefaultTabController(
      length: 5, // Must match the number of tabs and children.
      child: Scaffold(
        appBar: AppBar(
          title: const Text('About Us'),
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
          bottom: const TabBar(
            labelColor: Colors.white,
            // Use isScrollable to ensure all five tabs are visible and can be scrolled if space is limited.
            isScrollable: true,
            tabs: [
              Tab(text: 'Patrons / Members'),
              Tab(text: 'Trustees'),
              Tab(text: 'Board of Directors'),
              Tab(text: 'Sai Assurances'),
              Tab(text: 'SSMNC Priests'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // The order of these pages must match the order of the tabs above.
            PatronsPage(),
            LeadershipScreen(),
            DirectorsScreen(),
            AssurancesPage(),
            PriestProfilesPage(),
          ],
        ),
      ),
    );
  }
}
