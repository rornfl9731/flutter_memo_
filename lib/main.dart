import 'package:easy_localization/easy_localization.dart';
import 'package:fast_app_base/common/dbHelper.dart';
import 'package:fast_app_base/model/memo.dart';
import 'package:fast_app_base/viewmodel/memo_viewmodel.dart';
import 'package:fast_app_base/viewmodel/todo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'common/data/preference/app_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await MemoViewModel.initializeHive();
  await ToDoViewModel.initializeHive();
  await EasyLocalization.ensureInitialized();
  await AppPreferences.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => MemoViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => ToDoViewModel(),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}
