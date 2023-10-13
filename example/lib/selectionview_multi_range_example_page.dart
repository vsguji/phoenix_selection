import 'package:flutter/material.dart';
import 'package:phoenix_navbar/phoenix_navbar.dart';
import 'package:phoenix_selection/phoenix_selection.dart';
import 'package:phoenix_toast/phoenix_toast.dart';

class SelectionViewMultiRangeExamplePage extends StatefulWidget {
  final String _title;
  final List<SelectionEntity>? _filters;

  SelectionViewMultiRangeExamplePage(this._title, this._filters);

  @override
  _SelectionViewExamplePageState createState() =>
      _SelectionViewExamplePageState();
}

class _SelectionViewExamplePageState
    extends State<SelectionViewMultiRangeExamplePage> {
  List<String>? titles;

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
              onSelectionChanged: (int menuIndex,
                  Map<String, String> filterParams,
                  Map<String, String> customParams,
                  SetCustomSelectionMenuTitle setCustomTitleFunction) {
                PhoenixToast.show(filterParams.toString(), context);
              },
              onSelectionPreShow: (int index, SelectionEntity entity) {
                if (entity.key == "one_range_key" ||
                    entity.key == "two_range_key") {
                  return SelectionWindowType.range;
                }
                return entity.filterShowType!;
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
