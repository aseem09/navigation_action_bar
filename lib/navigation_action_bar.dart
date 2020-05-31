library navigation_action_bar;

import 'package:flutter/material.dart';
import 'src/item.dart';
import 'src/painter.dart';

class NavigationActionBar extends StatefulWidget {
  final BuildContext context;
  final List<NavBarItem> items;
  final int index;
  final int mainIndex;
  final double subItemSpacing;
  final Color accentColor;
  final Color backgroundColor;
  final Color scaffoldColor;
  final Duration animationDuration;
  final Curve animationCurve;
  final ValueChanged<double> onTap;
  final List<NavBarItem> subItems;

  NavigationActionBar({
    Key key,
    @required this.items,
    @required this.mainIndex,
    @required this.subItems,
    this.index = 0,
    this.accentColor = Colors.redAccent,
    this.backgroundColor = Colors.white,
    this.scaffoldColor = Colors.blueAccent,
    this.onTap,
    this.animationDuration = const Duration(milliseconds: 300),
    this.context,
    this.subItemSpacing = 150,
    this.animationCurve = Curves.bounceOut,
  })  : assert(context != null),
        assert(items != null),
        assert(mainIndex != null),
        assert(items.length >= 1),
        assert(0 <= index && index < items.length),
        assert(0 <= mainIndex && mainIndex < items.length),
        super(key: key);

  @override
  NavigationActionBarState createState() => NavigationActionBarState();
}

class NavigationActionBarState extends State<NavigationActionBar>
    with SingleTickerProviderStateMixin {
  double height = 70;
  int selectedIndex;
  AnimationController controller;
  Animation<double> translation;
  double position;
  int length;
  OverlayEntry _overlayEntry;
  bool _overlayTrue = false;

//  double splitAngle;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: widget.animationDuration);

    length = widget.items.length;
    position = widget.mainIndex / length;

//    if (widget.subItems != null) {
//      splitAngle = 180 / (widget.subItems.length + 1);
//    }

    translation = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    );
    selectedIndex = widget.index;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _insertOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(builder: (context) {
      double mid = widget.subItems.length / 2;
      if (widget.subItems.length % 2 == 1) {
        mid = mid.floorToDouble();
      } else {
        mid = mid - 0.5;
        print("sad" + mid.toString());
      }
      return Container(
        height: 100,
        width: 100,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: widget.subItems.reversed.map((item) {
              int index = widget.subItems.indexOf(item);
              return Positioned(
                bottom: 100,
                left: 0 +
                    ((index > mid) ? (index - mid) * widget.subItemSpacing : 0)
                        .toDouble(),
                right: 0 +
                    ((index < mid) ? (mid - index) * widget.subItemSpacing : 0)
                        .toDouble(),
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: controller,
                    curve: Interval(
                      0 + ((1 / length) * (index)),
                      1.0 - index / widget.subItems.length / 4,
                      curve: Curves.easeInCubic,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _overlayTrue = false;
                        controller.reverse();
                      });
                    },
                    child: ActionBarItem(
                      onTap: _buttonTap,
                      iconData: item.iconData,
                      size: item.size,
                      mainIndex: widget.mainIndex,
                      index: index,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
    Overlay.of(context).insert(_overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: widget.scaffoldColor,
        border: Border.all(width: 0, color: widget.scaffoldColor),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            bottom: -10,
            child: CustomPaint(
              painter: Painter(
                position,
                length,
                widget.backgroundColor,
                Directionality.of(context),
              ),
              child: Container(
                height: height,
              ),
            ),
          ),
          SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.items.map((item) {
                int index = widget.items.indexOf(item);
                if (index == widget.mainIndex) {
                  return SpecialBarItem(
                    animationController: controller,
                    iconData: item.iconData,
                    size: item.size,
                    index: index,
                    onTap: _buttonTap,
                    color: widget.accentColor,
                  );
                } else {
                  return BarItem(
                    index: index,
                    onTap: _buttonTap,
                    iconData: item.iconData,
                    size: item.size,
                    selected: item.selectedColor,
                    unselected: item.unselectedColor,
                    currentIndex: selectedIndex,
                  );
                }
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _buttonTap(double index) {
    if (widget.onTap != null) {
      widget.onTap(index);
      setState(() {
        selectedIndex = index.floor();
      });
      _handleOverlay(index);
    }
    print(index);
  }

  void _handleOverlay(double index) {
    if (index == widget.mainIndex) {
      if (_overlayTrue) {
        _removeOverlay();
      } else {
        _addOverlay();
      }
    } else {
      if (_overlayTrue) {
        _removeOverlay();
      }
    }
  }

  void _removeOverlay() {
    controller.reverse();
    Future.delayed(widget.animationDuration)
        .then((value) => _overlayEntry.remove());
    _overlayTrue = !_overlayTrue;
  }

  void _addOverlay() {
    _insertOverlay(widget.context);
    controller.forward();
    _overlayTrue = !_overlayTrue;
  }
}

class NavBarItem {
  final IconData iconData;
  final double size;
  final Color selectedColor;
  final Color unselectedColor;

  NavBarItem({
    this.iconData,
    this.size,
    this.selectedColor = Colors.redAccent,
    this.unselectedColor = Colors.black,
  });
}
