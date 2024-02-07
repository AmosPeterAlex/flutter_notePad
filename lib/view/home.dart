import 'package:flutter/material.dart';
import 'package:flutter_notepad/controller/category_controller.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    catController.initializeApp();
    categories = catController.getAllCategories();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  List categories = [];
  CategoryController catController = CategoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(width: 2, color: Colors.white),
        ),
        onPressed: () => bottomSheet(context),
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.teal[100],
      shape: OutlineInputBorder(
        borderSide: BorderSide(width: 0),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context,
                InsetState) => //Setstate oke avoid akan endo aa(12.15pm of 7.1.24 refer)
            Padding(
          padding:
              // EdgeInsets.only(bottom: 500),
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: titleController,
                      maxLines: 1,
                      decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(color: Colors.blueAccent),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.redAccent, width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          isDense: false,
                          contentPadding: EdgeInsets.all(20),
                          hintText: "Title"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 150,
                      child: TextFormField(
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.multiline,
                        controller: descriptionController,
                        decoration: InputDecoration(
                            isDense: false,
                            contentPadding: EdgeInsets.all(20),
                            labelText: 'Description',
                            labelStyle: TextStyle(color: Colors.blueAccent),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.redAccent, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: "Description"),
                      ),
                    ),
                    Text(
                      'Category',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      child: Row(
                        children: List.generate(
                          categories.length + 1,
                          (index) => index == categories.length
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    " + Add Category",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'hiiii',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
