import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_with_adapter_sample/model/notes_model.dart';
import 'package:hive_with_adapter_sample/utils/db/db.dart';
import 'package:hive_with_adapter_sample/view/widgets/note_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var box = Hive.box<NotesModel>('noteBox');
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  List keysList = [];
  int selectedColor = 0;
  bool isEditing = false;

  @override
  void initState() {
    // TODO: implement initState

    keysList = box.keys.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: Colors.white),
        ),
        elevation: 0,
        onPressed: () {
          bottomSheet(context, null);
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return NoteTile(
              tilte: box.get(keysList[index])?.tile ?? "",
              description: box.get(keysList[index])?.description ?? "",
              date: box.get(keysList[index])?.date ?? "",
              category: box.get(keysList[index])?.category ?? "",
              color: box.get(keysList[index])!.color,
              onDelete: () {
                box.delete(
                  keysList[index],
                );
                keysList = box.keys.toList();
                setState(() {});
              },
              onUpdate: () {
                isEditing = true;
                titleController.text = box.get(keysList[index])!.tile;
                descriptionController.text =
                    box.get(keysList[index])!.description;
                dateController.text = box.get(keysList[index])!.date;
                categoryController.text = box.get(keysList[index])!.category;
                selectedColor = box.get(keysList[index])!.color;
                bottomSheet(
                  context,
                  keysList[index],
                );
              },
            );
          },
          separatorBuilder: (context, index) => Divider(
                height: 15,
              ),
          itemCount: keysList.length),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context, int? key) {
    return showModalBottomSheet(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, InsetState) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 5,
                          ),
                        ),
                        hintText: "Title..."),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 5,
                          ),
                        ),
                        hintText: "Description..."),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: categoryController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 5,
                          ),
                        ),
                        hintText: "Category..."),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 5,
                          ),
                        ),
                        suffixIcon: Icon(Icons.calendar_month),
                        hintText: "Date..."),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      Database.myColors.length,
                      (index) => InkWell(
                        onTap: () {
                          selectedColor = index;
                          InsetState(() {});
                        },
                        child: Container(
                          height: selectedColor == index ? 60 : 50,
                          width: selectedColor == index ? 60 : 50,
                          decoration: BoxDecoration(
                            color: Database.myColors[index],
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (isEditing) {
                          box.put(
                              key,
                              NotesModel(
                                  tile: titleController.text,
                                  description: descriptionController.text,
                                  category: categoryController.text,
                                  date: dateController.text,
                                  color: selectedColor));
                          isEditing = false;
                          keysList = box.keys.toList();
                          Navigator.pop(context);
                          titleController.clear();
                          descriptionController.clear();
                          categoryController.clear();
                          dateController.clear();
                          setState(() {});
                        } else {
                          box.add(NotesModel(
                              tile: titleController.text,
                              description: descriptionController.text,
                              category: categoryController.text,
                              date: dateController.text,
                              color: selectedColor));
                          keysList = box.keys.toList();
                          Navigator.pop(context);
                          titleController.clear();
                          descriptionController.clear();
                          categoryController.clear();
                          dateController.clear();
                          setState(() {});
                        }
                      },
                      child: isEditing ? Text("Edit") : Text("Add"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
