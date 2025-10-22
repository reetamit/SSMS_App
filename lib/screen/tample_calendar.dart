import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TempleCalendarPage extends StatefulWidget {
  @override
  _TempleCalendarPageState createState() => _TempleCalendarPageState();
}

class _TempleCalendarPageState extends State<TempleCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temple Calendar'),
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
      body: Column(
        children: [
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
          Expanded(
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
        ],
      ),
    );
  }
}
