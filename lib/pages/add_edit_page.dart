import 'package:final_assignment_3/database_helper/database_help.dart';
import 'package:flutter/material.dart';
import '../models/model.dart';
import 'form_page.dart';

// ignore: must_be_immutable
class AddEditPage extends StatefulWidget {
  int? textID;
  String? textAuthor;
  String? textTitle;
  String? textDescription;
  bool? update;
  AddEditPage({
    super.key,
    this.textID,
    this.textAuthor,
    this.textTitle,
    this.textDescription,
    this.update
  });

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  DatabaseHelper? dbHelper;
  late Future<List<TextModel>> textList;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    dbHelper = DatabaseHelper();
    loadData();
    super.initState();
  }

  loadData() async {
    textList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    final authorCon = TextEditingController(text: widget.textAuthor);
    final titleCon = TextEditingController(text: widget.textTitle);
    final descriptionCon = TextEditingController(text: widget.textDescription);

    String appTitle;
    if(widget.update == true){
      appTitle = "Update Diary";
    }
    else{
      appTitle = "Add Diary";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle,
            style: const TextStyle(
                fontSize: 15
            )
        ),
        centerTitle: true,
      ),
      body: Card(
        elevation: 20,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                    controller: authorCon,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(),
                        hintText: 'Author Name'
                    ),
                    validator: (value){
                      return value == null || value.isEmpty ?
                      'Enter Author Name' : null;
                    }
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                    controller: titleCon,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(),
                        hintText: 'Title'
                    ),
                    validator: (value1){
                      return value1 == null || value1.isEmpty ?
                      'Enter Title' : null;
                    }
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                    controller: descriptionCon,
                    keyboardType: TextInputType.text,
                    minLines: 5,
                    maxLines: 8,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(),
                        hintText: 'Description'
                    ),
                    validator: (value2){
                      return value2 == null || value2.isEmpty ?
                      'Enter Description' : null;
                    }
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)
                  ),
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      if(widget.update == true){
                        dbHelper!.update(TextModel(
                          id: widget.textID,
                          author: authorCon.text,
                          title: titleCon.text,
                          description: descriptionCon.text,
                        )
                        );
                      }
                      else{
                        dbHelper!.insert(TextModel(
                          author: authorCon.text,
                          title: titleCon.text,
                          description: descriptionCon.text,
                        )
                        );
                      }
                      Navigator.push(context, MaterialPageRoute(
                          builder:(context) => const FormPage()));
                      authorCon.clear();
                      titleCon.clear();
                      descriptionCon.clear();
                    }
                  },
                  child: const Text('Submit',
                      style: TextStyle(fontSize: 15)
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
