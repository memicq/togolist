import 'dart:convert';
import 'dart:io';

import 'package:togolist/const/Credentials.dart';

// https://developers.facebook.com/docs/instagram-api/reference/ig-hashtag-search

class InstagramGraphRepositoryApi {
  // for singleton
  static InstagramGraphRepositoryApi _instance = InstagramGraphRepositoryApi._internal();
  factory InstagramGraphRepositoryApi() => _instance;
  InstagramGraphRepositoryApi._internal();

  Future<List<String>> getInstagramHashTagIds(String tagName) async {
    String url = "https://graph.facebook.com/v10.0/ig_hashtag_search"
        "?user_id=${Credentials.instagramBusinessAccountId}"
        "&q=${tagName.replaceAll(' ', '')}"
        "&access_token=${Credentials.instagramGraphAccessToken}";
    HttpClientRequest request = await HttpClient().getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    String responseBodyText = await utf8.decodeStream(response);

    Map<String, dynamic> content = json.decode(responseBodyText);
    List<dynamic> tagIds = content['data'].map((t) => t['id']).toList();
    return List<String>.from(tagIds);
  }

  Future<void> getInstagramMediaFromTagId(String tagId) async {
    String url = "https://graph.facebook.com/${tagId}/top_media"
        "?user_id=${Credentials.instagramBusinessAccountId}"
        "&access_token=${Credentials.instagramGraphAccessToken}"
        "&fields=id,media_type,media_url";
    HttpClientRequest request = await HttpClient().getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    String responseBodyText = await utf8.decodeStream(response);

    Map<String, dynamic> content = json.decode(responseBodyText);
    print(content['data'].where((post) => post['media_url'] != null));

  }
}