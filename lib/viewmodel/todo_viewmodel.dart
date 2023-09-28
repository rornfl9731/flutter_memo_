import 'package:fast_app_base/model/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ToDoViewModel extends ChangeNotifier {
  late Box<ToDo> _todoBox;

  List<ToDo> _todos = [];
  List<ToDo> _s_todos = [];

  List<ToDo> get todos => _todos;
  List<ToDo> get stodos => _s_todos;

  ToDoViewModel() {
    _openToDoBox();
  }

  static Future<void> initializeHive() async {
    final appDocumentDir =
    await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(ToDoAdapter());

  }

  Future<void> _openToDoBox() async {
    await Hive.openBox<ToDo>('todos');
    _todoBox = Hive.box<ToDo>('todos');

    await _loadToDos();
  }

  Future<void> _loadToDos() async {
    final ToDoList = await _todoBox.values.toList();
    final succeedToDoList = await _todoBox.values
        .where((element) => element.isSucceed == true)
        .toList();

    _todos = ToDoList;
    _s_todos = succeedToDoList;

    notifyListeners();
  }

  Future<void> addToDo(ToDo todo) async {
    await _todoBox.add(todo);

    await _loadToDos();

    notifyListeners();
  }

  Future<void> toggleFavorite(int key, ToDo todo) async {
    ToDo s_toDo = ToDo(
      title: todo.title,
      content: todo.content,
      createdDate: todo.createdDate,
      isSucceed: !todo.isSucceed,
    );

    await _todoBox.put(key, s_toDo);
    await _loadToDos();
    notifyListeners();
  }

  Future<void> deleteToDo(int key) async {
    await _todoBox.delete(key);

    await _loadToDos();

    notifyListeners();
  }

  Future<void> updateToDo(int key, ToDo updateToDo) async {
    await _todoBox.put(key, updateToDo);

    await _loadToDos();

    notifyListeners();
  }

  Future<void> toggleBoxChecked(int key, ToDo todo) async {
    ToDo bc_todo = ToDo(
        title: todo.title,
        content: todo.content,
        createdDate: todo.createdDate,
        isBoxChecked: !todo.isBoxChecked);

    await _todoBox.put(key, bc_todo);
    await _loadToDos();
    notifyListeners();
  }

  Future<void> boxCheckedDelete(List<ToDo> checkedToDo) async {

    for(int i=0;i<checkedToDo.length;i++){
      await _todoBox.delete(checkedToDo[i].key);
    }

    await _loadToDos();
    notifyListeners();

  }

}
