import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoApp',
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
        onPressed: _showAddTodoItem,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(_todoItems[index], index);
      },
    );
  }

  void _showAddTodoItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Item'),
            ),
            body: TextField(
              decoration: InputDecoration(hintText: 'Add todo Item'),
              autofocus: true,
              onSubmitted: (val) {
                setState(
                  () {
                    _todoItems.add(val);
                  },
                );
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildTodoItem(String index, int i) {
    return ListTile(
      trailing: Icon(Icons.done),
      onTap: () => _promptRemoveItem(i),
      title: Text(index),
    );
  }

  void _promptRemoveItem(int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mark "${_todoItems[i]}" as done?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _removeItem(i);
                Navigator.pop(context);
              },
              child: Text('Mark as Done!'),
            )
          ],
        );
      },
    );
  }

  void _removeItem(int i) {
    setState(() {
      _todoItems.removeAt(i);
    });
  }
}
