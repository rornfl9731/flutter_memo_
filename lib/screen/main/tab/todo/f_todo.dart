import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/model/todo.dart';
import 'package:fast_app_base/screen/main/tab/home/w_add_memo.dart';
import 'package:fast_app_base/screen/main/tab/todo/isar/test_todo.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_add_todo.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_select_todo.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_update_todo.dart';
import 'package:fast_app_base/viewmodel/todo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../dialog/d_color_bottom.dart';

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
    final todoTitle = TextEditingController();
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
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.circle_outlined,
                                    ),
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: todos[index].isSucceed
                                ? ListTile(
                                    title: Text(
                                      todos[index].title,
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : ListTile(
                                    title: Text(todos[index].title),
                                  ),
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.restore_from_trash_outlined),
                                onPressed: () {
                                  todoViewModel.deleteToDo(todos[index].key);
                                },
                              )),
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
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                            height: 200,
                            color: context.appColors.seedColor
                                .getMaterialColorValues[200],
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 20,),
                                  TextField(
                                    controller: todoTitle,
                                    autofocus: true,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      labelText: '내용',
                                      hintText: '내용을 작성해주세요',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        todoViewModel.addToDo(
                                          ToDo(
                                            title: todoTitle.text,
                                            content: "",
                                            createdDate: DateTime.now(),
                                          ),
                                        );



                                        Navigator.pop(context);
                                      },
                                      child: Text("추가하기"))
                                ],
                              ),
                            ));
                      });
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
