import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BarItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final ValueChanged<double> onTap;
  final IconData iconData;
  final double size;
  final Color selected;
  final Color unselected;

  const BarItem({
    Key key,
    this.index,
    this.onTap,
    this.iconData,
    this.size,
    this.selected,
    this.unselected,
    this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap(index.toDouble());
      },
      child: Container(
        child: Icon(
          iconData,
          size: size,
          color: (currentIndex == index) ? selected : unselected,
        ),
      ),
    );
  }
}

class SpecialBarItem extends StatefulWidget {
  final int index;
  final ValueChanged<double> onTap;
  final Duration duration;
  final IconData iconData;
  final double size;
  final Color color;
  final AnimationController animationController;

  const SpecialBarItem({
    Key key,
    this.color,
    this.duration,
    this.onTap,
    this.index,
    this.animationController,
    this.iconData,
    this.size,
  }) : super(key: key);

  @override
  _SpecialBarItemState createState() => _SpecialBarItemState();
}

class _SpecialBarItemState extends State<SpecialBarItem>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = widget.animationController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.onTap(widget.index.toDouble());
        switch (controller.status) {
          case AnimationStatus.completed:
            controller.reverse();
            break;
          case AnimationStatus.dismissed:
            controller.forward();
            break;
          default:
        }
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.all(5),
          child: RotationTransition(
            child: Icon(
              widget.iconData,
              size: widget.size,
            ),
            turns: Tween(begin: 0.0, end: 3 / 8).animate(controller),
          ),
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class ActionBarItem extends StatelessWidget {
  final int index;
  final int mainIndex;
  final ValueChanged<double> onTap;
  final IconData iconData;
  final double size;

  const ActionBarItem({
    Key key,
    this.index,
    this.onTap,
    this.mainIndex,
    this.iconData,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          String str = mainIndex.toString() + "." + index.toString();
          onTap(double.parse(str));
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconData,
            size: size,
          ),
        ),
      ),
    );
  }
}
