import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/TabPage.dart';

class TabAndBackdropLayoutContent extends StatelessWidget {

  String title;
  Widget body;

  TabAndBackdropLayoutContent({this.title, this.body});

  // NOTE: TabAndBackdropLayout の content 属性として渡されたときに、onPressed がセットされる
  Function toggleBackdrop = () => {};

  void setToggleBackdrop(Function func) {
    toggleBackdrop = func;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              child: this.body,
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                elevation: 2.0,
                onPressed: toggleBackdrop,
                child: Icon(Icons.arrow_upward),
              ),
            )
          ],
        ),
      )
    );
  }
}

class TabAndBackdropLayout extends StatefulWidget {
  Map<int, TabPage> views;
  int defaultPage;
  TabAndBackdropLayout({this.views, this.defaultPage});

  @override
  State<StatefulWidget> createState() => TameshiState();
}

class TameshiState extends State<TabAndBackdropLayout> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  bool isBackdropOpened = false;
  bool isBackdropClosingAleaOpened = false;

  int page;

  @override
  void initState() {
    super.initState();

    this.page = widget.defaultPage;

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );

    for (var tabPage in widget.views.values) {
      if (tabPage.content is TabAndBackdropLayoutContent) {
        (tabPage.content as TabAndBackdropLayoutContent).setToggleBackdrop(
            () => toggleBackdrop()
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget buildContent(BuildContext context) {
    // TODO: ページ番号をバリデーション
    return MaterialApp(
      home: widget.views[this.page].content,
    );
  }

  List<Widget> buildButtons() {
    return widget.views.keys.map((page) =>
      Expanded(
        child: FlatButton(
          onPressed: () => setPage(page),
          child: widget.views[page].icon,
        ),
      )
    ).toList();
  }

  Widget buildButtonText() {
    var text;
    if (this.isBackdropOpened)
      text = Text("close");
    else
      text = Text("open");
    return text;
  }

  void setPage(int page) {
    setState(() {
      this.page = page;
    });
  }

  void toggleBackdrop() async {
    void open() {
      _controller.forward();
      this.isBackdropOpened = true;
      setState(() {
        this.isBackdropClosingAleaOpened = true;
      });
    }

    void close() {
      _controller.reverse();
      this.isBackdropOpened = false;

      _controller.addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {
            this.isBackdropClosingAleaOpened = false;
          });
        }
      });
    }

    if (this.isBackdropOpened) {
      await close();
    } else {
      await open();
    }
  }

  Widget buildBackdropOffArea(double screenHeight) {
    double top = screenHeight;
    if (this.isBackdropClosingAleaOpened) {
      top = 0;
    }

    return Positioned(
      top: top,
      left: 0,
      bottom: 0,
      right: 0,
      child: GestureDetector(
          onTap: () => toggleBackdrop(),
          child: Container(
            constraints: BoxConstraints.expand(),
            color: Colors.black12,
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final screenSize = constraints.biggest;
          double backdropTop = (screenSize.height - 160)/2;

          return Stack(
            children: [
              Container(
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: [
                    Expanded(
                        child: buildContent(context)
                    ),
                    Container(
                        constraints: BoxConstraints.expand(height: 90),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1.0,
                              blurRadius: 2.0
                            )
                          ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Row(
                            children: buildButtons(),
                          ),
                        )
                    )
                  ],
                ),
              ),
              buildBackdropOffArea(screenSize.height),
              PositionedTransition(
                rect: RelativeRectTween(
                  begin: RelativeRect.fromSize(
                      Rect.fromLTWH(0, screenSize.height, screenSize.width, 0),
                      screenSize
                  ),
                  end: RelativeRect.fromSize(
                      Rect.fromLTWH(0, backdropTop, screenSize.width, screenSize.height - backdropTop),
                      screenSize
                  ),
                ).animate(_animation),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20)
                    ),
                  ),
                )
              ),
            ],
          );
        }
    );
  }
}