import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:temple_app/screen/event_dialog.dart';

class DashBoardAdminPage extends StatefulWidget {
  const DashBoardAdminPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashBoardAdminPageState createState() => _DashBoardAdminPageState();
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

class _DashBoardAdminPageState extends State<DashBoardAdminPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool didAgree = false;
  // Hardcoded donation amount for the current month.
  final double totalDonations = 12500.00;
  // Hardcoded month for display purposes.
  final String month = 'October 2025';

  final Map<DateTime, List<String>> _events = {
    DateTime.utc(2024, 12, 19): ['Hanuman Jayanthi (Tamil)'],
    DateTime.utc(2025, 1, 9): ['Vaikunta Ekadasi'],
    DateTime.utc(2025, 1, 11): ['Shani Trayodasi'],
    DateTime.utc(2025, 1, 14): ['Makara Sankranthi'],
    DateTime.utc(2025, 2, 2): ['Vasanth Panchami'],
    DateTime.utc(2025, 2, 4): ['Ratha Sapthami'],
    DateTime.utc(2025, 2, 11): ['Thai Poosam'],
    DateTime.utc(2025, 2, 25): ['Maha Shivaratri'],
    DateTime.utc(2025, 3, 13): ['Holi Pournima'],
    DateTime.utc(2025, 3, 29): ['Ugadi/GudiPadva'],
    DateTime.utc(2025, 4, 6): ['Sri Ram Navami'],
    DateTime.utc(2025, 4, 10): ['Phanguni Uttiram(Ayyappa Birthday)'],
    DateTime.utc(2025, 4, 12): ['Hanuman Jayanthi(North)'],
    DateTime.utc(2025, 4, 13): ['Tamil New Year'],
    DateTime.utc(2025, 5, 22): ['Hanuman Jayanthi(South)'],
    DateTime.utc(2025, 6, 10): ['Guru Pournima'],
    DateTime.utc(2025, 7, 20): ['Adi Krittika'],
    DateTime.utc(2025, 8, 1): ['Varalaxmi Vratham'],
    DateTime.utc(2025, 8, 8): ['Rakhi/Sravana Purnima'],
    DateTime.utc(2025, 8, 14): [
      'Sai Mandir Vaarshikotsavam',
      'Rakhi/Sravana Purnima',
    ],
    DateTime.utc(2025, 8, 15): ['Sri Krishna Janma Ashtami'],
    DateTime.utc(2025, 8, 26): ['Ganesh Chaturthi'],
    DateTime.utc(2025, 9, 22): ['Sharad Navarathri Begins'],
    DateTime.utc(2025, 9, 28): ['Saraswathi Pooja'],
    DateTime.utc(2025, 10, 1): ['Vijaya Dasami/Maha Samadhi Day'],
    DateTime.utc(2025, 10, 18): ['Shani Triyodasi'],
    DateTime.utc(2025, 10, 20): ['Diwali'],
    DateTime.utc(2025, 11, 4): ['Karthika Pournami'],
    DateTime.utc(2025, 11, 6): ['Skanda Shashti'],
    DateTime.utc(2025, 11, 26): ['Subramanya Shasti'],
    DateTime.utc(2025, 12, 4): ['Datta Jayanthi'],
  };

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_US', // or your desired locale
      symbol: '\$', // or your desired currency symbol
    );
    return formatter.format(amount);
  }

  void _showEventDialog() async {
    final didAgree = await showDialog<bool>(
      context: context,
      //barrierDismissible: false, // Prevents closing by tapping outside
      builder: (BuildContext context) {
        return EventDialog();
      },
    );

    if (didAgree != null) {
      setState(() {});
      // Handle the user's choice, e.g., save it to shared preferences
      // or navigate to a new screen.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
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

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: '📅 Manage Events'),
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _getEventsForDay(selectedDay);
                _showEventDialog();
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.deepOrange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // ✅ Replace Expanded with SizedBox
            SizedBox(
              height: 80,
              child: ListView(
                children: _getEventsForDay(_selectedDay ?? _focusedDay)
                    .map(
                      (event) => ListTile(
                        leading: Icon(Icons.event),
                        title: Text(event),
                      ),
                    )
                    .toList(),
              ),
            ),

            SectionTitle(title: '📅 Booking Management'),

            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  final data = [
                    {
                      'id': '#2342',
                      'user': 'Reetam Biswas',
                      'location': 'Temple',
                      'date': 'Mar 5, 2025',
                      'poojaname': 'Vahana or Car Pooja',
                    },
                    {
                      'id': '#2341',
                      'user': 'Sylvia Biswas',
                      'location': 'Home',
                      'date': 'Mar 4, 2025',
                      'poojaname': 'Archana',
                    },
                    {
                      'id': '#2340',
                      'user': 'Stotra Biswas',
                      'location': 'Temple',
                      'date': 'Mar 1, 2025',
                      'poojaname': 'Archana',
                    },
                  ][index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      //leading: CircleAvatar(
                      //  child: Text(data['id']!.substring(1)),
                      //),
                      title: Text(data['user']!),
                      subtitle: Text(
                        '${data['location']} • ${data['date']}\n${data['poojaname']}',
                      ),
                    ),
                  );
                },
              ),
            ),

            SectionTitle(title: '📅 Donation Management'),

            Card(
              elevation: 4.0, // Adds a shadow for a 3D effect
              margin: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Donations ($month)',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      _formatCurrency(totalDonations),
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
