import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/view_models/UserViewModel.dart';

import '../../view_models/MapViewModel.dart';

/**
 * 複数 ChangeNotifierProvider の管理下に MaterialApp を配置するためのレイアウトクラス
 */
class MultipleChangeNotifierProviderWrapper extends StatelessWidget {
  MaterialApp materialApp;

  MultipleChangeNotifierProviderWrapper({this.materialApp});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserViewModel>(
        create: (_) => UserViewModel(),
        child: ChangeNotifierProvider<MapViewModel>(
          create: (_) => MapViewModel()..fetchMarkers(),
          child: materialApp,
        ));
  }
}
