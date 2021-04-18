import 'package:togolist/models/TabPage.dart';

class GlobalTabService {
  static final GlobalTabService _locationService = GlobalTabService._internal();
  factory GlobalTabService() =>  _locationService;
  GlobalTabService._internal();

  Map<int, TabPage> views;

  // TODO(kamiura): 途中
}