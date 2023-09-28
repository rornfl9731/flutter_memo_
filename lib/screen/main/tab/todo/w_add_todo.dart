import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/model/memo.dart';
import 'package:fast_app_base/model/todo.dart';
import 'package:fast_app_base/viewmodel/memo_viewmodel.dart';
import 'package:fast_app_base/viewmodel/todo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToDoPage extends StatelessWidget {
  const AddToDoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = TextEditingController();
    final content = TextEditingController();

    final todoViewModel = Provider.of<ToDoViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('리스트'),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(
                  labelText: '제목',
                  hintText: '제목을 작성해주세요',
                ),

              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TextField(
                  controller: content,
                  maxLines: null,
                  maxLength: 256,
                  decoration:
                  InputDecoration(labelText: '내용', hintText: '내용을 작성해주세요'),
                  expands: true,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {

                      todoViewModel.addToDo(ToDo(title: title.text, content: content.text, createdDate: DateTime.now()));
                      //memoViewModel.firebase_add_memo(Memo(title: title.text, content: content.text, createdDate: DateTime.now()));

                      Navigator.of(context).pop();


                      context.showSnackbar('리스트가 추가되었습니다.');

                    },
                    child: Text('등록'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
