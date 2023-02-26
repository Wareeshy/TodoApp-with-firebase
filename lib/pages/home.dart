import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/login/signin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;

  List todos = List.empty();
  String title = "";
  String description = "";
  @override
  void initState() {
    super.initState();
    todos = ["Hello", "Hey There"];
  }

  createToDo() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyTodos").doc(title);

    Map<String, String> todoList = {
      "todoTitle": title,
      "todoDesc": description
    };

    documentReference
        .set(todoList)
        .whenComplete(() => print("Data stored successfully"));
  }

  deleteTodo(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyTodos").doc(item);

    documentReference
        .delete()
        .whenComplete(() => print("deleted successfully"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2e8b6d),
        title: Text(
          "Todo App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
        actions: [
          IconButton(
              onPressed: (() {
                auth.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Signin()));
              }),
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("MyTodos").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                      snapshot.data?.docs[index];
                  return documentSnapshot == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Dismissible(
                          key: Key(index.toString()),
                          child: Card(
                            elevation: 4,
                            child: ListTile(
                              leading: Icon(
                                Icons.fiber_manual_record_rounded,
                                color: Color(0xff2e8b6d),
                              ),
                              title: Text((documentSnapshot["todoTitle"])),
                              subtitle: Text((documentSnapshot["todoDesc"])),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    //todos.removeAt(index);
                                    deleteTodo((documentSnapshot["todoTitle"]));
                                    //updateTodo((documentSnapshot != null)
                                    //  ? (documentSnapshot[title])
                                    //  : "");
                                  });
                                },
                              ),
                            ),
                          ));
                });
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.red,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff2e8b6d),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: const Text("Add Todo"),
                  content: Container(
                    width: 400,
                    height: 110,
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(hintText: 'Enter Title'),
                          onChanged: (String value) {
                            title = value;
                          },
                        ),
                        TextField(
                          decoration:
                              InputDecoration(hintText: 'Enter Descrition'),
                          onChanged: (String value) {
                            description = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          setState(() {
                            //todos.add(title);
                            createToDo();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Color(0xff2e8b6d)),
                        ))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
