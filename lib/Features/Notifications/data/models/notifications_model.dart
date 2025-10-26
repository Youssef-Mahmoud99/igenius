import 'package:flutter/material.dart';

class NotificationsModel {

    final String title;
    final String message;
    final String subject;
    final String time;
    final Color color;

    NotificationsModel({
        required this.title,
        required this.message,
        required this.subject,
        required this.time,
        required this.color,
    });
}
