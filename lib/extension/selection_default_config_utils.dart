/*
 * @Author: lipeng 1162423147@qq.com
 * @Date: 2023-09-23 17:16:53
 * @LastEditors: lipeng 1162423147@qq.com
 * @LastEditTime: 2023-09-23 20:21:38
 * @FilePath: /phoenix_selection/lib/extension/selection_default_config_utils.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:phoenix_base/phoenix.dart';

import '../config/selection_config.dart';

/// 筛选项配置
extension BaseSelectionConfigUtils on BaseDefaultConfigUtils {
  //
  static SelectionConfig defaultSelectionConfig = SelectionConfig(
    menuNormalTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.colorTextBase,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeBase,
    ),
    menuSelectedTextStyle: BaseTextStyle(
      fontWeight: FontWeight.w600,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeBase,
      color: BaseDefaultConfigUtils.defaultCommonConfig.brandPrimary,
    ),
    tagNormalTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.colorTextBase,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeCaption,
    ),
    tagSelectedTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.brandPrimary,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeCaption,
      fontWeight: FontWeight.w600,
    ),
    tagRadius: BaseDefaultConfigUtils.defaultCommonConfig.radiusSm,
    tagNormalBackgroundColor:
        BaseDefaultConfigUtils.defaultCommonConfig.fillBody,
    tagSelectedBackgroundColor: BaseDefaultConfigUtils
        .defaultCommonConfig.brandPrimary
        .withOpacity(0.12),
    rangeTitleTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.colorTextBase,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
    ),
    hintTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.colorTextHint,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeBase,
    ),
    inputTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.colorTextBase,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeBase,
    ),
    itemNormalTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.colorTextBase,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeBase,
    ),
    itemSelectedTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.brandPrimary,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeBase,
      fontWeight: FontWeight.w600,
    ),
    itemBoldTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.colorTextBase,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeBase,
      fontWeight: FontWeight.w600,
    ),
    lightSelectBgColor: Colors.white,
    lightNormalBgColor: Colors.white,
    middleSelectBgColor: Colors.white,
    middleNormalBgColor: const Color(0xFFF8F8F8),
    deepSelectBgColor: const Color(0xFFF8F8F8),
    deepNormalBgColor: const Color(0xFFF0F0F0),
    resetTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.colorTextImportant,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeCaption,
    ),
    titleForMoreTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.colorTextBase,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeBase,
      fontWeight: FontWeight.w600,
    ),
    optionTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.brandPrimary,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeBase,
    ),
    moreTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.colorTextSecondary,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeCaption,
    ),
    flayerNormalTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.colorTextBase,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeSubHead,
    ),
    flayerSelectedTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.brandPrimary,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
    ),
    flayerBoldTextStyle: BaseTextStyle(
      color: BaseDefaultConfigUtils.defaultCommonConfig.colorTextBase,
      fontSize: BaseDefaultConfigUtils.defaultCommonConfig.fontSizeSubHead,
      fontWeight: FontWeight.w600,
    ),
  );
}
