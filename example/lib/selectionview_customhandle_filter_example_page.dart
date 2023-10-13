/*
 * @Author: lipeng 1162423147@qq.com
 * @Date: 2023-07-24 14:41:29
 * @LastEditors: lipeng 1162423147@qq.com
 * @LastEditTime: 2023-10-13 11:11:11
 * @FilePath: /phoenix_selection/example/lib/selectionview_customhandle_filter_example_page.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:phoenix_base/phoenix.dart';
import 'package:phoenix_dialog/phoenix_dialog.dart';
import 'package:phoenix_navbar/phoenix_navbar.dart';
import 'package:phoenix_selection/phoenix_selection.dart';

class SelectionViewCustomHandleFilterExamplePage extends StatefulWidget {
  final String _title;
  final List<SelectionEntity>? _filters;

  SelectionViewCustomHandleFilterExamplePage(this._title, this._filters);

  @override
  _SelectionViewExamplePageState createState() =>
      _SelectionViewExamplePageState();
}

class _SelectionViewExamplePageState
    extends State<SelectionViewCustomHandleFilterExamplePage> {
  int count = 0;

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
            SelectionView(
              originalSelectionData: widget._filters!,
              onCustomSelectionMenuClick: (int index,
                  SelectionEntity customMenuItem,
                  SetCustomSelectionParams customHandleCallBack) {
                /// 用户操作一段时间之后，将自定义参数回传，触发 onSelectionChanged回调。
                DialogManager.showConfirmDialog(context,
                    cancel: '取消',
                    confirm: '确定',
                    message: '点击确定，回传自定义参数到筛选', onConfirm: () {
                  count++;
                  customHandleCallBack({"CKey": "CValue" + '$count'});
                  Navigator.pop(context);
                }, onCancel: () {
                  Navigator.pop(context);
                });
              },
              onSelectionChanged: (int menuIndex,
                  Map<String, String> filterParams,
                  Map<String, String> customParams,
                  SetCustomSelectionMenuTitle setCustomTitleFunction) {
                if (menuIndex == 1) {
                  setCustomTitleFunction(
                      menuTitle: PhoenixTools.isEmpty(customParams)
                          ? ""
                          : customParams['CKey'] ?? "",
                      isMenuTitleHighLight:
                          !PhoenixTools.isEmpty(customParams['CKey']));
                }
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
