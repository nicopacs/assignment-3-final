import 'package:flutter/material.dart';

import '../database_helper/database_help.dart';
import '../models/model.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
        title: const Text("Diary Details",
            style: TextStyle(fontSize: 15)
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<TextModel>>(
            future: textList,
            builder: (BuildContext context,
                AsyncSnapshot<List<TextModel>> snapshot){
              return snapshot.data!.isEmpty ?
              const Center(
                  child: Text('No Records'))
                  : ListView(
                children: snapshot.data!.map((texts){
                  return Card(
                    elevation: 15,
                    color: Colors.black26,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.contact_mail_sharp,
                            color: Colors.tealAccent,
                          ),
                          title: Text(texts.author,
                            style: const TextStyle(
                              color: Colors.white70,
                            ),

                          ),
                        ),
                        ListTile(
                          title: Text('Title: ${texts.title}',
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text('Description: ${texts.description}',
                            style: const TextStyle(
                                color: Colors.white70
                            ),
                          ),

                        ),
                      ],
                    ),
                  );
                }).toList(),

              );
            }

        ),
      ),
    );
  }
}
