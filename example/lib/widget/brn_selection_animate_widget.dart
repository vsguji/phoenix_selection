/*
 * @Author: lipeng 1162423147@qq.com
 * @Date: 2022-04-29 17:06:50
 * @LastEditors: lipeng 1162423147@qq.com
 * @LastEditTime: 2023-10-13 10:40:00
 * @FilePath: /phoenix_selection/example/lib/widget/brn_selection_animate_widget.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:phoenix_selection/phoenix_selection.dart';

class BrnSelectionAnimationWidget extends StatefulWidget {
  final SelectionListViewController controller;
  final Widget view;
  final int animationMilliseconds;

  const BrnSelectionAnimationWidget({
    Key? key,
    required this.controller,
    required this.view,
    this.animationMilliseconds = 100,
  }) : super(key: key);

  @override
  _BrnSelectionAnimationWidgetState createState() =>
      _BrnSelectionAnimationWidgetState();
}

class _BrnSelectionAnimationWidgetState
    extends State<BrnSelectionAnimationWidget>
    with SingleTickerProviderStateMixin {
  bool _isControllerDisposed = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onController);
    _animationController = AnimationController(
        duration: Duration(milliseconds: widget.animationMilliseconds),
        vsync: this);
  }

  dispose() {
    widget.controller.removeListener(_onController);
    _animationController.dispose();
    _isControllerDisposed = true;
    super.dispose();
  }

  _onController() {
    _showListViewWidget();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.duration =
        Duration(milliseconds: widget.animationMilliseconds);
    return _buildListViewWidget();
  }

  _showListViewWidget() {
    Animation<double> animation = Tween(
            begin: 0.0,
            end: MediaQuery.of(context).size.height -
                (widget.controller.listViewTop ?? 0))
        .animate(_animationController)
      ..addListener(() {
        //这行如果不写，没有动画效果
        setState(() {});
      });

    if (_isControllerDisposed) {
      return;
    }

    if (animation.status == AnimationStatus.completed) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  Widget _buildListViewWidget() {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      left: 0,
      child: Material(
        color: Color(0xB3000000),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              (widget.controller.listViewTop ?? 0),
          child: Padding(
            padding: EdgeInsets.all(0),
            child: widget.view,
          ),
        ),
      ),
    );
  }
}
