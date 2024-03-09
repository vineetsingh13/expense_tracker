import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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

  List<String> categoryIcons=[
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel'
  ];

  String categoryIconSelected = '';
  late Color categoryColor;

  @override
  void initState() {
    // TODO: implement initState
    //THE DATE FORMAT IS PART OF INTL PACKAGE
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //USING THIS GESTURE DETECTOR & UNFOCUS IF I CLICK ANYWHERE ON THE SCREEN
      //MY textformfield WOULD BECOME UNFOCUSED
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Padding(
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
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide.none),
                  //HERE INSTEAD OF FAICON IF WE JUST USE ICON THE ICON WILL BE CENTERED IN THE FORMFIELD
                  prefixIcon: const Icon(
                    FontAwesomeIcons.list,
                    size: 18,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              bool isExpanded = false;

                              //WE DECLARE THE VARIABLES HERE BECAUSE WE WANT THEM UNTIL THE CATEGORY DIALOG IS ACTIVE
                              //AFTER THAT WE DONT WANT THEM TO SAVE THE VALUE SO WE INITIALIZE THEM HERE
                              String categoryIconSelected = '';
                              Color categoryColor = Colors.white;

                              //HERE IF WE NORMALLY RETURN ALERTDIALOG IT WILL NOT WORK BECAUSE THE STATE IS NOT UPDATE OF THE UI
                              //WHEN THE CONTEXT CHANGES SO TO DO THIS WE ENCLOSE IT IN A STATEFUL BUILDER
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text("Create a category"),
                                  content: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        //NAME INPUT
                                        TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                            //WE USE FILLED AND FILL TO GIVE BG COLOR TO OUR FORMFIELD
                                            filled: true,
                                            fillColor: Colors.white,
                                            //is dense takes less vertical space
                                            isDense: true,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide.none),
                                            hintText: "Name",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        //CATEGORY ICON INPUT
                                        TextFormField(
                                          readOnly: true,
                                          onTap: () {
                                            setState(() {
                                              isExpanded = !isExpanded;
                                            });
                                          },
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: const InputDecoration(
                                            //WE USE FILLED AND FILL TO GIVE BG COLOR TO OUR FORMFIELD
                                            filled: true,
                                            isDense: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
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
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    bottom: Radius.circular(12),
                                                  ),
                                                ),
                                                child: GridView.builder(
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    mainAxisSpacing: 5.0,
                                                    crossAxisSpacing: 5.0,
                                                  ),
                                                  padding: const EdgeInsets.all(5.0),
                                                  itemCount: categoryIcons.length,
                                                    itemBuilder: (context,int i){

                                                      return GestureDetector(
                                                        onTap: (){
                                                          setState((){
                                                            categoryIconSelected=categoryIcons[i];
                                                          });
                                                        },
                                                        child: Container(
                                                          child: Image.asset(
                                                            'assets/images/${categoryIcons[i]}.png',
                                                            fit: BoxFit.contain, // Ensure the image fits inside the container with padding
                                                          ),
                                                          width: 50,
                                                          height: 50,
                                                          padding: const EdgeInsets.all(5.0),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              width: 3,
                                                              color: categoryIconSelected==categoryIcons[i]
                                                                  ? Colors.green : Colors.grey
                                                            ),
                                                            borderRadius: BorderRadius.circular(12.0),

                                                            // image: DecorationImage(
                                                            //     image: AssetImage('assets/images/${categoryIcons[i]}.png')
                                                            // ),

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
                                          onTap: (){

                                            showDialog(
                                                context: context,
                                                builder: (ctx2){
                                                  return AlertDialog(
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        ColorPicker(
                                                          pickerColor: categoryColor,
                                                          onColorChanged: (value){
                                                            setState((){
                                                              categoryColor=value;
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
                                                  );
                                                });
                                          },
                                          readOnly: true,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                            //WE USE FILLED AND FILL TO GIVE BG COLOR TO OUR FORMFIELD
                                            filled: true,
                                            isDense: true,
                                            fillColor: categoryColor,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide.none),
                                            hintText: "Color",
                                          ),
                                        ),
                                        const SizedBox(height: 16,),

                                        //MAIN DIALOG BOX SAVE BUTTON
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
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
                                );
                              });
                            });
                      },
                      icon: const Icon(
                        FontAwesomeIcons.plus,
                        size: 16,
                        color: Colors.grey,
                      )),
                  //THIS CREATES A ONCLICK TOP MOVING TEXT
                  label: const Text("Category"),
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
                    selectDate = newDate;
                    dateController.text =
                        DateFormat('dd/MM/yyyy').format(newDate);
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
                child: TextButton(
                  onPressed: () {},
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
      ),
    );
  }
}
