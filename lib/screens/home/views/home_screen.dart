import 'dart:math';

import 'package:expense_repositry/expense_repository.dart';
import 'package:expense_tracker_app/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:expense_tracker_app/screens/home/views/main_screen.dart';
import 'package:expense_tracker_app/screens/stats/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../add_expense/views/add_expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int index=0;
  late Color selectedItems=Colors.blue;
  Color unselectedItems = Colors.grey;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   selectedItems=Theme.of(context).colorScheme.primary;
  //   super.initState();
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30)
        ),
        child: BottomNavigationBar(
          onTap: (value){
            setState(() {
              index=value;
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                  CupertinoIcons.home,
                  color: index==0?selectedItems : unselectedItems
              ),
              label: "Home"
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  CupertinoIcons.graph_square,
                  color: index==1?selectedItems : unselectedItems
              ),
              label: "Stats"
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              create: (context) => CreateCategoryBloc(FirebaseExpenseRepo()),
              child: const AddExpense(),
            ),
          ));
        },
        
        //GRADIENT FLOATING ACTION BUTTON
        shape: const CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary
              ],
              transform: const GradientRotation(pi/4),
            )
          ),
          child: const Icon(
              CupertinoIcons.add
          ),
        ),
      ),
      body: index==0 ? const MainScreen() : const StatsScreen(),
    );
  }
}
