import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:share_plus/share_plus.dart';

import '../model/notes_model.dart';
import '../view/widgets/add_category.dart';
import '../view/widgets/remove_category.dart';

class CategoryController {
  final catBox = Hive.box('categories');
  final noteBox = Hive.box('noteBox');

  //edh nml name cheynna function name aanu
  void initializeApp() async {
    List<String> defaultCategories = ['Work', 'Personal', 'Ideas'];
    bool categoriesExist = catBox.isNotEmpty;
    if (!categoriesExist) {
      for (String categoryName in defaultCategories) {
        catBox.add(categoryName); //(1.01pm 7.1.24)
      }
    }
  }

  void addUserCategory(String categoryName) {
    catBox.add(categoryName);
  }

  //Function to get all categories
  List getAllCategories() {
    return catBox.values.toList();
  }

  addCategory({
    required BuildContext context,
    required TextEditingController categoryController,
    required CategoryController catController,
    required void Function() fetchData,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AddCategoryDialog(
          categoryEditController: categoryController,
          catController: catController,
          fetchData: fetchData),
    );
  }

  removeUserCategory({required int catIndex, required Function() fetchData}) {
    print(catIndex);
    print(catBox.get(catIndex));
    print(noteBox.get(catIndex));
    noteBox.delete(catIndex);
    catBox.delete(catIndex);
    fetchData();
  }

  removeCategory(
      {required int catIndex,
      required String catName,
      required BuildContext context,
      required void Function() fetchData}) {
    return showDialog(
      context: context,
      builder: (context) => RemoveCategoryDialog(
          categoryName: catName, categoryIndex: catIndex, fetchData: fetchData),
    );
  }
}

class NotesController {
  final noteBox = Hive.box('noteBox');

  void addNotes(
      {required GlobalKey<FormState> formKey,
      required String title,
      required String description,
      required String date,
      required int category,
      required TextEditingController titleController,
      required TextEditingController desController,
      required BuildContext context}) {
    if (formKey.currentState!.validate()) {
      List<NotesModel> currentNotes = noteBox.containsKey(category)
          ? noteBox.get(category)!.cast<NotesModel>()
          : []; // Initialize as an empty list if category doesn't exist

      var note = NotesModel(
        title: title,
        description: description,
        date: date,
        category: category,
      );

      currentNotes.add(note);
      noteBox.put(category, currentNotes);
      titleController.clear();
      desController.clear();
      Navigator.pop(context);
    }
  }

  void deleteNote({
    required var key,
    required NotesModel note,
    required void Function() fetchData,
    required int index,
  }) {
    List<NotesModel> list = noteBox.get(key)!.cast<NotesModel>();
    print("before: $list");
    print("index: $index");
    print("lis length  : ${list.length}");

    if (index < 0 || index >= list.length) {
      print("Invalid index: $index. Index out of range.");
      return; // Exit the function if index is out of range
    }

    print("before2: $list");
    list.remove(note);
    print("after: $list");
    noteBox.put(key, list);
    print("updated: ${noteBox.get(key)}");

    if (list.length == 0) {
      noteBox.delete(key);
    }
  }

  void editNote({
    required String title,
    required String description,
    required String date,
    required int category,
    required GlobalKey<FormState> formKey,
    required int indexOfNote,
    required int oldCategory,
  }) {
    List<NotesModel> currentNotes =
        noteBox.get(oldCategory)?.cast<NotesModel>() ?? [];
    NotesModel note = NotesModel(
      title: title,
      description: description,
      date: date.toString(),
      category: category,
    );

    currentNotes.removeAt(indexOfNote);
    noteBox.put(oldCategory, currentNotes);

    if (currentNotes.isEmpty) {
      noteBox.delete(oldCategory);
    }

    List<NotesModel> updatedNotes =
        noteBox.get(category)?.cast<NotesModel>() ?? [];
    updatedNotes.add(note);
    noteBox.put(category, updatedNotes);
  }

  void shareNote({required String Note}) {
    Share.share(Note);
  }
}
