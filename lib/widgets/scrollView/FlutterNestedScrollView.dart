import 'package:flutter/material.dart';
import 'dart:math' as math;

//const NestedScrollView({
//Key key,
//this.controller,
//this.scrollDirection = Axis.vertical,
//this.reverse = false,
//this.physics,
//@required List<Widget> Function(BuildContext context, bool innerBoxIsScrolled) this.headerSliverBuilder,
//@required this.body,
//})
//实现搜索框隐藏，TabBar切换悬浮吸顶。主要使用自定义_SliverAppBarDelegate
class FlutterNestedScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
                pinned: false,
                delegate: _SliverAppBarDelegate(
                    maxHeight: 60.0,
                    minHeight: 60.0,
                    child: Container(
                      child: _buildSearch(),
                    ))),
            SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                    maxHeight: 49.0,
                    minHeight: 49.0,
                    child: Container(
                      color: Colors.white,
                      child: FlutterTabBar(),
                    )))
          ];
        },
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Text("fjwoijefoi$index");
          },
          itemCount: 100,
        ),
      )),
    );
  }
}

class FlutterTabBar extends StatefulWidget {
  FlutterTabBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FlutterTabBarState();
  }
}

class _FlutterTabBarState extends State<FlutterTabBar>
    with SingleTickerProviderStateMixin {
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;
  var titleList = ['电影', '电视', '综艺', '读书', '音乐', '同城'];

  List<Widget> tabList;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    selectColor = Color.fromARGB(255, 45, 45, 45);
    unselectedColor = Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 18, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 18, color: selectColor);
    tabList = getTabList();
    _tabController = TabController(vsync: this, length: tabList.length);
  }

  List<Widget> getTabList() {
    return titleList
        .map((item) => Text(
              '$item',
              style: TextStyle(fontSize: 18),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    //Tab小部件列表
//    List<Widget>  @required this.tabs,
    //组件选中以及动画的状态
//   TabController this.controller,
    //Tab是否可滑动
//  bool  this.isScrollable = false,
    //选项卡下方的导航条的颜色
//   Color this.indicatorColor,
    //选项卡下方的导航条的线条粗细
//   double this.indicatorWeight = 2.0,
//  EdgeInsetsGeometry  this.indicatorPadding = EdgeInsets.zero,
//   Decoration this.indicator,
//   TabBarIndicatorSize this.indicatorSize,导航条的长度，（tab：默认等分；label：跟标签长度一致）
//  Color  this.labelColor,所选标签标签的颜色
//  TextStyle  this.labelStyle,所选标签标签的文本样式
//  EdgeInsetsGeometry  this.labelPadding,,所选标签标签的内边距
// Color   this.unselectedLabelColor,未选定标签标签的颜色
//  TextStyle  this.unselectedLabelStyle,未选中标签标签的文字样式
//   void Function(T value) this.onTap,按下时的响应事件

    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TabBar(
        tabs: tabList,
        isScrollable: true,
        controller: _tabController,
        indicatorColor: selectColor,
        labelColor: selectColor,
        labelStyle: selectStyle,
        unselectedLabelColor: unselectedColor,
        unselectedLabelStyle: unselectedStyle,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
}

Widget _buildSearch() {
  return Card(
    margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
    elevation: 1.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
    ),
    child: Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      height: 45.0,
      child: Center(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.search,
                color: Colors.black26,
                size: 20.0,
              ),
            ),
            Expanded(
                child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search category',
                  hintStyle: TextStyle(color: Colors.black26)),
              cursorColor: Colors.pink,
            ))
          ],
        ),
      ),
    ),
  );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
