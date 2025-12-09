import 'package:flutter/material.dart';

class VHourRequest {
  final String key;
  final String name;
  final String email;
  final String phone;
  final String description;
  final DateTime dateTime;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final double totalHours;
  final String approved;
  final String approvedBy;

  VHourRequest({
    required this.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.description,
    required this.dateTime,
    required this.startTime,
    required this.endTime,
    required this.totalHours,
    required this.approved,
    this.approvedBy = '',
  });
}
