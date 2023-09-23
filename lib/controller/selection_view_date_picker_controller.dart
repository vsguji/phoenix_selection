/*
 * @Author: lipeng 1162423147@qq.com
 * @Date: 2023-09-13 20:09:03
 * @LastEditors: lipeng 1162423147@qq.com
 * @LastEditTime: 2023-09-23 20:21:07
 * @FilePath: /phoenix_selection/lib/controller/selection_view_date_picker_controller.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';

/// 日期选择器动画控制器
class SelectionDatePickerController extends ChangeNotifier {
  /// 是否显示下拉筛选列表
  bool isShow;

  /// OverlayEntry 用于展示隐藏子组件
  OverlayEntry? entry;

  SelectionDatePickerController({
    this.isShow = false,
    this.entry,
  });

  void show() {
    isShow = true;
  }

  void hide() {
    isShow = false;
    entry?.remove();
    entry = null;
  }
}
