import 'dart:math';

import 'package:expense_tracker_app/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
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
                            color: Colors.yellow.shade700
                          ),
                        ),
                        Icon(
                          CupertinoIcons.person_fill,
                          color: Colors.yellow.shade900,
                        ),
                      ],
                    ),
                    const SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "welcome",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.outline
                          ),
                        ),
                        Text(
                            "vineet singh",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
                IconButton(
                    onPressed: (){},
                    icon: const Icon(CupertinoIcons.settings)
                ),
              ],
            ),
            const SizedBox(height: 20.0,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width/2,
              //ADDING GRADIENT TO THE CONTAINER
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.tertiary
                    ],
                    transform: const GradientRotation(pi/4),
                  ),
                borderRadius: BorderRadius.circular(25),
                //ADDING SHADOW TO BOX
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.grey.shade300,
                    offset: const Offset(5,5)
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8,),
                  const Text(
                    "Total Balance",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(height: 12,),
                  const Text(
                    "4800",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
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
                                shape: BoxShape.circle
                              ),
                              child: const Center(
                                child: Icon(
                                  CupertinoIcons.arrow_down,
                                  size: 12,
                                  color: Colors.greenAccent,
                                )
                              ),
                            ),
                            const SizedBox(width: 8,),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Income",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Text(
                                    "5500",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600
                                  ),
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
                                  shape: BoxShape.circle
                              ),
                              child: const Center(
                                  child: Icon(
                                    CupertinoIcons.arrow_down,
                                    size: 12,
                                    color: Colors.red,
                                  )
                              ),
                            ),
                            const SizedBox(width: 8,),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Expenses",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Text(
                                  "5500",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600
                                  ),
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
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transaction",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold
                  ),
                ),
                GestureDetector(
                  onTap: (){

                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.outline,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: transactionData.length,
                itemBuilder: (context, int i){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                      ),
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
                                        color: transactionData[i]['color'],
                                        shape: BoxShape.circle
                                      ),
                                    ),
                                    transactionData[i]['icon']
                                    // Icon(
                                    //   Icons.food_bank,
                                    //   color: Colors.white,
                                    // )
                                  ],
                                ),
                                const SizedBox(width: 12,),
                                Text(
                                  transactionData[i]['name'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).colorScheme.onBackground,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  transactionData[i]['totalAmount'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onBackground,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Text(
                                  transactionData[i]['date'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).colorScheme.outline,
                                      fontWeight: FontWeight.w400
                                  ),
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
