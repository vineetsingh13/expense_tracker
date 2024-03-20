import 'package:shared_preferences/shared_preferences.dart';

double totalMoney = 0.0;

Future<void> loadTotalMoney() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  totalMoney = prefs.getDouble('totalMoney') ?? 0.0;
}

Future<void> saveTotalMoney(double amount) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('totalMoney', amount);
}