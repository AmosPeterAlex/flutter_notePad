import 'package:hive/hive.dart';

class CategoryController{
  final catBox=Hive.box('categories');
  // final noteBox=Hive.box('noteBox');
  //edh nml name cheynna function name aanu
  void initializeApp() async{
    List<String> defaultCategories=['Work','Personal','Ideas'];
    bool categoriesExist=catBox.isNotEmpty;
    if(!categoriesExist){
      for(String categoryName in defaultCategories){
        catBox.add(categoryName);//(1.01pm 7.1.24)
      }
    }
  }
  //Function to get all categories
  List getAllCategories(){
    return catBox.values.toList();
  }
}
