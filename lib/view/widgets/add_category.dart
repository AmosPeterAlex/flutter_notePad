import 'package:flutter/material.dart';

import '../../controller/category_controller.dart';
import '../utils/color_constants.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog(
      {super.key,
      required this.categoryEditController,
      required this.catController,
      required this.fetchData});

  final TextEditingController categoryEditController;
  final CategoryController catController;
  final void Function() fetchData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text("Add category"),
      content: TextField(
        controller: categoryEditController,
        maxLines: 1,
        decoration: InputDecoration(
          labelText: "Category",
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorConstants.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          labelStyle: TextStyle(
            color: ColorConstants.primaryColor,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: ColorConstants.primaryColor,
              )),
          isDense: false,
          // Added this
          contentPadding:  EdgeInsets.all(20),
        ),
      ),
      actions: [
        SizedBox(
          width: 200,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(ColorConstants.primaryColor)),
            onPressed: () {
              categoryEditController.clear();
              Navigator.pop(context);
            },
            child:  Text("Close"),
          ),
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(ColorConstants.primaryColor)),
            onPressed: () {
              catController.addUserCategory(categoryEditController.text);
              categoryEditController.clear();
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Category added success full")));
              fetchData();
            },
            child: const Text("Add"))
      ],
    );
  }
}
