/*
 * @Author: lipeng 1162423147@qq.com
 * @Date: 2023-08-31 14:41:55
 * @LastEditors: lipeng 1162423147@qq.com
 * @LastEditTime: 2023-09-23 20:21:33
 * @FilePath: /phoenix_selection/lib/config/selection_config.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/painting.dart';
import 'package:phoenix_base/phoenix.dart';
import 'package:phoenix_selection/extension/selection_total_config.dart';

import '../extension/selection_default_config_utils.dart';

/// 筛选项 配置类
class SelectionConfig extends BaseConfig {
  /// 遵循外部主题配置
  /// 默认为 [DefaultConfigUtils.defaultSelectionConfig]
  SelectionConfig({
    BaseTextStyle? menuNormalTextStyle,
    BaseTextStyle? menuSelectedTextStyle,
    BaseTextStyle? tagNormalTextStyle,
    BaseTextStyle? tagSelectedTextStyle,
    double? tagRadius,
    Color? tagNormalBackgroundColor,
    Color? tagSelectedBackgroundColor,
    BaseTextStyle? hintTextStyle,
    BaseTextStyle? rangeTitleTextStyle,
    BaseTextStyle? inputTextStyle,
    BaseTextStyle? itemNormalTextStyle,
    BaseTextStyle? itemSelectedTextStyle,
    BaseTextStyle? itemBoldTextStyle,
    Color? deepNormalBgColor,
    Color? deepSelectBgColor,
    Color? middleNormalBgColor,
    Color? middleSelectBgColor,
    Color? lightNormalBgColor,
    Color? lightSelectBgColor,
    BaseTextStyle? resetTextStyle,
    BaseTextStyle? titleForMoreTextStyle,
    BaseTextStyle? optionTextStyle,
    BaseTextStyle? moreTextStyle,
    BaseTextStyle? flayerNormalTextStyle,
    BaseTextStyle? flayerSelectedTextStyle,
    BaseTextStyle? flayerBoldTextStyle,
    String configId = GLOBAL_CONFIG_ID,
  })  : _menuNormalTextStyle = menuNormalTextStyle,
        _menuSelectedTextStyle = menuSelectedTextStyle,
        _tagNormalTextStyle = tagNormalTextStyle,
        _tagSelectedTextStyle = tagSelectedTextStyle,
        _tagRadius = tagRadius,
        _tagNormalBackgroundColor = tagNormalBackgroundColor,
        _tagSelectedBackgroundColor = tagSelectedBackgroundColor,
        _hintTextStyle = hintTextStyle,
        _rangeTitleTextStyle = rangeTitleTextStyle,
        _inputTextStyle = inputTextStyle,
        _itemNormalTextStyle = itemNormalTextStyle,
        _itemSelectedTextStyle = itemSelectedTextStyle,
        _itemBoldTextStyle = itemBoldTextStyle,
        _deepNormalBgColor = deepNormalBgColor,
        _deepSelectBgColor = deepSelectBgColor,
        _middleNormalBgColor = middleNormalBgColor,
        _middleSelectBgColor = middleSelectBgColor,
        _lightNormalBgColor = lightNormalBgColor,
        _lightSelectBgColor = lightSelectBgColor,
        _resetTextStyle = resetTextStyle,
        _titleForMoreTextStyle = titleForMoreTextStyle,
        _optionTextStyle = optionTextStyle,
        _moreTextStyle = moreTextStyle,
        _flayerNormalTextStyle = flayerNormalTextStyle,
        _flayerSelectedTextStyle = flayerSelectedTextStyle,
        _flayerBoldTextStyle = flayerBoldTextStyle,
        super(configId: configId);

  /// menu 正常文本样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.normal,
  /// )
  BaseTextStyle? _menuNormalTextStyle;

  /// menu 选中文本样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BaseTextStyle? _menuSelectedTextStyle;

  /// tag 正常文本样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  ///   fontWeight: FontWeight.w400,
  /// )
  BaseTextStyle? _tagNormalTextStyle;

  /// tag 选中文本样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  ///   fontWeight: FontWeight.w600,
  /// )
  BaseTextStyle? _tagSelectedTextStyle;

  /// tag 圆角
  /// 默认为 [BrnCommonConfig.radiusSm]
  double? _tagRadius;

  /// tag 正常背景色
  /// 默认为 [BrnCommonConfig.fillBody]
  Color? _tagNormalBackgroundColor;

  /// tag 选中背景色
  /// 默认为 [BrnCommonConfig.brandPrimary].withOpacity(0.12)
  Color? _tagSelectedBackgroundColor;

  /// 输入选项标题文本样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BaseTextStyle? _rangeTitleTextStyle;

  /// 输入提示文本样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.colorTextHint],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BaseTextStyle? _hintTextStyle;

  /// 输入框默认文本样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BaseTextStyle? _inputTextStyle;

  /// item 正常字体样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BaseTextStyle? _itemNormalTextStyle;

  /// item 选中文本样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BaseTextStyle? _itemSelectedTextStyle;

  /// item 仅加粗样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BaseTextStyle? _itemBoldTextStyle;

  /// 三级 item 背景色
  /// 默认为 Color(0xFFF0F0F0)
  Color? _deepNormalBgColor;

  /// 三级 item 选中背景色
  /// 默认为 Color(0xFFF8F8F8)
  Color? _deepSelectBgColor;

  /// 二级 item 背景色
  /// 默认为 Color(0xFFF8F8F8)
  Color? _middleNormalBgColor;

  /// 二级 item 选中背景色
  /// 默认为 Colors.white
  Color? _middleSelectBgColor;

  /// 一级 item 背景色
  /// 默认为 Colors.white
  Color? _lightNormalBgColor;

  /// 一级 item 选中背景色
  /// 默认为 Colors.white
  Color? _lightSelectBgColor;

  /// 重置按钮颜色
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.colorTextImportant],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption]
  /// )
  BaseTextStyle? _resetTextStyle;

  /// 更多筛选-标题文本样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  ///   fontWeight: FontWeight.w600,
  /// )
  BaseTextStyle? _titleForMoreTextStyle;

  /// 选项-显示文本
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeBase],
  /// )
  BaseTextStyle? _optionTextStyle;

  /// 更多文本样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.colorTextSecondary],
  ///   fontSize: [BrnCommonConfig.fontSizeCaption],
  /// )
  BaseTextStyle? _moreTextStyle;

  /// 跳转二级页-正常文本样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.normal,
  /// )
  BaseTextStyle? _flayerNormalTextStyle;

  /// 跳转二级页-选中文本样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.brandPrimary],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600,
  /// )
  BaseTextStyle? _flayerSelectedTextStyle;

  /// 跳转二级页-加粗文本样式
  ///
  /// BaseTextStyle(
  ///   color: [BrnCommonConfig.colorTextBase],
  ///   fontSize: [BrnCommonConfig.fontSizeSubHead],
  ///   fontWeight: FontWeight.w600
  /// )
  BaseTextStyle? _flayerBoldTextStyle;

  BaseTextStyle get menuNormalTextStyle =>
      _menuNormalTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.menuNormalTextStyle;

  BaseTextStyle get menuSelectedTextStyle =>
      _menuSelectedTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.menuSelectedTextStyle;

  BaseTextStyle get tagNormalTextStyle =>
      _tagNormalTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.tagNormalTextStyle;

  BaseTextStyle get tagSelectedTextStyle =>
      _tagSelectedTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.tagSelectedTextStyle;

  double get tagRadius =>
      _tagRadius ?? BaseSelectionConfigUtils.defaultSelectionConfig.tagRadius;

  Color get tagNormalBackgroundColor =>
      _tagNormalBackgroundColor ??
      BaseSelectionConfigUtils.defaultSelectionConfig.tagNormalBackgroundColor;

  Color get tagSelectedBackgroundColor =>
      _tagSelectedBackgroundColor ??
      BaseSelectionConfigUtils
          .defaultSelectionConfig.tagSelectedBackgroundColor;

  BaseTextStyle get rangeTitleTextStyle =>
      _rangeTitleTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.rangeTitleTextStyle;

  BaseTextStyle get hintTextStyle =>
      _hintTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.hintTextStyle;

  BaseTextStyle get inputTextStyle =>
      _inputTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.inputTextStyle;

  BaseTextStyle get itemNormalTextStyle =>
      _itemNormalTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.itemNormalTextStyle;

  BaseTextStyle get itemSelectedTextStyle =>
      _itemSelectedTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.itemSelectedTextStyle;

  BaseTextStyle get itemBoldTextStyle =>
      _itemBoldTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.itemBoldTextStyle;

  Color get deepNormalBgColor =>
      _deepNormalBgColor ??
      BaseSelectionConfigUtils.defaultSelectionConfig.deepNormalBgColor;

  Color get deepSelectBgColor =>
      _deepSelectBgColor ??
      BaseSelectionConfigUtils.defaultSelectionConfig.deepSelectBgColor;

  Color get middleNormalBgColor =>
      _middleNormalBgColor ??
      BaseSelectionConfigUtils.defaultSelectionConfig.middleNormalBgColor;

  Color get middleSelectBgColor =>
      _middleSelectBgColor ??
      BaseSelectionConfigUtils.defaultSelectionConfig.middleSelectBgColor;

  Color get lightNormalBgColor =>
      _lightNormalBgColor ??
      BaseSelectionConfigUtils.defaultSelectionConfig.lightNormalBgColor;

  Color get lightSelectBgColor =>
      _lightSelectBgColor ??
      BaseSelectionConfigUtils.defaultSelectionConfig.lightSelectBgColor;

  BaseTextStyle get resetTextStyle =>
      _resetTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.resetTextStyle;

  BaseTextStyle get titleForMoreTextStyle =>
      _titleForMoreTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.titleForMoreTextStyle;

  BaseTextStyle get optionTextStyle =>
      _optionTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.optionTextStyle;

  BaseTextStyle get moreTextStyle =>
      _moreTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.moreTextStyle;

  BaseTextStyle get flayerNormalTextStyle =>
      _flayerNormalTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.flayerNormalTextStyle;

  BaseTextStyle get flayerSelectedTextStyle =>
      _flayerSelectedTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.flayerSelectedTextStyle;

  BaseTextStyle get flayerBoldTextStyle =>
      _flayerBoldTextStyle ??
      BaseSelectionConfigUtils.defaultSelectionConfig.flayerBoldTextStyle;

  @override
  void initThemeConfig(
    String configId, {
    BaseCommonConfig? currentLevelCommonConfig,
  }) {
    super.initThemeConfig(
      configId,
      currentLevelCommonConfig: currentLevelCommonConfig,
    );

    /// 用户全局筛选配置
    SelectionConfig selectionConfig =
        BaseThemeConfig.instance.getConfig(configId: configId).selectionConfig;

    _lightSelectBgColor ??= selectionConfig._lightSelectBgColor;
    _lightNormalBgColor ??= selectionConfig._lightNormalBgColor;
    _middleSelectBgColor ??= selectionConfig._middleSelectBgColor;
    _middleNormalBgColor ??= selectionConfig._middleNormalBgColor;
    _deepSelectBgColor ??= selectionConfig._deepSelectBgColor;
    _deepNormalBgColor ??= selectionConfig._deepNormalBgColor;
    _tagSelectedBackgroundColor ??= commonConfig.brandPrimary.withOpacity(0.12);
    _tagNormalBackgroundColor ??= commonConfig.fillBody;
    _tagRadius ??= commonConfig.radiusSm;
    _flayerBoldTextStyle = selectionConfig.flayerBoldTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_flayerBoldTextStyle),
    );
    _flayerSelectedTextStyle = selectionConfig.flayerSelectedTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_flayerSelectedTextStyle),
    );
    _flayerNormalTextStyle = selectionConfig.flayerNormalTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_flayerNormalTextStyle),
    );
    _moreTextStyle = selectionConfig.moreTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.colorTextSecondary,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(_moreTextStyle),
    );
    _optionTextStyle = selectionConfig.optionTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_optionTextStyle),
    );
    _titleForMoreTextStyle = selectionConfig.titleForMoreTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_titleForMoreTextStyle),
    );
    _resetTextStyle = selectionConfig.resetTextStyle.merge(BaseTextStyle(
      color: commonConfig.colorTextImportant,
      fontSize: commonConfig.fontSizeCaption,
    ).merge(_resetTextStyle));
    _itemBoldTextStyle = selectionConfig.itemBoldTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_itemBoldTextStyle),
    );
    _itemSelectedTextStyle = selectionConfig.itemSelectedTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_itemSelectedTextStyle),
    );
    _itemNormalTextStyle = selectionConfig.itemNormalTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_itemNormalTextStyle),
    );
    _inputTextStyle = selectionConfig.inputTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_inputTextStyle),
    );
    _hintTextStyle = selectionConfig.hintTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.colorTextHint,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_hintTextStyle),
    );
    _rangeTitleTextStyle = selectionConfig.rangeTitleTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeSubHead,
      ).merge(_rangeTitleTextStyle),
    );
    _tagSelectedTextStyle = selectionConfig.tagSelectedTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(_tagSelectedTextStyle),
    );
    _tagNormalTextStyle = selectionConfig.tagNormalTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeCaption,
      ).merge(_tagNormalTextStyle),
    );
    _menuNormalTextStyle = selectionConfig.menuNormalTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.colorTextBase,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_menuNormalTextStyle),
    );
    _menuSelectedTextStyle = selectionConfig.menuSelectedTextStyle.merge(
      BaseTextStyle(
        color: commonConfig.brandPrimary,
        fontSize: commonConfig.fontSizeBase,
      ).merge(_menuSelectedTextStyle),
    );
  }

  SelectionConfig copyWith({
    BaseTextStyle? menuNormalTextStyle,
    BaseTextStyle? menuSelectedTextStyle,
    BaseTextStyle? tagTextStyle,
    BaseTextStyle? tagSelectedTextStyle,
    double? tagRadius,
    Color? tagBackgroundColor,
    Color? tagSelectedBackgroundColor,
    BaseTextStyle? hintTextStyle,
    BaseTextStyle? rangeTitleTextStyle,
    BaseTextStyle? inputTextStyle,
    BaseTextStyle? itemNormalTextStyle,
    BaseTextStyle? itemSelectedTextStyle,
    BaseTextStyle? itemBoldTextStyle,
    Color? deepNormalBgColor,
    Color? deepSelectBgColor,
    Color? middleNormalBgColor,
    Color? middleSelectBgColor,
    Color? lightNormalBgColor,
    Color? lightSelectBgColor,
    BaseTextStyle? resetTextStyle,
    BaseTextStyle? titleForMoreTextStyle,
    BaseTextStyle? optionTextStyle,
    BaseTextStyle? moreTextStyle,
    BaseTextStyle? flayerNormalTextStyle,
    BaseTextStyle? flayerSelectedTextStyle,
    BaseTextStyle? flayerBoldTextStyle,
  }) {
    return SelectionConfig(
      menuNormalTextStyle: menuNormalTextStyle ?? _menuNormalTextStyle,
      menuSelectedTextStyle: menuSelectedTextStyle ?? _menuSelectedTextStyle,
      tagNormalTextStyle: tagTextStyle ?? _tagNormalTextStyle,
      tagSelectedTextStyle: tagSelectedTextStyle ?? _tagSelectedTextStyle,
      tagRadius: tagRadius ?? _tagRadius,
      tagNormalBackgroundColor: tagBackgroundColor ?? _tagNormalBackgroundColor,
      tagSelectedBackgroundColor:
          tagSelectedBackgroundColor ?? _tagSelectedBackgroundColor,
      hintTextStyle: hintTextStyle ?? _hintTextStyle,
      rangeTitleTextStyle: rangeTitleTextStyle ?? _rangeTitleTextStyle,
      inputTextStyle: inputTextStyle ?? _inputTextStyle,
      itemNormalTextStyle: itemNormalTextStyle ?? _itemNormalTextStyle,
      itemSelectedTextStyle: itemSelectedTextStyle ?? _itemSelectedTextStyle,
      itemBoldTextStyle: itemBoldTextStyle ?? _itemBoldTextStyle,
      deepNormalBgColor: deepNormalBgColor ?? _deepNormalBgColor,
      deepSelectBgColor: deepSelectBgColor ?? _deepSelectBgColor,
      middleNormalBgColor: middleNormalBgColor ?? _middleNormalBgColor,
      middleSelectBgColor: middleSelectBgColor ?? _middleSelectBgColor,
      lightNormalBgColor: lightNormalBgColor ?? _lightNormalBgColor,
      lightSelectBgColor: lightSelectBgColor ?? _lightSelectBgColor,
      resetTextStyle: resetTextStyle ?? _resetTextStyle,
      titleForMoreTextStyle: titleForMoreTextStyle ?? _titleForMoreTextStyle,
      optionTextStyle: optionTextStyle ?? _optionTextStyle,
      moreTextStyle: moreTextStyle ?? _moreTextStyle,
      flayerNormalTextStyle: flayerNormalTextStyle ?? _flayerNormalTextStyle,
      flayerSelectedTextStyle:
          flayerSelectedTextStyle ?? _flayerSelectedTextStyle,
      flayerBoldTextStyle: flayerBoldTextStyle ?? _flayerBoldTextStyle,
    );
  }

  SelectionConfig merge(SelectionConfig other) {
    return copyWith(
      menuNormalTextStyle:
          menuNormalTextStyle.merge(other._menuNormalTextStyle),
      menuSelectedTextStyle:
          menuSelectedTextStyle.merge(other._menuSelectedTextStyle),
      tagTextStyle: tagNormalTextStyle.merge(other._tagNormalTextStyle),
      tagSelectedTextStyle:
          tagSelectedTextStyle.merge(other._tagSelectedTextStyle),
      tagRadius: other._tagRadius,
      tagBackgroundColor: other._tagNormalBackgroundColor,
      tagSelectedBackgroundColor: other._tagSelectedBackgroundColor,
      hintTextStyle: hintTextStyle.merge(other._hintTextStyle),
      rangeTitleTextStyle:
          rangeTitleTextStyle.merge(other._rangeTitleTextStyle),
      inputTextStyle: inputTextStyle.merge(other._inputTextStyle),
      itemNormalTextStyle:
          itemNormalTextStyle.merge(other._itemNormalTextStyle),
      itemSelectedTextStyle:
          itemSelectedTextStyle.merge(other._itemSelectedTextStyle),
      itemBoldTextStyle: itemBoldTextStyle.merge(other._itemBoldTextStyle),
      deepNormalBgColor: other._deepNormalBgColor,
      deepSelectBgColor: other._deepSelectBgColor,
      middleNormalBgColor: other._middleNormalBgColor,
      middleSelectBgColor: other._middleSelectBgColor,
      lightNormalBgColor: other._lightNormalBgColor,
      lightSelectBgColor: other._lightSelectBgColor,
      resetTextStyle: resetTextStyle.merge(other._resetTextStyle),
      titleForMoreTextStyle:
          titleForMoreTextStyle.merge(other._titleForMoreTextStyle),
      optionTextStyle: optionTextStyle.merge(other._optionTextStyle),
      moreTextStyle: moreTextStyle.merge(other._moreTextStyle),
      flayerNormalTextStyle:
          flayerNormalTextStyle.merge(other._flayerNormalTextStyle),
      flayerSelectedTextStyle:
          flayerSelectedTextStyle.merge(other._flayerSelectedTextStyle),
      flayerBoldTextStyle:
          flayerBoldTextStyle.merge(other._flayerBoldTextStyle),
    );
  }
}
