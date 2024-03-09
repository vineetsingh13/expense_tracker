class CategoryEntity {

  String categoryId;
  String name;
  int totalExpenses;
  String icon;
  String color;

  CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.totalExpenses,
    required this.icon,
    required this.color,
  });

  //WE DO THIS BECAUSE IN FIREBASE WE HAVE TO STORE AS KEY VALUE PAIR
  //FIREBASE DOESNOT UNDERSTAND OBJECT
  //SO WE CONVERT OUR DATA INTO MAP TO STORE INTO FIREBASE
  Map<String, Object?> toDocument(){

    return {
      'categoryId': categoryId,
      'name': name,
      'totalExpenses': totalExpenses,
      'icon': icon,
      'color': color,
    };
  }


  //SO FIREBASE WOULD RETURN A KEY VALUE PAIR SO WE STORE THE DATA IN CATEGORYENTITY
  //THEN WE CONVERT IT TO CATEGORY OBJECT TO BE USED IN APP
  static CategoryEntity fromDocument(Map<String, dynamic> doc){
    return CategoryEntity(
        categoryId: doc['categoryId'],
        name: doc['name'],
        totalExpenses: doc['totalExpenses'],
        icon: doc['icon'],
        color: doc['color'],
    );
  }
}