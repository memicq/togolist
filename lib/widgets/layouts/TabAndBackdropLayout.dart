import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:togolist/services/BackdropService.dart';
import 'package:togolist/widgets/common/GradatedIconButton.dart';
import 'package:togolist/widgets/places/PlaceAdditionBackdrop.dart';

import '../../models/TabPage.dart';

class TabAndBackdropLayoutContent extends StatelessWidget {
  String title;
  Widget body;

  TabAndBackdropLayoutContent(
      {this.title, this.body})
      : assert(title != null),
        assert(body != null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.grey.shade50
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(
                this.title,
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20
                )
            ),
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            child: this.body,
          ),
        ));
  }
}

class TabAndBackdropLayout extends StatefulWidget {
  Map<int, TabPage> views;
  int defaultPage;

  TabAndBackdropLayout({this.views, this.defaultPage});

  @override
  State<StatefulWidget> createState() => TabAndBackdropLayoutState();
}

class TabAndBackdropLayoutState extends State<TabAndBackdropLayout> {
  int page;

  BackdropService backdropService = BackdropService();

  @override
  void initState() {
    super.initState();

    this.page = widget.defaultPage;
    this.backdropService.setOpenBackdropFunction(openBackdrop);
  }

  Widget buildContent(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Quicksand',
      ),
      home: widget.views[this.page].content,
    );
  }

  List<Widget> buildButtons() {
    return widget.views.keys.map((page) {

      Icon icon;
      if (page == this.page)
        icon = widget.views[page].activeIcon;
      else
        icon = widget.views[page].baseIcon;

      return Expanded(
        child: FlatButton(
          onPressed: () => setPage(page),
          child: icon,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
      );
    }).toList();
  }

  void setPage(int page) {
    setState(() {
      this.page = page;
    });
  }

  void openBackdrop({Widget page, double height}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: this.context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SizedBox(
            height: height,
            child: page,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          Expanded(child: buildContent(context)),
          Container(
              constraints: BoxConstraints.expand(height: 90),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 1.0, blurRadius: 1.0)
              ]),
              child: Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Row(
                  children: buildButtons(),
                ),
              ))
        ],
      ),
    );
  }
}
