import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:togolist/widgets/places/PlaceAdditionBackdrop.dart';

import '../../models/TabPage.dart';

class TabAndBackdropLayoutContent extends StatelessWidget {
  String title;
  Widget body;
  bool showFloatingButton;

  TabAndBackdropLayoutContent(
      {this.title, this.body, this.showFloatingButton = false})
      : assert(title != null),
        assert(body != null);

  // NOTE: TabAndBackdropLayout の content 属性として渡されたときに、onPressed がセットされる
  Function openRootBackdrop = () => {};

  void setOpenRootBackdrop(Function func) {
    openRootBackdrop = func;
  }

  Widget buildFloatingButton() {
    if (this.showFloatingButton) {
      return Positioned(
        right: 20,
        bottom: 20,
        child: FloatingActionButton(
          elevation: 2.0,
          onPressed: () => openRootBackdrop(),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: const [
                  Color(0xffffab88),
                  Color(0xffff7f50),
                ],
              ),
            ),
            child: Icon(Icons.add),
          )
//          Icon(Icons.add),
        ),
      );
    } else {
      return Container();
    }
  }

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
          body: Stack(
            children: [
              Container(
                constraints: BoxConstraints.expand(),
                child: this.body,
              ),
              buildFloatingButton()
            ],
          ),
        ));
  }
}

class TabAndBackdropLayout extends StatefulWidget {
  Map<int, TabPage> views;
  int defaultPage;

  TabAndBackdropLayout({this.views, this.defaultPage});

  @override
  State<StatefulWidget> createState() => TameshiState();
}

class TameshiState extends State<TabAndBackdropLayout> {
  int page;

  @override
  void initState() {
    super.initState();

    this.page = widget.defaultPage;

    for (var tabPage in widget.views.values) {
      if (tabPage.content is TabAndBackdropLayoutContent) {
        (tabPage.content as TabAndBackdropLayoutContent)
            .setOpenRootBackdrop(() => openBackdrop());
      }
    }
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

  void openBackdrop() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: this.context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SizedBox(
            height: 200,
            child: PlaceAdditionBackdrop(),
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
