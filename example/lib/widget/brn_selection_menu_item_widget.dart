/*
 * @Author: lipeng 1162423147@qq.com
 * @Date: 2022-04-29 17:06:50
 * @LastEditors: lipeng 1162423147@qq.com
 * @LastEditTime: 2023-10-13 10:46:34
 * @FilePath: /phoenix_selection/example/lib/widget/brn_selection_menu_item_widget.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:phoenix_base/phoenix.dart';
import 'package:phoenix_selection/extension/selection_assets.dart';
import 'package:phoenix_selection/phoenix_selection.dart' as phoenix;

// ignore: must_be_immutable
class BrnSelectionMenuItemWidget extends StatelessWidget {
  final String title;
  final bool isHighLight;
  final bool active;
  final VoidCallback? itemClickFunction;

  phoenix.SelectionConfig themeData;

  BrnSelectionMenuItemWidget(
      {Key? key,
      required this.title,
      this.isHighLight = false,
      this.active = false,
      this.itemClickFunction,
      required this.themeData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          _menuItemTapped();
        },
        child: Container(
          color: Colors.transparent,
          constraints: BoxConstraints.expand(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Flexible(
                child: Text(
                  this.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                  style: isHighLight
                      ? themeData.menuSelectedTextStyle.generateTextStyle()
                      : themeData.menuNormalTextStyle.generateTextStyle(),
                ),
              )),
              Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: isHighLight
                      ? (active
                          ? PhoenixTools.getAssetImageWithBandColor(
                              SelectionAssets.iconArrowUpSelect,
                              configId: themeData.configId)
                          : PhoenixTools.getAssetImageWithBandColor(
                              SelectionAssets.iconArrowDownSelect))
                      : (active
                          ? PhoenixTools.getAssetImageWithBandColor(
                              SelectionAssets.iconArrowUpSelect,
                              configId: themeData.configId)
                          : PhoenixTools.getAssetImage(
                              SelectionAssets.iconArrowDownUnSelect)))
            ],
          ),
        ),
      ),
    );
  }

  void _menuItemTapped() {
    if (this.itemClickFunction != null) {
      this.itemClickFunction!();
    }
  }
}
