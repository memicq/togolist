import 'package:cloud_firestore/cloud_firestore.dart';

class InquiryRepositoryFB {
  // for singleton
  static InquiryRepositoryFB _instance = InquiryRepositoryFB._internal();
  factory InquiryRepositoryFB() => _instance;
  InquiryRepositoryFB._internal();

  Future<void> saveInquiry(String title, String content) {
    Firestore.instance
        .collection('inquiries')
        .add({'title': title, 'content': content});
  }
}