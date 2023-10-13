/*
 * @Author: lipeng 1162423147@qq.com
 * @Date: 2022-04-29 17:06:50
 * @LastEditors: lipeng 1162423147@qq.com
 * @LastEditTime: 2023-10-13 11:16:15
 * @FilePath: /phoenix_selection/example/lib/selectionview_limit_max_selected_count_example.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:phoenix_navbar/phoenix_navbar.dart';
import 'package:phoenix_selection/phoenix_selection.dart';
import 'package:phoenix_toast/phoenix_toast.dart';

class SelectionViewLimitMaxSelectedCountExamplePage extends StatefulWidget {
  final String _title;
  final List<SelectionEntity> _filterData;

  SelectionViewLimitMaxSelectedCountExamplePage(this._title, this._filterData);

  @override
  _SelectionViewExamplePageState createState() =>
      _SelectionViewExamplePageState();
}

class _SelectionViewExamplePageState
    extends State<SelectionViewLimitMaxSelectedCountExamplePage> {
  List<SelectionEntity>? items;

  BrnSelectionViewController? controller;

  @override
  void initState() {
    super.initState();

    controller = BrnSelectionViewController();
  }

  @override
  void dispose() {
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
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: GestureDetector(
              child: Text("点击关闭弹窗"),
              onTap: () {
                controller!.closeSelectionView();
              },
            ),
          ),
          SelectionView(
            selectionViewController: controller,
            originalSelectionData: widget._filterData,
            onSelectionChanged: (int menuIndex,
                Map<String, String> filterParams,
                Map<String, String> customParams,
                SetCustomSelectionMenuTitle setCustomTitleFunction) {
              PhoenixToast.show(
                  'filterParams : $filterParams' +
                      ',\n customParams : $customParams',
                  context);
            },
            onMenuClickInterceptor: (index) {
              if (index == 4) {
                PhoenixToast.show('第$index个被拦截了', context);
                return true;
              } else {
                return false;
              }
            },
            onSelectionPreShow: (int index, SelectionEntity entity) {
              if (entity.key == "role" || entity.key == "guidePrice") {
                return SelectionWindowType.range;
              }
              return entity.filterShowType!;
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 300),
            alignment: Alignment.center,
            child: Text("背景内容区域"),
          ),
        ],
      )),
    );
  }
}
