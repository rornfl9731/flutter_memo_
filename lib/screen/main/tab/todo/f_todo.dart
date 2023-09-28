import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/home/w_add_memo.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_add_todo.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_select_todo.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_update_todo.dart';
import 'package:fast_app_base/viewmodel/todo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToDoFragment extends StatefulWidget {
  final bool isShowBackButton;

  const ToDoFragment({
    Key? key,
    this.isShowBackButton = true,
  }) : super(key: key);

  @override
  State<ToDoFragment> createState() => _ToDoFragmentState();
}

class _ToDoFragmentState extends State<ToDoFragment> {
  @override
  Widget build(BuildContext context) {
    final todoViewModel = Provider.of<ToDoViewModel>(context);
    final todos = todoViewModel.todos;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: (ListView.builder(
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    elevation: 5,
                    child: GestureDetector(
                      onLongPress: () {
                        Nav.push(SelectToDo());
                      },
                      onTap: () {
                        Nav.push(UpdateToDoPage(before_todo: todos[index]));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                todoViewModel.toggleFavorite(
                                    todos[index].key, todos[index]);
                              },
                              icon: todos[index].isSucceed == true
                                  ? Icon(
                                      Icons.circle,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      Icons.circle_outlined,
                                    ),
                            ),
                          ),
                          Expanded(
                            flex: 9,
                            child: todos[index].isSucceed
                                ? ListTile(
                                    title: Text(
                                      todos[index].title,
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    subtitle: Text(
                                      todos[index].content,
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : ListTile(
                                    title: Text(todos[index].title),
                                    subtitle: Text(todos[index].content),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: todos.length,
              )),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Nav.push(
                    AddToDoPage(),
                  );
                },
                child: Text('추가하기'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
