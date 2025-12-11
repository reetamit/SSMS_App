import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:temple_app/localization/words.dart';
import 'package:temple_app/model/database_service.dart';
import 'package:temple_app/model/utility.dart';
import 'package:temple_app/model/vrequest.dart';
import 'package:temple_app/screen/admin_approval_details.dart';
import 'package:temple_app/screen/adminsettingspage.dart';
import 'package:temple_app/screen/event_dialog.dart';

class ApprovalAdminPage extends StatefulWidget {
  const ApprovalAdminPage({super.key});

  @override
  _ApprovalAdminPageState createState() => _ApprovalAdminPageState();
}

class _ApprovalAdminPageState extends State<ApprovalAdminPage> {
  List<VHourRequest> requests = [];
  List<VHourRequest> filteredRequests = [];
  String selectedFilter = 'All';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchRequests();
  }

  void navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    // approvals page content
    const SizedBox(), // placeholder, we’ll build below
    const SettingsScreen(),
  ];

  Future<void> _fetchRequests() async {
    DataSnapshot? snapshot = await DatabaseService().read(
      path: Words.vHourPath,
    );

    if (snapshot != null) {
      final Map<dynamic, dynamic> values =
          snapshot.value as Map<dynamic, dynamic>;

      requests = values.entries.map((entry) {
        final data = entry.value as Map<dynamic, dynamic>;
        return VHourRequest(
          key: entry.key,
          name: data[Words.vhourname] ?? '',
          email: data[Words.vhouremail] ?? '',
          phone: data[Words.vhourphone] ?? '',
          description: data[Words.vhourdesc] ?? '',
          dateTime: DateTime.parse(data[Words.vhourdate] ?? ''),
          startTime: TimeOfDay(
            hour: int.parse(
              (data[Words.vhourstarttime] ?? '00:00').split(':')[0],
            ),
            minute: int.parse(
              (data[Words.vhourstarttime] ?? '00:00').split(':')[1],
            ),
          ),
          endTime: TimeOfDay(
            hour: int.parse(
              (data[Words.vhourendtime] ?? '00:00').split(':')[0],
            ),
            minute: int.parse(
              (data[Words.vhourendtime] ?? '00:00').split(':')[1],
            ),
          ),
          totalHours: (data[Words.vhourtotalhours] != null)
              ? (data[Words.vhourtotalhours] as num).toDouble()
              : 0.0,
          approved: data[Words.vhourapproved] ?? 'Pending',
          approvedBy: data[Words.vhourapprovedBy] ?? '',
        );
      }).toList();
    } else {
      requests = [];
    }
    _applyFilter();
    setState(() {});
  }

  void _applyFilter() {
    if (selectedFilter == 'All') {
      filteredRequests = List.from(requests);
    } else {
      filteredRequests = requests
          .where((req) => req.approved == selectedFilter)
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // approvals page UI
    final approvalsPage = Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            initialValue: selectedFilter, // ✅ use initialValue
            items: ['All', 'Approved', 'Pending', 'Rejected']
                .map(
                  (filter) =>
                      DropdownMenuItem(value: filter, child: Text(filter)),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedFilter = value;
                  _applyFilter();
                });
              }
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
            itemCount: filteredRequests.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final req = filteredRequests[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) =>
                              AdminApprovalDetailScreen(request: req),
                        ),
                      )
                      .then((value) => _fetchRequests());
                },
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.volunteer_activism,
                        color: Colors.grey[700],
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              req.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              req.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            if (req.approved == 'Approved')
                              Text(
                                'Approved by: ${req.approvedBy}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              )
                            else if (req.approved == 'Rejected')
                              Text(
                                'Rejected by: ${req.approvedBy}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Utility.formatDateTime(req.dateTime),
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Status: ${req.approved}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
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
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.deepOrange,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Image.asset('assets/icon/icon.png', height: 45, width: 45),
          ),
        ],
      ),
      body: _selectedIndex == 0 ? approvalsPage : const SettingsScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchRequests,
        child: const Icon(Icons.refresh),
      ),
      bottomNavigationBar: Stack(
        children: <Widget>[
          Container(
            height: 100,
            decoration: const BoxDecoration(color: Colors.orange),
          ),
          BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            onTap: navigateTo,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.approval_rounded),
                label: 'Approvals',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
