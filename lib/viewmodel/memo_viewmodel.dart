import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/memo.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class MemoViewModel extends ChangeNotifier {
  //얘도 따라서
  late Box<Memo> _memoBox;

  List<Memo> _memos = [];
  List<Memo> _f_Memos = [];
  List<Memo> _bc_Memos = [];

  List<Memo> get favoriteMemos => _f_Memos;
  List<Memo> get memos => _memos;
  List<Memo> get boxCheckedMemos => _bc_Memos;

  // 얘도 따라써
  MemoViewModel() {
    _openMemoBox();
  }

  // 그냥 따라쓰면 됨 여기에 함수 선언하고, main에 부르면 됨
  static Future<void> initializeHive() async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(MemoAdapter());
  }

// 얘도 그냥 따라써
  Future<void> _openMemoBox() async {
    await Hive.openBox<Memo>('memos');
    _memoBox = Hive.box<Memo>('memos');

    await _loadMemos();
  }

// 얘도 그냥 따라써
  Future<void> _loadMemos() async {
    final memoList = await _memoBox.values.toList();
    final favoriteMemoList = await _memoBox.values
        .where((element) => element.isFavorite == true)
        .toList();
    final boxCheckedMemoList = await _memoBox.values
        .where((element) => element.isBoxChecked == true)
        .toList();
    // 날짜 역순으로 정렬
    // final firestore = FirebaseFirestore.instance;
    // final snapshot = await firestore.collection('memo').get();
    // final docs = snapshot.docs;
    // docs.forEach((doc) {
    //   print(doc['title']);
    //   print(doc['content']);
    //   print(doc['createdDate']);
    //   print(doc['isFavorite']);
    // });

    _memos = memoList;
    _f_Memos = favoriteMemoList;
    _bc_Memos = boxCheckedMemoList;

    notifyListeners();
  }

  Future<void> addMemo(Memo memo) async {
    await _memoBox.add(memo);

    await _loadMemos();

    notifyListeners();
  }

  Future<void> updateMemo(int key, Memo updateMemo) async {
    await _memoBox.put(key, updateMemo);

    await _loadMemos();

    notifyListeners();
  }

  Future<void> deleteMemo(int key) async {
    await _memoBox.delete(key);

    await _loadMemos();

    notifyListeners();
  }

  Future<void> toggleFavorite(int key, Memo memo) async {
    Memo f_memo = Memo(
        title: memo.title,
        content: memo.content,
        createdDate: memo.createdDate,
        isFavorite: !memo.isFavorite);

    await _memoBox.put(key, f_memo);
    await _loadMemos();
    notifyListeners();
  }

  Future<void> toggleBoxChecked(int key, Memo memo) async {
    Memo bc_memo = Memo(
        title: memo.title,
        content: memo.content,
        createdDate: memo.createdDate,
        isBoxChecked: !memo.isBoxChecked);

    await _memoBox.put(key, bc_memo);
    await _loadMemos();
    notifyListeners();
  }

  Future<void> boxCheckedDelete(int key, Memo memo) async {

    if(memo.isBoxChecked) {
      _memoBox.delete(key);
    }
    await _loadMemos();
    notifyListeners();

  }

  Future<void> backBoxCheckedDelete(int key, Memo memo) async {

    Memo b_memo = Memo(
        title: memo.title,
        content: memo.content,
        createdDate: memo.createdDate,
        isBoxChecked: false);

    _memoBox.put(key, b_memo);

    await _loadMemos();
    notifyListeners();

  }

  Future<void> allSelectBoxCheckedDelete(int key, Memo memo) async {

    Memo b_memo = Memo(
        title: memo.title,
        content: memo.content,
        createdDate: memo.createdDate,
        isBoxChecked: true);

    _memoBox.put(key, b_memo);

    await _loadMemos();
    notifyListeners();

  }

  // Future<void> firebase_add_memo(Memo memo)async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   await firestore.collection('memo').add({
  //     'title': memo.title,
  //     'content': memo.content,
  //     'createdDate': DateTime.now(),
  //     'isFavorite': false,
  //   });
  //
  //
  // }
}
