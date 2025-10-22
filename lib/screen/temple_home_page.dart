import 'package:flutter/material.dart';
import 'package:temple_app/screen/about_us.dart';
import 'package:temple_app/screen/admin_login.dart';
import 'package:temple_app/screen/appfeedback.dart';
import 'package:temple_app/screen/chat_screen.dart';
import 'package:temple_app/screen/communications.dart';
import 'package:temple_app/screen/donation_list.dart';
import 'package:temple_app/screen/donations_page.dart';
import 'package:temple_app/screen/new_member.dart';
import 'package:temple_app/screen/priestservice_page.dart';
import 'package:temple_app/screen/services.dart';
import 'package:temple_app/screen/tample_calendar.dart';
import 'package:temple_app/screen/volunteer_page.dart';
import 'package:temple_app/screen/contact_us.dart';
import 'booking_puja.dart';

class TempleHomePage extends StatelessWidget {
  const TempleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temple Events & Services'),
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
      drawer: Drawer(
        //width: 220.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 120.00,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepOrange),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Temple Menu',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Image.asset(
                      'assets/icon/icon.png', // Replace with your actual image path
                      height: 40,
                      width: 40,
                    ),
                  ],
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.volunteer_activism),
              title: Text('Donation List'),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => DonationListScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => AboutUsPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.record_voice_over),
              title: Text('Communitations'),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => CommunicationsPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.handshake),
              title: Text('Services'),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => ServicesPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => ContactInfoPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add_alt_1),
              title: Text('New Member'),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => NewMemberPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Admin'),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => LoginPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat [New]'),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => ChatScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text('App Feedback'),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => AppFeedbackPage()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SectionTitle(title: '🕉️ Aarti Timings'),
            AartiTimings(),

            SectionTitle(title: '📅 Upcoming Events'),
            EventsCalendar(),

            SectionTitle(title: '🌸 Priest Services'),
            PriestServices(),

            SectionTitle(title: '💰 Donate to Temple'),
            DonationSection(),

            //SectionTitle(title: '📖 Book a Puja'),
            //BookPujaForm(),
            SectionTitle(title: '🙋 Volunteer Registration'),
            VolunteerForm(),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class AartiTimings extends StatefulWidget {
  const AartiTimings({super.key});

  @override
  State<AartiTimings> createState() => _AartiTimingsState();
}

class _AartiTimingsState extends State<AartiTimings> {
  final List<Map<String, String>> timings = [
    {'name': 'Morning Aarti', 'time': '6:00 AM'},
    {'name': 'Afternoon Aarti', 'time': '12:00 PM'},
    {'name': 'Evening Aarti', 'time': '6:30 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: timings
          .map(
            (aarti) => ListTile(
              leading: Icon(Icons.access_time),
              title: Text(aarti['name']!),
              subtitle: Text(aarti['time']!),
            ),
          )
          .toList(),
    );
  }
}

final List<Map<String, String>> events = [
  {'event': 'Vaikunta Ekadasi', 'date': 'Jan 9'},
  {'event': 'Shani Trayodasi', 'date': 'Jan 11'},
  {'event': 'Makara Sankranthi', 'date': 'Jan 14'},
  {'event': 'Vasanth Panchami', 'date': 'Feb 2'},
  {'event': 'Ratha Sapthami', 'date': 'Feb 4'},
  {'event': 'Thai Poosam', 'date': 'Feb 11'},
  {'event': 'Maha Shivaratri', 'date': 'Feb 25'},
  {'event': 'Holi Pournima', 'date': 'Mar 13'},
  {'event': 'Ugadi/GudiPadva', 'date': 'Mar 29'},
  {'event': 'Sri Ram Navami', 'date': 'Apr 6'},
  {'event': 'Phanguni Uttiram(Ayyappa Birthday)', 'date': 'Apr 10'},
  {'event': 'Hanuman Jayanthi(North)', 'date': 'Apr 12'},
  {'event': 'Tamil New Year', 'date': 'Apr 13'},
  {'event': 'Hanuman Jayanthi(South)', 'date': 'May 22'},
  {'event': 'Guru Pournima', 'date': 'Jun 10'},
  {'event': 'Adi Krittika', 'date': 'Jul 20'},
  {'event': 'Varalaxmi Vratham', 'date': 'Aug 1'},
  {'event': 'Rakhi/Sravana Purnima', 'date': 'Aug 8'},
  {'event': 'Sai Mandir Vaarshikotsavam', 'date': 'Aug 14'},
  {'event': 'Rakhi/Sravana Purnima', 'date': 'Aug 14'},
  {'event': 'Sri Krishna Janma Ashtami', 'date': 'Aug 15'},
  {'event': 'Ganesh Chaturthi', 'date': 'Aug 26'},
  {'event': 'Sharad Navarathri Begins', 'date': 'Sep 22'},
  {'event': 'Saraswathi Pooja', 'date': 'Sep 28'},
  {'event': 'Vijaya Dasami/Maha Samadhi Day', 'date': 'Oct 1'},
  {'event': 'Shani Triyodasi', 'date': 'Oct 18'},
  {'event': 'Diwali', 'date': 'Oct 20'},
  {'event': 'Karthika Pournami', 'date': 'Nov 4'},
  {'event': 'Skanda Shashti', 'date': 'Nov 6'},
  {'event': 'Subramanya Shasti', 'date': 'Nov 26'},
  {'event': 'Datta Jayanthi', 'date': 'Dec 4'},
  {'event': 'Hanuman Jayanthi (Tamil)', 'date': 'Dec 19'},
];

List<Map<String, String>> recentEvents(List<Map<String, String>> events) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  final monthMap = {
    'jan': 1,
    'feb': 2,
    'mar': 3,
    'apr': 4,
    'may': 5,
    'jun': 6,
    'jul': 7,
    'aug': 8,
    'sep': 9,
    'oct': 10,
    'nov': 11,
    'dec': 12,
  };

  final upcomingEvents = events
      .map((event) {
        final rawDate = event['date']!.toLowerCase().replaceAll(
          RegExp(r'[^a-z0-9]'),
          '',
        );
        final monthName = rawDate.replaceAll(RegExp(r'\d'), '');
        final dayStr = rawDate.replaceAll(RegExp(r'[a-z]'), '');
        final month = monthMap[monthName];
        final day = int.tryParse(dayStr) ?? 1;

        final eventDate = DateTime(today.year, month!, day);
        if (eventDate.isBefore(today)) {
          return null; // Skip past events
        }

        return {
          'event': event['event']!,
          'date': event['date']!,
          'dateTime': eventDate.toIso8601String(),
        };
      })
      .whereType<Map<String, String>>()
      .toList();

  upcomingEvents.sort(
    (a, b) => DateTime.parse(
      a['dateTime']!,
    ).compareTo(DateTime.parse(b['dateTime']!)),
  );

  return upcomingEvents.take(3).toList();
}

class EventsCalendar extends StatefulWidget {
  const EventsCalendar({super.key});

  @override
  State<EventsCalendar> createState() => _EventsCalendarState();
}

class _EventsCalendarState extends State<EventsCalendar> {
  List<Map<String, String>> upcomingevents = recentEvents(events);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (upcomingevents.isNotEmpty) ...[
          // Use the spread operator (...) to expand the list of event cards.
          ...upcomingevents.map(
            (event) => Card(
              child: ListTile(
                leading: Icon(Icons.event),
                title: Text(event['event']!),
                subtitle: Text(event['date']!),
                trailing: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    // Optional: Customize the border properties
                    side: const BorderSide(
                      color: Colors.deepOrange, // The color of the border
                      width: 2.0, // The width of the border
                    ),
                    // Optional: Customize the text color
                    foregroundColor: Colors.black,
                    backgroundColor: const Color.fromARGB(255, 245, 228, 181),
                    // Optional: Customize the shape (e.g., add rounded corners)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('RSVP'),
                  onPressed: () {},
                ),
              ),
            ),
          ),

          // Add the new button widget after the expanded list.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => TempleCalendarPage()));
              },
              label: Text('Event Calendar'),
              icon: Icon(Icons.calendar_month),
            ),
          ),
        ] else ...[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'No upcoming events...',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class DonationSection extends StatefulWidget {
  const DonationSection({super.key});

  @override
  State<DonationSection> createState() => _DonationSectionState();
}

class _DonationSectionState extends State<DonationSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: ElevatedButton.icon(
        icon: Icon(Icons.volunteer_activism),
        label: Text('Donate Now'),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => DonationPage()));
        },
      ),
    );
  }
}

class PriestServices extends StatefulWidget {
  const PriestServices({super.key});

  @override
  State<PriestServices> createState() => _PriestServicesState();
}

class _PriestServicesState extends State<PriestServices> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: ElevatedButton.icon(
        icon: Icon(Icons.brightness_high_outlined),
        label: Text('Service Request'),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => PriestServiceForm()));
        },
      ),
    );
  }
}

class BookPujaForm extends StatefulWidget {
  const BookPujaForm({super.key});

  @override
  State<BookPujaForm> createState() => _BookPujaFormState();
}

class _BookPujaFormState extends State<BookPujaForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /*TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Your Name'),
            ),
            TextFormField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Preferred Date'),
            ),*/
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Book Puja'),
              onPressed: () {
                // Submit booking logic
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => BookingPujaPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class VolunteerForm extends StatefulWidget {
  const VolunteerForm({super.key});

  @override
  State<VolunteerForm> createState() => _VolunteerFormState();
}

class _VolunteerFormState extends State<VolunteerForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 10),
            ElevatedButton.icon(
              label: Text('Volunteer Registration'),
              icon: Icon(Icons.handshake),
              onPressed: () {
                // Submit booking logic
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => VolunteerRegistrationPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
