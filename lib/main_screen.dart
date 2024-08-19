import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/add_todo.dart';
import 'package:todoapp/widgets/todoList.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> todoList = [];

  @override
  void initState() {
    super.initState();
    loadData(); // Load the data when the widget is initialized
  }

  void addTodo(String todoText) {
    if (todoList.contains(todoText)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Todo already exists'),
              content: Text('This todo item already exists.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close')),
              ],
            );
          });
      return;
    }
    setState(() {
      todoList.insert(0, todoText);
    });
    saveLocalData();
    Navigator.pop(context);
  }

  void saveLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todolist', todoList);
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todoList = (prefs.getStringList('todolist') ?? []).toList();
    setState(() {});
  }

  void updateLocalData() {
    saveLocalData();
  }

  void showAddTodoBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: EdgeInsets.all(20),
                height: 200,
                child: AddTodo(
                  addTodo: addTodo,
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[900],
        shape: CircleBorder(),
        onPressed: showAddTodoBottomSheet,
        child: Icon(Icons.add, color: Colors.white),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.blueGrey[900],
              child: Center(
                child: Text(
                  'Todo App',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse(
                    'https://www.facebook.com/OurLokmanHossen?mibextid=ZbWKwL'));
              },
              title: Text(
                'About me',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.person),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse('mailto:mhlokman@gmail.com'));
              },
              title: Text(
                'Contact me',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.mail),
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo App'),
      ),
      body:
          TodoListBuilder(todoList: todoList, updateLocalData: updateLocalData),
    );
  }
}
