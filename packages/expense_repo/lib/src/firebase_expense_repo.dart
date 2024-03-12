import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repositry/expense_repository.dart';

class FirebaseExpenseRepo implements ExpenseRepository{

  final categoryCollection= FirebaseFirestore.instance.collection('categories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');

  @override
  Future<void> createCategory(Category category) async{

    //HERE .DOC METHOD IS USED TO CREATE A NEW ID IF IT DOESNOT EXIST
    //When you use the .doc() method without specifying an ID, Firestore automatically generates a new unique ID for the document.

    //.SET METHOD IS USED TO SET THE DATA FOR THAT PARTICULAR ID
    //HERE WE CREATE A DOCUMENT WITH ID AS CATEGORY ID AND THEN SET THE DATA
    try{
      categoryCollection.doc(category.categoryId).set(category.toEntity().toDocument());

    }catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategory() async{

    //HERE FROM CATEGORYCOLLECTION WE RETRIEVE ALL THE DOCUMENTS
    //WE GET A MAP VALUES SO WE CONVERT THEM TO CATEGORY LIST AND RETURN IT
    try{
      return await categoryCollection
          .get()
          .then(
              (value) => value.docs.map((e) =>
                  Category.fromEntity(CategoryEntity.fromDocument(e.data()))).toList());

    }catch(e){
      log(e.toString());
      rethrow;
    }
  }


  @override
  Future<void> createExpense(Expense expense) async{

    //HERE .DOC METHOD IS USED TO CREATE A NEW ID IF IT DOESNOT EXIST
    //When you use the .doc() method without specifying an ID, Firestore automatically generates a new unique ID for the document.

    //.SET METHOD IS USED TO SET THE DATA FOR THAT PARTICULAR ID
    //HERE WE CREATE A DOCUMENT WITH ID AS CATEGORY ID AND THEN SET THE DATA
    try{
      expenseCollection.doc(expense.expenseId).set(expense.toEntity().toDocument());

    }catch(e){
      log(e.toString());
      rethrow;
    }
  }


  @override
  Future<List<Expense>> getExpense() async {
    //HERE FROM EXPENSECOLLECTION WE RETRIEVE ALL THE DOCUMENTS
    //WE GET A MAP VALUES SO WE CONVERT THEM TO CATEGORY LIST AND RETURN IT
    try{
      return await expenseCollection
          .get()
          .then(
              (value) => value.docs.map((e) =>
              Expense.fromEntity(ExpenseEntity.fromDocument(e.data()))).toList());

    }catch(e){
      log(e.toString());
      rethrow;
    }
  }

}