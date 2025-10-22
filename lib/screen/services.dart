import 'package:flutter/material.dart';
import 'package:temple_app/screen/bala_class.dart';
import 'package:temple_app/screen/rudra_chanting.dart';
import 'package:temple_app/screen/sai_care.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // A DefaultTabController is needed to manage the TabBar and TabBarView.
    return DefaultTabController(
      length: 3, // Must match the number of tabs and children.
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Services'),
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
              Tab(text: 'Sai Care'),
              Tab(text: 'Bala Vikas Classes'),
              Tab(text: 'Rudram Classes'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // The order of these pages must match the order of the tabs above.
            SaiCarePage(),
            BalaClassPage(),
            RudraChantingPage(),
          ],
        ),
      ),
    );
  }
}
