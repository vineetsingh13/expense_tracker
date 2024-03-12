import 'package:expense_repositry/expense_repository.dart';
import 'package:expense_tracker_app/screens/home/blocs/get_expense_bloc/get_expense_bloc.dart';
import 'package:expense_tracker_app/screens/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
          colorScheme: ColorScheme.light(
              background: Colors.grey.shade100,
              onBackground: Colors.black,
              primary: Color(0xFF00B2E7),
              secondary: Color(0xFFE064F7),
              tertiary: Color(0xFFFF8D6C),
              outline: Colors.grey)),
      home: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
                GetExpenseBloc(FirebaseExpenseRepo())..add(GetExpenses())),
      ], child: HomeScreen()),
    );
  }
}
