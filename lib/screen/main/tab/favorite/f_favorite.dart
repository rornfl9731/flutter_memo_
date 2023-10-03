import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/model/memo.dart';
import 'package:fast_app_base/screen/main/tab/home/w_add_memo.dart';
import 'package:fast_app_base/screen/main/tab/home/w_update_memo.dart';
import 'package:fast_app_base/viewmodel/memo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/widget/round_button_theme.dart';
import '../../../../common/widget/w_round_button.dart';

class FavoriteFragment extends StatefulWidget {
  final bool isShowBackButton;

  const FavoriteFragment({
    Key? key,
    this.isShowBackButton = true,
  }) : super(key: key);

  @override
  State<FavoriteFragment> createState() => _FavoriteFragmentState();
}

class _FavoriteFragmentState extends State<FavoriteFragment> {
  @override
  Widget build(BuildContext context) {
    final memoViewModel = Provider.of<MemoViewModel>(context);
    final memos = memoViewModel.favoriteMemos;
    print(memos.toList());

    return SafeArea(
      child: Column(
        children: [
          AppBar(title: Text("즐겨찾기"),automaticallyImplyLeading:false),
          Expanded(
            child: Container(
              child: (
                  memos.length == 0 ? Center(child: Text("메모가 없습니다."),) :
                  ListView.builder(
                    itemBuilder: (BuildContext context, index) {
                      DateTime memoDateTime = memos[index].createdDate;
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
                                flex: 6,
                                child: ListTile(
                                  title: Text(memos[index].title),
                                  subtitle: Text(memos[index].content),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                    '${memoDateTime.year}년 ${memoDateTime.month}월 ${memoDateTime.day}일'),
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
        ],
      ),
    );
  }
}
