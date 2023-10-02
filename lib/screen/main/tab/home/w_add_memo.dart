import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/model/memo.dart';
import 'package:fast_app_base/viewmodel/memo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMemoPage extends StatelessWidget {
  const AddMemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = TextEditingController();
    final content = TextEditingController();

    final memoViewModel = Provider.of<MemoViewModel>(context);

    return Scaffold(
      
      appBar: AppBar(
        title: Text('메모 작성'),
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
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
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
                      InputDecoration(labelText: '내용', hintText: '내용을 작성해주세요',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),),
                  expands: true,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {

                      memoViewModel.addMemo(Memo(title: title.text, content: content.text, createdDate: DateTime.now()));
                      //memoViewModel.firebase_add_memo(Memo(title: title.text, content: content.text, createdDate: DateTime.now()));

                      Navigator.of(context).pop();


                      context.showSnackbar('메모가 추가되었습니다.');

                    },
                    child: Text('등록'),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
