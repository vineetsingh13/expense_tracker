import 'dart:math';

import 'package:expense_repositry/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';

class MainScreen extends StatefulWidget {
  final List<Expense> expenses;

  MainScreen({required this.expenses, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double totalAmount = 0;
  late Expense expense;

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    print("didUpdateWidget");

    _subtractExpense(widget.expenses);
    super.didUpdateWidget(oldWidget);
  }


  @override
  void initState() {
    expense=Expense.empty;
    super.initState();
    _loadTotalAmount();
  }


  _subtractExpense(List<Expense> expenses) {
    int expAmt = 0;

    if(expenses[0].category.name!="Added Money"){
      expAmt = expenses[0].amount;
    }
    setState(() {
      totalAmount = totalAmount - expAmt;
      _saveTotalAmount(totalAmount);
    });
  }

  _loadTotalAmount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      totalAmount = pref.getDouble('totalAmount') ?? 0;
    });
  }

  _saveTotalAmount(double amt) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setDouble('totalAmount', amt);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow.shade700),
                        ),
                        Icon(
                          CupertinoIcons.person_fill,
                          color: Colors.yellow.shade900,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "welcome",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .outline),
                        ),
                        Text(
                          "vineet singh",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color:
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .onBackground),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.settings)),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .width / 2,
              //ADDING GRADIENT TO THE CONTAINER
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme
                          .of(context)
                          .colorScheme
                          .primary,
                      Theme
                          .of(context)
                          .colorScheme
                          .secondary,
                      Theme
                          .of(context)
                          .colorScheme
                          .tertiary
                    ],
                    transform: const GradientRotation(pi / 4),
                  ),
                  borderRadius: BorderRadius.circular(25),
                  //ADDING SHADOW TO BOX
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey.shade300,
                        offset: const Offset(5, 5))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Total Balance",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              totalAmount.toString(),
                              style: const TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 40, // Adjust the width as needed
                          height: 40, // Adjust the height as needed
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white38,
                          ),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx3) {
                                  TextEditingController addAmountController = TextEditingController();

                                  return AlertDialog(
                                    title: const Text("Add Amount"),
                                    content: SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[

                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: addAmountController,
                                            textAlignVertical: TextAlignVertical
                                                .center,
                                            decoration: InputDecoration(
                                              //WE USE FILLED AND FILL TO GIVE BG COLOR TO OUR FORMFIELD
                                              filled: true,
                                              fillColor: Colors.white,
                                              //is dense takes less vertical space
                                              isDense: true,
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(12),
                                                  borderSide: BorderSide.none),
                                              hintText: "Add Amount",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                            child: TextButton(
                                              onPressed: () {

                                                Category category=Category(
                                                    categoryId: Uuid().v1(),
                                                    name: "Added Money",
                                                    totalExpenses: 0,
                                                    icon: "dollar",
                                                    color: const Color(0xFF00FF00).value
                                                );

                                                setState(() {
                                                  totalAmount += double.parse(
                                                      addAmountController.text);
                                                  _saveTotalAmount(totalAmount);

                                                });
                                                Expense newExpense = Expense(
                                                  expenseId: Uuid().v1(),
                                                  category: category,
                                                  date: DateTime.now(),
                                                  amount: int.parse(addAmountController.text),
                                                );

                                                context
                                                    .read<CreateExpenseBloc>()
                                                    .add(CreateExpense(newExpense));
                                                widget.expenses.insert(0, newExpense);
                                                Navigator.pop(ctx3);
                                              },
                                              style: TextButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(12),
                                                  )),
                                              child: const Text(
                                                "Save",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) {
                                _saveTotalAmount(totalAmount);
                              });
                            },
                            icon: const Icon(Icons.add),
                            color:
                            Colors.white, // Change the icon color if needed
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                  color: Colors.white30,
                                  shape: BoxShape.circle),
                              child: const Center(
                                  child: Icon(
                                    CupertinoIcons.arrow_up,
                                    size: 12,
                                    color: Colors.greenAccent,
                                  )),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Income",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "5500",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                  color: Colors.white30,
                                  shape: BoxShape.circle),
                              child: const Center(
                                  child: Icon(
                                    CupertinoIcons.arrow_down,
                                    size: 12,
                                    color: Colors.red,
                                  )),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Expenses",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "5500",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Transaction",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme
                          .of(context)
                          .colorScheme
                          .onBackground,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .outline,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, int i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        //WE STORED COLOR AS INT IN FIREBASE HENCE WE DO LIKE THIS
                                          color:
                                          Color(widget.expenses[i].category
                                              .color),
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(
                                      width: 18, // Adjust the width as needed
                                      height: 18, // Adjust the height as needed
                                      child: Image.asset(
                                        'assets/images/${widget.expenses[i]
                                            .category.icon}.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // Icon(
                                    //   Icons.food_bank,
                                    //   color: Colors.white,
                                    // )
                                  ],
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  widget.expenses[i].category.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.expenses[i].amount.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(widget.expenses[i].date),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                      Theme
                                          .of(context)
                                          .colorScheme
                                          .outline,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
