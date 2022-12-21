import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../database_helper/database_help.dart';
import '../models/model.dart';
import 'add_edit_page.dart';
import 'dart:async';

import 'details_page.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  DatabaseHelper? dbHelper;
  late Future<List<TextModel>> textList;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    loadData();
  }
  void loadData() async{
    textList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.book_outlined),
        title: const Text("Diary Note",
            style: TextStyle(
                fontSize: 15
            )
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: textList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<TextModel>> snapshot){
                  if(!snapshot.hasData || snapshot.data == null){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if(snapshot.data!.isEmpty){
                    return const Center(
                      child: Text("Empty Notes"),
                    );
                  }
                  else{
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index){
                          int textID =
                          snapshot.data![index].id!.toInt();
                          String textAuthor =
                          snapshot.data![index].author.toString();
                          String textTitle =
                          snapshot.data![index].title.toString();
                          String textDescription =
                          snapshot.data![index].description.toString();
                          return Dismissible(
                            key: ValueKey<int>(textID),
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              color: Colors.redAccent,
                              child: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.white),
                            ),
                            onDismissed: (DismissDirection direction) async{
                              setState(() {
                                dbHelper!.delete(textID);
                                textList = dbHelper!.getDataList();
                                snapshot.data!.remove(snapshot.data![index]);
                              });
                            },
                            child: Card(
                              elevation: 20,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        backgroundColor: Color(0xff1b6c5c),
                                        child: Icon(Icons.account_box_outlined),
                                      ),
                                      title: Text(textTitle,
                                        style: const TextStyle(fontSize: 17,
                                            fontWeight: FontWeight.bold
                                        ) ,
                                      ),
                                      subtitle: Text(textAuthor,
                                        style: const TextStyle(fontSize: 12,
                                            fontStyle: FontStyle.italic
                                        ) ,
                                      ),
                                      trailing: Wrap(
                                        spacing: 0,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit_note_outlined,
                                                color: Colors.black38
                                       ),
                                       onPressed: (){
                                       Navigator.push(context, MaterialPageRoute(
                                       builder:(context) =>  AddEditPage(
                                       textID: textID,
                                       textAuthor: textAuthor,
                                       textTitle: textTitle,
                                       textDescription: textDescription,
                                       update: true
                                     )
                                   )
                                   );
                                },
                               ),
                            ],
                           ),
                        ),
                      ),
                   ],
                   ),
                  ),
                  );
                }
               );
              }
              }
            ),
          ),
        ],
      ),
          floatingActionButton: SpeedDial(
        icon: Icons.add,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.edit_calendar),
            label: 'Add Diary',
            labelStyle: const TextStyle(fontSize: 12),
            elevation: 10,
            backgroundColor: Colors.blueAccent,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
              builder:(context) =>  AddEditPage()));
            }
          ),
          SpeedDialChild(
              child: const Icon(Icons.book_outlined),
              label: 'Diary Details',
              labelStyle: const TextStyle(fontSize: 12),
              elevation: 10,
              backgroundColor: Colors.redAccent,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder:(context) =>  const DetailsPage()));
              }
          )
        ],
     ),
    );
  }
 }
