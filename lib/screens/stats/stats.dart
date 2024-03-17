import 'package:expense_repositry/expense_repository.dart';
import 'package:expense_tracker_app/screens/stats/chart.dart';
import 'package:expense_tracker_app/screens/stats/get_Transaction_List.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatsScreen extends StatefulWidget {
  final List<Expense> expenses;

  StatsScreen({required this.expenses, super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  late List<Expense> Income;
  late List<Expense> exp;
  bool showIncomeList = false;

  @override
  void initState() {
    exp = [];
    Income = [];
    for (Expense e in widget.expenses) {
      if (e.category.name == "Added Money") {
        Income.add(e);
      } else {
        exp.add(e);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   "All Transaction",
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold
            //   ),
            // ),
            DropdownMenu(dropdownMenuEntries: [
              DropdownMenuEntry(value: "All Expenses", label: "All Expenses"),
              DropdownMenuEntry(value: "All Income", label: "All Income"),
            ],
              onSelected: (selectedValue) {
                setState(() {
                  showIncomeList = selectedValue == "All Income";
                });
              },
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                outlineBorder: BorderSide.none,
                disabledBorder: InputBorder.none,
              ),

              initialSelection: "All Expenses",
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: showIncomeList
                  ? getTransactionList(context, Income)
                  : getTransactionList(context, exp),
            )
          ],
        ),
      ),
    );
  }
}
