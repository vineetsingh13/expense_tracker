import 'package:bloc/bloc.dart';
import 'package:expense_repositry/expense_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_expense_event.dart';
part 'get_expense_state.dart';

class GetExpenseBloc extends Bloc<GetExpenseEvent,GetExpenseState>{

  final ExpenseRepository expenseRepository;

  GetExpenseBloc(this.expenseRepository): super(GetExpenseInitial()) {
    on<GetExpenses> ((event,emit) async{

      emit(GetExpenseLoading());
      try{

        List<Expense> expenses=await expenseRepository.getExpense();

        emit(GetExpenseSuccess(expenses));
      }catch(e){

        emit(GetCategoryFailure());
      }
    });
  }
}