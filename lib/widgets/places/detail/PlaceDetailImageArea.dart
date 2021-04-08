import 'package:flutter/material.dart';
import 'package:togolist/const/Credentials.dart';
import 'package:togolist/models/MapMarkerPhoto.dart';

class PlaceDetailImageArea extends StatefulWidget {
  List<MapMarkerPhoto> googlePhotos;

  PlaceDetailImageArea({this.googlePhotos});

  @override
  State<StatefulWidget> createState() => PlaceDetailImageAreaState();
}

class PlaceDetailImageAreaState extends State<PlaceDetailImageArea> {
  bool isFetchingImages;
  List<Image> images = List();

  @override
  void initState() {
    super.initState();
    this.setFetchingImages(true);
    Future(() async {
      this.images = await fetchImages();
      this.setFetchingImages(false);
    });
  }

  void setFetchingImages(bool updated) {
    setState(() {
      this.isFetchingImages = updated;
    });
  }

  Future<List<Image>> fetchImages() async {
    return widget.googlePhotos.map((photo) {
      return Image.network("https://maps.googleapis.com/maps/api/place/photo"
          "?maxheight=200"
          "&photoreference=${photo.photoReference}"
          "&key=${Credentials.googleApiKeyIOS}");
    }).toList();
  }

  List<Widget> buildImages() {
    List<Widget> images = this.images.map((image) {
      return Container(
        padding: EdgeInsets.only(left: 10),
        child: image,
      );
    }).toList();
    return images;
  }

  Widget buildListView() {
    if (this.isFetchingImages) {
      return Center(
        child: Text("読み込み中"),
      );
    } else {
      return
        NotificationListener<ScrollNotification>(
          onNotification: (notification) => true,
          child:
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: buildImages()),
          )
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      height: 200,
      width: double.infinity,
      color: Colors.white,
      child: buildListView(),
    );
  }
}
