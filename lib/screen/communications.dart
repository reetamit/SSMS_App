import 'package:flutter/material.dart';
import 'package:temple_app/screen/mandir_schedule.dart';
import 'package:temple_app/screen/newletters.dart';

class CommunicationsPage extends StatelessWidget {
  const CommunicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // A DefaultTabController is needed to manage the TabBar and TabBarView.
    return DefaultTabController(
      length: 2, // Must match the number of tabs and children.
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Communications'),
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
              Tab(text: 'Newsletter'),
              Tab(text: 'Mandir Schedule'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // The order of these pages must match the order of the tabs above.
            NewsletterPage(),
            MandirSchedulePage(),
          ],
        ),
      ),
    );
  }
}
