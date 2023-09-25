import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/model/memo.dart';
import 'package:fast_app_base/viewmodel/memo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../dialog/d_confirm.dart';

class UpdateMemoPage extends StatelessWidget {


  final Memo before_memo;

  const UpdateMemoPage({Key? key, required this.before_memo}) : super(key: key);





  @override
  Widget build(BuildContext context) {



    final memoViewModel = Provider.of<MemoViewModel>(context);

    final title = TextEditingController(text: before_memo.title);
    final content = TextEditingController(text: before_memo.content);


    Future<void> showConfirmDialog(BuildContext context) async {
      final confirmDialogResult = await ConfirmDialog(
        '정말 삭제하시겠습니까?',
        buttonText: "네",
        cancelButtonText: "아니오",
      ).show();
      debugPrint(confirmDialogResult?.isSuccess.toString());

      confirmDialogResult?.runIfSuccess((data) {
        memoViewModel.deleteMemo(before_memo.key);
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

                      memoViewModel.updateMemo(before_memo.key , Memo(title: title.text, content: content.text, createdDate: DateTime.now(),isFavorite: before_memo.isFavorite));

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


