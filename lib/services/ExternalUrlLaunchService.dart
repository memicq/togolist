import 'package:url_launcher/url_launcher.dart';

class ExternalUrlLaunchService {
  static final ExternalUrlLaunchService _locationService = ExternalUrlLaunchService._internal();
  factory ExternalUrlLaunchService() =>  _locationService;
  ExternalUrlLaunchService._internal();

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
//        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      final Error error = ArgumentError('Could not launch $url');
      throw error;
    }
  }

  Future<void> launchPhone(String phoneNumber) {
    _launch('tel:' + phoneNumber);
  }

  Future<void> _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      final Error error = ArgumentError('Could not launch $url');
      throw error;
    }
  }
}