import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/model/memo.dart';
import 'package:fast_app_base/model/todo.dart';
import 'package:fast_app_base/viewmodel/memo_viewmodel.dart';
import 'package:fast_app_base/viewmodel/todo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../dialog/d_confirm.dart';

class UpdateToDoPage extends StatelessWidget {


  final ToDo before_todo;

  const UpdateToDoPage({Key? key, required this.before_todo}) : super(key: key);





  @override
  Widget build(BuildContext context) {



    final todoViewModel = Provider.of<ToDoViewModel>(context);

    final title = TextEditingController(text: before_todo.title);
    final content = TextEditingController(text: before_todo.content);


    Future<void> showConfirmDialog(BuildContext context) async {
      final confirmDialogResult = await ConfirmDialog(
        '정말 삭제하시겠습니까?',
        buttonText: "네",
        cancelButtonText: "아니오",
      ).show();
      debugPrint(confirmDialogResult?.isSuccess.toString());

      confirmDialogResult?.runIfSuccess((data) {
        todoViewModel.deleteToDo(before_todo.key);
        Navigator.pop(context);
        context.showErrorSnackbar('메모가 삭제되었습니다.');
      });

      confirmDialogResult?.runIfFailure((data) {


      });
    }



    return Scaffold(
      appBar: AppBar(
        title: Text('메모'),
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

                      todoViewModel.updateToDo(before_todo.key , ToDo(title: title.text, content: content.text, createdDate: DateTime.now(),isSucceed: before_todo.isSucceed));

                      Navigator.of(context).pop();
                      context.showSnackbar('메모가 수정되었습니다.');

                    },
                    child: Text('수정'),
                  ),
                  ElevatedButton(
                    onPressed: () {



                      showConfirmDialog(context);

                    },
                    child: Text('삭제'),
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


