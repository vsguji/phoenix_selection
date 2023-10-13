/*
 * @Author: lipeng 1162423147@qq.com
 * @Date: 2022-04-29 17:06:50
 * @LastEditors: lipeng 1162423147@qq.com
 * @LastEditTime: 2023-10-13 11:14:07
 * @FilePath: /phoenix_selection/example/lib/selectionview_date_filter_example_page.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:phoenix_navbar/phoenix_navbar.dart';
import 'package:phoenix_selection/phoenix_selection.dart';
import 'package:phoenix_toast/phoenix_toast.dart';

class SelectionViewDateFilterExamplePage extends StatefulWidget {
  final String _title;
  final List<SelectionEntity> _filters;

  SelectionViewDateFilterExamplePage(this._title, this._filters);

  @override
  _SelectionViewExamplePageState createState() =>
      _SelectionViewExamplePageState(_filters);
}

class _SelectionViewExamplePageState
    extends State<SelectionViewDateFilterExamplePage> {
  late List<SelectionEntity> _filterData;

  _SelectionViewExamplePageState(List<SelectionEntity> filters) {
    _filterData = filters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PhoenixAppBar(title: widget._title),
        body: Column(
          children: <Widget>[
            SelectionView(
              originalSelectionData: _filterData,
              onCustomSelectionMenuClick: (int index,
                  SelectionEntity customMenuItem,
                  SetCustomSelectionParams customHandleCallBack) {
                customHandleCallBack({"customKey": "customValue"});
              },
              onMoreSelectionMenuClick: (int index, OpenMorePage openMorePage) {
                openMorePage(
                    updateData: false, moreSelections: widget._filters);
              },
              onSelectionChanged: (int menuIndex,
                  Map<String, String> filterParams,
                  Map<String, String> customParams,
                  SetCustomSelectionMenuTitle setCustomTitleFunction) {
                PhoenixToast.show(
                    'filterParams : $filterParams' +
                        ',\n customParams : $customParams',
                    context);
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 400),
              alignment: Alignment.center,
              child: Text("背景内容区域"),
            )
          ],
        ));
  }
}
