/*
 * @Author: lipeng 1162423147@qq.com
 * @Date: 2022-04-29 17:06:50
 * @LastEditors: lipeng 1162423147@qq.com
 * @LastEditTime: 2023-10-13 11:19:11
 * @FilePath: /phoenix_selection/example/lib/selectionview_simple_single_list_example_page.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:phoenix_navbar/phoenix_navbar.dart';
import 'package:phoenix_selection/phoenix_selection.dart';
import 'package:phoenix_toast/phoenix_toast.dart';

import 'filter_entity.dart';

class SelectionViewSimpleSingleListExamplePage extends StatefulWidget {
  final String _title;
  final BrnFilterEntity _filterData;

  SelectionViewSimpleSingleListExamplePage(this._title, this._filterData);

  @override
  _SelectionViewExamplePageState createState() =>
      _SelectionViewExamplePageState();
}

class _SelectionViewExamplePageState
    extends State<SelectionViewSimpleSingleListExamplePage> {
  List<SelectionEntity>? items;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PhoenixAppBar(title: widget._title),
        body: Column(
          children: <Widget>[
            SimpleSelection.radio(
              menuName: widget._filterData.name,
              menuKey: widget._filterData.key ?? 'defaultMenuKey',
              items: widget._filterData.children,
              defaultValue: widget._filterData.defaultValue,
              onSimpleSelectionChanged: (List<ItemEntity> filterParams) {
                PhoenixToast.show(
                    filterParams.map((e) => e.value).toList().join(','),
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
