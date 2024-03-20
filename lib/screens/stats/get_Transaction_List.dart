import 'package:expense_repositry/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

ListView getTransactionList(BuildContext context, List<Expense> exp) {
  return ListView.builder(
    itemCount: exp.length,
    itemBuilder: (context, int i) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  //WE STORED COLOR AS INT IN FIREBASE HENCE WE DO LIKE THIS
                                  color: Color(exp[i].category.color),
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 18, // Adjust the width as needed
                              height: 18, // Adjust the height as needed
                              child: Image.asset(
                                'assets/images/${exp[i].category.icon}.png',
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
                          exp[i].category.name,
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          exp[i].amount.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy').format(exp[i].date),
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.outline,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    exp[i].description,
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
