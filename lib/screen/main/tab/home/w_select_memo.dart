import 'package:fast_app_base/app.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/model/memo.dart';
import 'package:fast_app_base/screen/main/tab/home/w_add_memo.dart';
import 'package:fast_app_base/screen/main/tab/home/w_update_memo.dart';
import 'package:fast_app_base/viewmodel/memo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectMemo extends StatefulWidget {
  const SelectMemo({super.key});

  @override
  State<SelectMemo> createState() => _SelectMemoState();
}

class _SelectMemoState extends State<SelectMemo> {

  bool? isAllSelect = false;

  @override
  Widget build(BuildContext context) {
    final memoViewModel = Provider.of<MemoViewModel>(context);
    final memos = memoViewModel.memos;



    return Scaffold(
      appBar: AppBar(
        title: Text('체크'),
        leading: IconButton(
          onPressed: () {
            for (int i = 0; i < memos.length; i++) {
              memoViewModel.backBoxCheckedDelete(memos[i].key, memos[i]);
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
                  Text('전부', style: TextStyle(fontSize: 20,),),
                  Checkbox(
                    value: isAllSelect,
                    onChanged: (value) {
                      setState(() {
                        if(isAllSelect == false) {
                          for (int i = 0; i < memos.length; i++) {
                            memoViewModel.allSelectBoxCheckedDelete(memos[i].key, memos[i]);
                          }
                          isAllSelect = value;
                          print(isAllSelect);
                        } else if(isAllSelect == true) {
                          for (int i = 0; i < memos.length; i++) {
                            memoViewModel.backBoxCheckedDelete(memos[i].key, memos[i]);
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
                      elevation: 5,
                      child: GestureDetector(
                        onTap: () {
                          print(memos[index].isBoxChecked);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Checkbox(
                                value: memos[index].isBoxChecked,
                                onChanged: (value) {
                                  memoViewModel.toggleBoxChecked(
                                      memos[index].key, memos[index]);
                                },
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {
                                    memoViewModel.toggleFavorite(
                                        memos[index].key, memos[index]);
                                  },
                                  icon: memos[index].isFavorite == true
                                      ? Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        )
                                      : Icon(
                                          Icons.star_border_outlined,
                                        ),
                                )),
                            Expanded(
                              flex: 8,
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
                    for (int i = 0; i < memos.length; i++) {
                      if (memos[i].isBoxChecked) {
                        memoViewModel.deleteMemo(memos[i].key);
                      }
                    }
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
