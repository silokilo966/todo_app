import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoApp'),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushTodoScreen,
        tooltip: 'Add an Item',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodoList() {
    //This is called when app starts (but doesn't do anything) then called when _addTodoItem is called
    return ListView.builder(
      //.builder is used instead of ListView when you don't know how many items will be created
      itemCount: _todoItems.length,
      //Only call itemBuilder if 'i' is less than _todoItems, else itemBuilder will create infinite items
      itemBuilder: (context, i) {
        //itemBuilder uses context to keep track of items in list, i is a variable which will be used to count Items that we create
        return _buildTodoItem(
            _todoItems[i]); //return _buildTodoItem with _todoItems[i] arguments
      },
    );
  }

  Widget _buildTodoItem(String todoText) {
    //_buildTodoItem with a string Parameter todoText
    return ListTile(
      //ListTile is used to create the single item in a ListView
      title: Text(todoText), //the text item created using ListTile
    );
  }

  void _pushTodoScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add new Task'),
          ),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              hintText: 'Enter a Task...',
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
        );
      }),
    );
  }

  void _addTodoItem(String task) {
    setState(
      () {
        _todoItems.add(task);
      },
    );
  }
}
