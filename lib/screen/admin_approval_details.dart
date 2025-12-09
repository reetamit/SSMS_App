import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temple_app/localization/words.dart';
import 'package:temple_app/model/database_service.dart';
import 'package:temple_app/model/vrequest.dart';

class AdminApprovalDetailScreen extends StatefulWidget {
  final VHourRequest request;

  const AdminApprovalDetailScreen({super.key, required this.request});

  @override
  State<AdminApprovalDetailScreen> createState() =>
      _AdminApprovalDetailScreenState();
}

class _AdminApprovalDetailScreenState extends State<AdminApprovalDetailScreen> {
  late TextEditingController _approvedByController;

  @override
  void initState() {
    super.initState();
    _approvedByController = TextEditingController(
      text: widget.request.approvedBy ?? '',
    );
  }

  @override
  void dispose() {
    _approvedByController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }

  void _onApprove() async {
    final approver = _approvedByController.text.trim();
    if (approver.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter 'Approved by' name")),
      );
      return;
    }
    // Update Firebase with approved = true and approvedBy = approver
    await DatabaseService().update(
      path: "${Words.vHourPath}/${widget.request.key}",
      data: {Words.vhourapproved: 'Approved', Words.vhourapprovedBy: approver},
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Approved by $approver")));
    Navigator.pop(context, true); // return true to dashboard
  }

  void _onReject() async {
    final approver = _approvedByController.text.trim();
    if (approver.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter 'Rejected by' name")),
      );
      return;
    }
    // Update Firebase with approved = false and approvedBy = approver
    await DatabaseService().update(
      path: "${Words.vHourPath}/${widget.request.key}",
      data: {Words.vhourapproved: 'Rejected', Words.vhourapprovedBy: approver},
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Rejected by $approver")));
    Navigator.pop(context, false); // return false to dashboard
  }

  @override
  Widget build(BuildContext context) {
    final req = widget.request;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Approval Details"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${req.name}", style: const TextStyle(fontSize: 16)),
            Text("Email: ${req.email}", style: const TextStyle(fontSize: 16)),
            Text("Phone: ${req.phone}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(
              "Description: ${req.description}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Date: ${_formatDate(req.dateTime)}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Start Time: ${_formatTime(req.startTime)}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "End Time: ${_formatTime(req.endTime)}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Total Hours: ${req.totalHours.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _approvedByController,
              readOnly:
                  (req.approved == 'Approved' || req.approved == 'Rejected'),
              decoration: const InputDecoration(
                labelText: "Approved by",
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: req.approved == 'Approved' ? null : _onApprove,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text("Approve"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: req.approved == 'Rejected' ? null : _onReject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text("Reject"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
