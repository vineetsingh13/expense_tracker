import '../entities/category_entity.dart';

class Category{

  String categoryId;
  String name;
  int totalExpenses;
  String icon;
  String color;

  Category({
    required this.categoryId,
    required this.name,
    required this.totalExpenses,
    required this.icon,
    required this.color,
  });

  //FOR INITIALIZING AN EMPTY CATEGORY OBJECT
  static final empty=Category(
      categoryId: '',
      name: '',
      totalExpenses: 0,
      icon: '',
      color: '');

  //FOR CONVERTING A CATEGORY OBJECT TO CATEGORY ENTITY OBJECT TO BE STORED IN FIREBASE
  CategoryEntity toEntity(){
    return CategoryEntity(
      categoryId: categoryId,
      name: name,
      totalExpenses: totalExpenses,
      icon: icon,
      color: color,
    );
  }

  //FOR CONVERTING CATEGORY ENTITY DATA FROM FIREBASE TO CATEGORY OBJECT
  static Category fromEntity(CategoryEntity entity){
    return Category(
        categoryId: entity.categoryId,
        name: entity.name,
        totalExpenses: entity.totalExpenses,
        icon: entity.icon,
        color: entity.color);
  }
}