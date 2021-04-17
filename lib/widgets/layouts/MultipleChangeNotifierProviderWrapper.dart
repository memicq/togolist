import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togolist/view_models/LocationViewModel.dart';
import 'package:togolist/view_models/PlaceViewModel.dart';
import 'package:togolist/view_models/StationViewModel.dart';
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
          return ChangeNotifierProvider<StationViewModel>(
              create: (_) => StationViewModel()..fetchStations(),
          child: ChangeNotifierProvider<MapViewModel>(
              create: (_) => MapViewModel(),
              child: ChangeNotifierProvider<PlaceViewModel>(
                  create: (_) => PlaceViewModel(),
                  child: ChangeNotifierProvider<LocationViewModel>(
                      create: (_) => LocationViewModel(),
                      child: child
                  )
              )
          ));
        })
    );
  }
}
