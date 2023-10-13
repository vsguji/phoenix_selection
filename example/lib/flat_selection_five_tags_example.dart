import 'package:flutter/material.dart';
import 'package:phoenix_base/phoenix.dart';
import 'package:phoenix_btn/phoenix_btn.dart';
import 'package:phoenix_navbar/phoenix_navbar.dart';
import 'package:phoenix_selection/extension/selection_assets.dart';
import 'package:phoenix_selection/phoenix_selection.dart';
import 'package:phoenix_toast/phoenix_toast.dart';

class NewSelectionViewExamplePage23 extends StatefulWidget {
  final String _title;
  final List<SelectionEntity> _filterData;

  NewSelectionViewExamplePage23(this._title, this._filterData);

  @override
  _SelectionViewExamplePageState createState() =>
      _SelectionViewExamplePageState();
}

class _SelectionViewExamplePageState
    extends State<NewSelectionViewExamplePage23> {
  SelectionEntity? entity;

  FlatSelectionController? controller;

  GlobalKey selectionKey = GlobalKey();

  bool _isShow = true;

  @override
  void initState() {
    super.initState();

    controller = FlatSelectionController();
  }

  @override
  void dispose() {
    controller!.dispose();
    controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PhoenixAppBar(title: widget._title),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: GestureDetector(
              child: const Text("点击关闭展开"),
              onTap: () {
                setState(() {
                  _isShow = !_isShow;
                });
              },
            ),
          ),
          _isShow
              ? Column(
                  children: <Widget>[
                    Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: 400,
                        child: FlatSelection(
                            preLineTagSize: 5,
                            entityDataList: widget._filterData,
                            confirmCallback: (data) {
                              var str = "";
                              data.forEach(
                                  (k, v) => str = str + " " + '$k: $v');
                              PhoenixToast.show(str, context);
                            },
                            controller: controller)),
                    _bottomWidget(),
                  ],
                )
              : Container(),
        ],
      )),
    );
  }

  Widget _bottomWidget() {
    return Column(
      children: <Widget>[
        const Divider(
          height: 0.3,
          color: Color(0xFFF0F0F0),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(8, 11, 20, 11),
          child: Row(
            children: <Widget>[
              InkWell(
                child: Container(
                  padding: const EdgeInsets.only(left: 12, right: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 24,
                        width: 24,
                        child: PhoenixTools.getAssetImage(
                            SelectionAssets.iconSelectionReset),
                      ),
                      const Text(
                        "重置",
                        style:
                            TextStyle(fontSize: 11, color: Color(0xFF999999)),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  if (controller != null) {
                    controller!.resetSelectedOptions();
                  }
                },
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  BigOutlineButton(
                      width: 104,
                      title: "取消",
                      onTap: () {
                        if (controller != null) {
                          controller!.cancelSelectedOptions();
                          setState(() {
                            _isShow = false;
                          });
                        }
                      }),
                  Container(
                    width: 20,
                  ),
                  BigMainButton(
                      width: 104,
                      title: "确定",
                      onTap: () {
                        if (controller != null) {
                          controller!.confirmSelectedOptions();
                          setState(() {
                            _isShow = false;
                          });
                        }
                      }),
                ],
              ))
            ],
          ),
        )
      ],
    );
  }
}
