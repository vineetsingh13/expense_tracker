
//all of the method we are going to use to create our backend will be here
//we will not initialize the methods here we will initialize it in firebase_expense_repo
//hence we declare this abstract

import 'package:expense_repositry/expense_repository.dart';

abstract class ExpenseRepository{

  //method for creating a category
  Future<void> createCategory(Category category);

  Future<List<Category>> getCategory();

  Future<void> createExpense(Expense expense);
}