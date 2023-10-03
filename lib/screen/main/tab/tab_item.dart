import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/favorite/f_favorite.dart';
import 'package:fast_app_base/screen/main/tab/home/f_home.dart';
import 'package:fast_app_base/screen/main/tab/todo/f_todo.dart';
import 'package:flutter/material.dart';

import 'memo/f_memo.dart';

enum TabItem {
  home(Icons.message, '메모', MemoFragment()),
  favorite(Icons.star, '즐겨찾기', FavoriteFragment(isShowBackButton: false)),
  add(Icons.light_mode, 'To-Do', ToDoFragment());



  final IconData activeIcon;
  final IconData inActiveIcon;
  final String tabName;
  final Widget firstPage;

  const TabItem(this.activeIcon, this.tabName, this.firstPage, {IconData? inActiveIcon})
      : inActiveIcon = inActiveIcon ?? activeIcon;

  BottomNavigationBarItem toNavigationBarItem(BuildContext context, {required bool isActivated}) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(tabName),
          isActivated ? activeIcon : inActiveIcon,
          color:
              isActivated ? context.appColors.iconButton : context.appColors.iconButtonInactivate,
        ),
        label: tabName);
  }
}
