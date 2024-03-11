import 'package:expense_repositry/expense_repository.dart';
import 'package:expense_tracker_app/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:expense_tracker_app/screens/add_expense/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:expense_tracker_app/screens/add_expense/views/category_creation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();
  late Expense expense;

  bool mainButtonLoading = false;

  String categoryIconSelected = '';
  late Color categoryColor;

  @override
  void initState() {
    // TODO: implement initState
    //THE DATE FORMAT IS PART OF INTL PACKAGE
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    expense = Expense.empty;
    expense.expenseId=const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Navigator.pop(context);
        } else if (state is CreateExpenseLoading) {
          mainButtonLoading = true;
        }
      },
      child: GestureDetector(
        //USING THIS GESTURE DETECTOR & UNFOCUS IF I CLICK ANYWHERE ON THE SCREEN
        //MY textformfield WOULD BECOME UNFOCUSED
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: BlocBuilder<GetCategoryBloc, GetCategoryState>(
              builder: (context, state) {
            if (state is GetCategorySuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Add Expenses",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        //RUPEES FORMFIELD
                        child: TextFormField(
                          controller: expenseController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              //WE USE FILLED AND FILL TO GIVE BG COLOR TO OUR FORMFIELD
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              //HERE INSTEAD OF FAICON IF WE JUST USE ICON THE ICON WILL BE CENTERED IN THE FORMFIELD
                              prefixIcon: const Icon(
                                FontAwesomeIcons.rupeeSign,
                                size: 18,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      //CATEGORY TEXT FORM FIELD
                      TextFormField(
                        readOnly: true,
                        onTap: () {},
                        controller: categoryController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          //WE USE FILLED AND FILL TO GIVE BG COLOR TO OUR FORMFIELD
                          filled: true,
                          fillColor: expense.category == Category.empty
                              ? Colors.white
                              : Color(expense.category.color),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.vertical(
                              //HERE WE ADD RADIUS TO ONLY TOP AND NOT BOTTOM BECAUSE
                              //WE WANT IT TO LOOK SEAMLESS WITH THE LIST CONTAINER BELOW
                              top: Radius.circular(12),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          //HERE INSTEAD OF FAICON IF WE JUST USE ICON THE ICON WILL BE CENTERED IN THE FORMFIELD
                          prefixIcon: expense.category == Category.empty
                              ? const Icon(
                                  FontAwesomeIcons.list,
                                  size: 18,
                                  color: Colors.grey,
                                )
                              : SizedBox(
                                  width: 18, // Adjust the width as needed
                                  height: 18, // Adjust the height as needed
                                  child: Image.asset(
                                    'assets/images/${expense.category.icon}.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          suffixIcon: expense.category == Category.empty
                              ? IconButton(
                                  onPressed: () async {
                                    //CREATE NEW CATEGORY DIALOG BOX
                                    var newCategory =
                                        await getCategoryCreation(context);
                                    print(newCategory);

                                    setState(() {
                                      state.categories.insert(0, newCategory);
                                    });
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.plus,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                )
                              : const Icon(
                                  FontAwesomeIcons.check,
                                ),
                          //THIS CREATES A ONCLICK TOP MOVING TEXT
                          label: const Text("Category"),
                        ),
                      ),

                      //CONTAINER FOR DISPLAYING A LIST OF AVAILABLE CATEGORIES
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: state.categories.length,
                            itemBuilder: (context, int i) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      expense.category = state.categories[i];
                                      categoryController.text =
                                          expense.category.name;
                                    });
                                  },
                                  leading: Image.asset(
                                    'assets/images/${state.categories[i].icon}.png',
                                    scale: 1,
                                  ),
                                  title: Text(
                                    state.categories[i].name,
                                  ),
                                  tileColor: Color(state.categories[i].color),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      //DATE TEXT FORM FIELD
                      TextFormField(
                        controller: dateController,
                        textAlignVertical: TextAlignVertical.center,
                        //FOR MAKING WRITING DISABLED
                        readOnly: true,
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                            //BY ADDING THE INITIALDATE WE MAKE THE DATE APPEAR ON TOP ALSO IN CALENDAR
                            context: context,
                            //WE ADD SELECTDATE HERE BECAUSE EVEN IF WE CHANGE THE DATE WHEN WE AGAIN
                            //CLICK ON CALENDAR IT WAS NOT SHOWING THE SELECTEDDATE AS SELECTED SO WE SET A VARIABLE
                            //initialDate: DateTime.now(),
                            initialDate: selectDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );

                          if (newDate != null) {
                            //DATE FORMAT IS FROM INTL PACKAGE
                            setState(() {
                              selectDate = newDate;
                              dateController.text =
                                  DateFormat('dd/MM/yyyy').format(newDate);
                              expense.date = newDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          //WE USE FILLED AND FILL TO GIVE BG COLOR TO OUR FORMFIELD
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                              borderSide: BorderSide.none),
                          //HERE INSTEAD OF FAICON IF WE JUST USE ICON THE ICON WILL BE CENTERED IN THE FORMFIELD
                          prefixIcon: const Icon(
                            FontAwesomeIcons.clock,
                            size: 18,
                            color: Colors.grey,
                          ),
                          //THIS CREATES A ONCLICK TOP MOVING TEXT
                          label: const Text("Date"),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: kToolbarHeight,
                        child: mainButtonLoading
                            ? const Center(child: CircularProgressIndicator())
                            : TextButton(
                                onPressed: () {
                                  setState(() {
                                    expense.amount =
                                        int.parse(expenseController.text);
                                  });

                                  context
                                      .read<CreateExpenseBloc>()
                                      .add(CreateExpense(expense));
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32),
                                    )),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }
}
