

import 'package:expense_repositry/expense_repository.dart';
import 'package:expense_tracker_app/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';


Future getCategoryCreation(BuildContext context) {


  List<String> categoryIcons = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel'
  ];

  return showDialog(
    context: context,
    builder: (ctx) {
      bool isExpanded = false;

      //WE DECLARE THE VARIABLES HERE BECAUSE WE WANT THEM UNTIL THE CATEGORY DIALOG IS ACTIVE
      //AFTER THAT WE DONT WANT THEM TO SAVE THE VALUE SO WE INITIALIZE THEM HERE
      String categoryIconSelected = '';
      Color categoryColor = Colors.white;

      TextEditingController categoryNameController = TextEditingController();
      TextEditingController categoryIconController = TextEditingController();
      TextEditingController categoryColorController = TextEditingController();

      bool isLoading = false;
      Category category = Category.empty;

      //HERE IF WE NORMALLY RETURN ALERTDIALOG IT WILL NOT WORK BECAUSE THE STATE IS NOT UPDATE OF THE UI
      //WHEN THE CONTEXT CHANGES SO TO DO THIS WE ENCLOSE IT IN A STATEFUL BUILDER
      return BlocProvider.value(
        value: context.read<CreateCategoryBloc>(),
        child: StatefulBuilder(
          builder: (ctx, setState) {
            return BlocListener<CreateCategoryBloc, CreateCategoryState>(
              listener: (context, state) {
                if (state is CreateCategorySuccess) {
                  Navigator.pop(ctx,category);
                } else if (state is CreateCategoryLoading) {
                  //TO SHOW A CIRCULAR LOADER IF ISLOADING IS TRUE
                  setState(() {
                    isLoading = true;
                  });
                }
              },
              child: AlertDialog(
                title: const Text("Create a category"),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //NAME INPUT
                      TextFormField(
                        controller: categoryNameController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          //WE USE FILLED AND FILL TO GIVE BG COLOR TO OUR FORMFIELD
                          filled: true,
                          fillColor: Colors.white,
                          //is dense takes less vertical space
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                          hintText: "Name",
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      //CATEGORY ICON INPUT
                      TextFormField(
                        controller: categoryIconController,
                        readOnly: true,
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          //WE USE FILLED AND FILL TO GIVE BG COLOR TO OUR FORMFIELD
                          filled: true,
                          isDense: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              borderSide: BorderSide.none),
                          hintText: "Icon",
                          suffixIcon: Icon(
                            CupertinoIcons.chevron_down,
                            size: 12,
                          ),
                        ),
                      ),

                      //ICON CATEGORY SELECTION CONTAINER
                      //HERE IF ISEXPANDED IS FALSE WE DISPLAY EMPTY CONTAINER
                      isExpanded
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(12),
                                ),
                              ),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 5.0,
                                  crossAxisSpacing: 5.0,
                                ),
                                padding: const EdgeInsets.all(5.0),
                                itemCount: categoryIcons.length,
                                itemBuilder: (context, int i) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        categoryIconSelected = categoryIcons[i];
                                      });
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3,
                                            color: categoryIconSelected ==
                                                    categoryIcons[i]
                                                ? Colors.green
                                                : Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12.0),

                                        // image: DecorationImage(
                                        //     image: AssetImage('assets/images/${categoryIcons[i]}.png')
                                        // ),
                                      ),
                                      child: Image.asset(
                                        'assets/images/${categoryIcons[i]}.png',
                                        fit: BoxFit
                                            .contain, // Ensure the image fits inside the container with padding
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 16,
                      ),
                      //CATEGORY COLOR INPUT
                      TextFormField(
                        controller: categoryColorController,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (ctx2) {
                                return BlocProvider.value(
                                  value: context.read<CreateCategoryBloc>(),
                                  child: AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ColorPicker(
                                          pickerColor: categoryColor,
                                          onColorChanged: (value) {
                                            setState(() {
                                              categoryColor = value;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: TextButton(
                                            onPressed: () {
                                              //SO IF WE POP CONTEXT HERE IT WILL POP THE WHOLE DIALOG BOX
                                              //BUT IF WE POP CTX2 IT WILL POP THE COLOR PICKER DIALOG ONLY
                                              Navigator.pop(ctx2);
                                            },
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                )),
                                            child: const Text(
                                              "Save color",
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
                              });
                        },
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          //WE USE FILLED AND FILL TO GIVE BG COLOR TO OUR FORMFIELD
                          filled: true,
                          isDense: true,
                          fillColor: categoryColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                          hintText: "Color",
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      //MAIN DIALOG BOX SAVE BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: kToolbarHeight,
                        child: isLoading == true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : TextButton(
                                onPressed: () {
                                  //CREATE CATEGORY OBJECT AND POP
                                  setState((){
                                    category.categoryId = const Uuid().v1();
                                    category.name = categoryNameController.text;
                                    category.icon = categoryIconSelected;
                                    category.color = categoryColor.value;
                                  });

                                  context
                                      .read<CreateCategoryBloc>()
                                      .add(CreateCategory(category));
                                  //Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
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
              ),
            );
          },
        ),
      );
    },
  );
}
