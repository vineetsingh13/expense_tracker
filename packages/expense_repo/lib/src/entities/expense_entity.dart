import 'package:cloud_firestore/cloud_firestore.dart';

import '../../expense_repository.dart';

class ExpenseEntity {

  String expenseId;
  Category category;
  DateTime date;
  int amount;

  ExpenseEntity({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.amount,
  });

  //WE DO THIS BECAUSE IN FIREBASE WE HAVE TO STORE AS KEY VALUE PAIR
  //FIREBASE DOESNOT UNDERSTAND OBJECT
  //SO WE CONVERT OUR DATA INTO MAP TO STORE INTO FIREBASE

  Map<String, Object?> toDocument(){

    return {
      'expenseId': expenseId,
      //FIREBASE DONT ACCEPT OBJECT SO WE CONVERT THIS TO DOCUMENT
      'category': category.toEntity().toDocument(),
      'date': date,
      'amount': amount,
    };
  }


  //SO FIREBASE WOULD RETURN A KEY VALUE PAIR SO WE STORE THE DATA IN CATEGORYENTITY
  //THEN WE CONVERT IT TO CATEGORY OBJECT TO BE USED IN APP
  static ExpenseEntity fromDocument(Map<String, dynamic> doc){
    return ExpenseEntity(

      expenseId: doc['expenseId'],
      category: Category.fromEntity(CategoryEntity.fromDocument(doc['category'])),
      date: (doc['date'] as Timestamp).toDate(),
      amount: doc['amount'],
    );
  }
}