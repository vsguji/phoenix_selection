import 'package:flutter/material.dart';
import 'package:phoenix_base/phoenix.dart';

import '../config/selection_config.dart';
import '../extension/selection_assets.dart';

/// 筛选菜单项
// ignore: must_be_immutable
class BrnSelectionMenuItemWidget extends StatelessWidget {
  /// 菜单项标题
  final String title;

  /// 是否高亮
  final bool isHighLight;

  /// 是否选中
  final bool active;

  /// 点击事件
  final VoidCallback? itemClickFunction;

  /// 主题配置
  SelectionConfig themeData;

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
          constraints: const BoxConstraints.expand(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Flexible(
                child: Text(
                  title,
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
                  padding: const EdgeInsets.only(left: 4),
                  child: isHighLight
                      ? (active
                          ? PhoenixTools.getAssetImageWithBandColor(
                              SelectionAssets.iconArrowUpSelect,
                              package: 'phoenix_selection',
                              configId: themeData.configId)
                          : PhoenixTools.getAssetImageWithBandColor(
                              SelectionAssets.iconArrowDownSelect,
                              package: 'phoenix_selection'))
                      : (active
                          ? PhoenixTools.getAssetImageWithBandColor(
                              SelectionAssets.iconArrowUpSelect,
                              configId: themeData.configId,
                              package: 'phoenix_selection')
                          : PhoenixTools.getAssetImage(
                              SelectionAssets.iconArrowDownUnSelect,
                              package: 'phoenix_selection')))
            ],
          ),
        ),
      ),
    );
  }

  void _menuItemTapped() {
    if (itemClickFunction != null) {
      itemClickFunction!();
    }
  }
}
