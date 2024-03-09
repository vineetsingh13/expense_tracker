import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> transactionData=[
  {
    'icon': const FaIcon(FontAwesomeIcons.burger,color: Colors.white),
    'color': Colors.yellow.shade700,
    'name': 'Food' ,
    'totalAmount': '- 200',
    'date': 'Today',
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.shop,color: Colors.white),
    'color': Colors.purple,
    'name': 'Shopping' ,
    'totalAmount': '- 125',
    'date': 'Today',
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.heartCircleCheck,color: Colors.white),
    'color': Colors.green,
    'name': 'Health' ,
    'totalAmount': '- 80',
    'date': 'Today',
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.plane,color: Colors.white),
    'color': Colors.blue,
    'name': 'Travel' ,
    'totalAmount': '- 130',
    'date': 'Today',
  }
];