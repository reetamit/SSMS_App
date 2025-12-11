import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:temple_app/localization/words.dart';
import 'package:temple_app/model/database_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController categoryController = TextEditingController();
  final List<String> categories = []; // store added categories

  int? selectedHour;
  int? selectedMinute;

  final List<int> hours = List.generate(100, (index) => index); // 0–99
  final List<int> minutes = [0, 15, 30, 45]; // quarter intervals

  Future<void> _onAddCategory(String category) async {
    // Read existing categories
    final snapshot = await DatabaseService().read(
      path: Words.adminsettingsPath,
    );

    List<dynamic> categories = [];
    if (snapshot != null) {
      final data = snapshot.value as Map<dynamic, dynamic>?;

      if (data != null && data[Words.adminsettingsVcategories] is List) {
        categories = List.from(data[Words.adminsettingsVcategories] as List);
      }
    }

    // Check if category already exists
    if (categories.contains(category)) {
      // Show popup if duplicate
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Duplicate Category"),
          content: const Text("Category already exists"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    // Append new category
    categories.add(category);

    // Update Firebase
    await DatabaseService().update(
      path: Words.adminsettingsPath,
      data: {Words.adminsettingsVcategories: categories},
    );

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("New Category '$category' is added")),
    );
  }

  Future<void> _onAddHourLimit(double hourlimit) async {
    // Update Firebase
    await DatabaseService().update(
      path: Words.adminsettingsPath,
      data: {Words.adminsettingsVhourlimit: hourlimit},
    );

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("New Hour limit '$hourlimit' is updated")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Volunteer Category
            const Text(
              "Add Volunteer Category",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                hintText: "Enter category name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),

            // ➕ Add button
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final category = categoryController.text.trim();
                  if (category.isNotEmpty) {
                    _onAddCategory(category);
                    categoryController.clear();
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text("Add"),
              ),
            ),

            const SizedBox(height: 16),
            const Divider(thickness: 1), // separator line

            const SizedBox(height: 16),

            // 2. Volunteer Max Limit
            const Text(
              "Set Volunteer Max Hour Limit",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: "Hours",
                      border: OutlineInputBorder(),
                    ),
                    initialValue: selectedHour,
                    items: hours.map((h) {
                      return DropdownMenuItem<int>(value: h, child: Text("$h"));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedHour = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: "Minutes",
                      border: OutlineInputBorder(),
                    ),
                    initialValue: selectedMinute,
                    items: minutes.map((m) {
                      return DropdownMenuItem<int>(value: m, child: Text("$m"));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMinute = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Save button
            ElevatedButton(
              onPressed: () async {
                final hour = selectedHour ?? 0;
                final minute = selectedMinute ?? 0;
                final double totalHours = hour + (minute / 60.0);
                _onAddHourLimit(totalHours as double);
              },
              child: const Text("Update Volunteer Hour Limit"),
            ),
            const SizedBox(height: 24),
            const Divider(thickness: 1), // separator line
          ],
        ),
      ),
    );
  }
}
