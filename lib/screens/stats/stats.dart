import 'package:expense_tracker_app/screens/stats/chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Transaction",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
              ),
              //color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(12, 20, 12, 12),
                child: MyChart(),
              ),
              // BarChart(
              //   BarChartData(
              //
              //   )
              // ),
            )
          ],
        ),
      ),
    );
  }
}
