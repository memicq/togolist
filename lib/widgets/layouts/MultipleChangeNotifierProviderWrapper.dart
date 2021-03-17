import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/view_models/UserViewModel.dart';

import '../../view_models/MapViewModel.dart';

/**
 * 複数 ChangeNotifierProvider の管理下に MaterialApp を配置するためのレイアウトクラス
 */
class MultipleChangeNotifierProviderWrapper extends StatelessWidget {
  Widget child;

  MultipleChangeNotifierProviderWrapper({this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserViewModel>(
        create: (_) => UserViewModel(),
        child: Consumer<UserViewModel>(builder: (context, model, _) {
          return ChangeNotifierProvider<MapViewModel>(
            create: (_) =>
            MapViewModel(),
            child: child,
          );
        })
    );
  }
}
