import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../model/memo.dart';

class DBHelper {
  static Box<Memo>? _memoBox;

  static Future<void> initializeHive() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(MemoAdapter());
  }

  static Future<void> openMemoBox() async {
    _memoBox = await Hive.openBox<Memo>('memos');
  }

  static Box<Memo>? get memoBox => _memoBox;

  // 메모 목록 가져오기
  static List<Memo> fetchMemos() {
    print(_memoBox?.values.toList());
    return _memoBox?.values.toList() ?? [];
  }

  // 메모 추가
  static void addMemo(Memo memo) {
    _memoBox?.add(memo);
  }
  static int getMemoIndex(Memo memo) {
    return _memoBox?.values.toList().indexOf(memo) ?? -1;
  }

  // 메모 업데이트
  static void updateMemo(int index, Memo updatedMemo) {
    if (_memoBox != null && index >=0 && index < _memoBox!.length) {
      final memoKey = _memoBox!.keyAt(index);
      if (memoKey != null) {
        _memoBox!.put(memoKey, updatedMemo);
      }
    }
  }
}
