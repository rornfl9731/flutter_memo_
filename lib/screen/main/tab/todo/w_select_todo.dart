import 'package:fast_app_base/app.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/model/memo.dart';
import 'package:fast_app_base/screen/main/tab/home/w_add_memo.dart';
import 'package:fast_app_base/screen/main/tab/home/w_update_memo.dart';
import 'package:fast_app_base/viewmodel/memo_viewmodel.dart';
import 'package:fast_app_base/viewmodel/todo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/todo.dart';

class SelectToDo extends StatefulWidget {
  const SelectToDo({super.key});

  @override
  State<SelectToDo> createState() => _SelectToDoState();
}

class _SelectToDoState extends State<SelectToDo> {
  bool? isAllSelect = false;

  @override
  Widget build(BuildContext context) {
    final todoViewModel = Provider.of<ToDoViewModel>(context);
    final todos = todoViewModel.todos;

    return Scaffold(
      appBar: AppBar(
        title: Text('체크'),
        leading: IconButton(
          onPressed: () {
            // for (int i = 0; i < memos.length; i++) {
            //   memoViewModel.backBoxCheckedDelete(memos[i].key, memos[i]);
            // }

            for (int i = 0; i < todos.length; i++) {
              //memoViewModel.allSelectBoxCheckedDelete(memos[i].key, memos[i]);
              todos[i].isBoxChecked = false;
            }

            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text('전부', style: TextStyle(fontSize: 20,),),
                  Checkbox(
                    value: isAllSelect,
                    onChanged: (value) {
                      setState(() {
                        if (isAllSelect == false) {
                          for (int i = 0; i < todos.length; i++) {
                            //memoViewModel.allSelectBoxCheckedDelete(memos[i].key, memos[i]);
                            todos[i].isBoxChecked = true;
                          }
                          isAllSelect = value;
                          print(isAllSelect);
                        } else if (isAllSelect == true) {
                          for (int i = 0; i < todos.length; i++) {
                            //memoViewModel.backBoxCheckedDelete(memos[i].key, memos[i]);
                            todos[i].isBoxChecked = false;
                          }
                          isAllSelect = value;
                          print(isAllSelect);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: (ListView.builder(
                  itemBuilder: (BuildContext context, index) {
                    return Card(
                      color: todos[index].isBoxChecked
                          ? Colors.grey.shade500
                          : null,
                      elevation: 5,
                      child: GestureDetector(
                        onTap: () {
                          print(todos[index].isBoxChecked);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Checkbox(
                                value: todos[index].isBoxChecked,
                                onChanged: (value) {
                                  todoViewModel.toggleBoxChecked(
                                      todos[index].key, todos[index]);
                                },
                              ),
                            ),
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
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      subtitle: Text(
                                        todos[index].content,
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
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
                    List<ToDo> checkedToDo = [];
                    for (int i = 0; i < todos.length; i++) {
                      if (todos[i].isBoxChecked) {
                        checkedToDo.add(todos[i]);
                        //memoViewModel.deleteMemo(memos[i].key);
                      }
                    }

                    todoViewModel.boxCheckedDelete(checkedToDo);
                  },
                  child: Text('삭제하기'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
