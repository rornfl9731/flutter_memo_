import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/model/memo.dart';
import 'package:fast_app_base/screen/main/tab/home/w_add_memo.dart';
import 'package:fast_app_base/screen/main/tab/home/w_update_memo.dart';
import 'package:fast_app_base/viewmodel/memo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/widget/round_button_theme.dart';
import '../../../../common/widget/w_round_button.dart';

class MemoFragment extends StatefulWidget {
  final bool isShowBackButton;

  const MemoFragment({
    Key? key,
    this.isShowBackButton = true,
  }) : super(key: key);

  @override
  State<MemoFragment> createState() => _MemoFragmentState();
}

class _MemoFragmentState extends State<MemoFragment> {
  @override
  Widget build(BuildContext context) {
    final memoViewModel = Provider.of<MemoViewModel>(context);
    final memos = memoViewModel.memos;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: (
              memos.length == 0 ? Center(child: Text("메모가 없습니다."),) :
                  ListView.builder(
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    elevation: 5,
                    child: GestureDetector(
                      onTap: () {
                        Nav.push(UpdateMemoPage(before_memo: memos[index],));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            flex:1,
                              child:IconButton(onPressed: (){
                                memoViewModel.toggleFavorite(memos[index].key, memos[index]);

                              },icon: memos[index].isFavorite == true ? Icon(Icons.star,color: Colors.yellow,) : Icon(Icons.star_border_outlined,),)
                          ),
                          Expanded(
                            flex: 9,
                            child: ListTile(
                              title: Text(memos[index].title),
                              subtitle: Text(memos[index].content),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: memos.length,
              )),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Nav.push(
                    AddMemoPage(),
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
