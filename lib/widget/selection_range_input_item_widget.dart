import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phoenix_base/phoenix.dart';

import '../bean/selection_common_entity.dart';
import '../config/selection_config.dart';

typedef RangeChangedCallback = void Function(String minInput, String maxInput);

/// 清空自定义范围输入框焦点的事件类
class ClearSelectionFocusEvent {}

/// 筛选的范围输入子组件
class BrnSelectionRangeItemWidget extends StatefulWidget {
  final SelectionEntity item;

  /// 范围输入框的回调
  final RangeChangedCallback? onRangeChanged;

  /// 输入框焦点的回调
  final ValueChanged<bool>? onFocusChanged;

  /// 是否清空输入框的文本
  final bool isShouldClearText;

  /// 最小值输入框的控制器
  final TextEditingController minTextEditingController;

  /// 最大值输入框的控制器
  final TextEditingController maxTextEditingController;

  /// 主题配置
  final SelectionConfig themeData;

  const BrnSelectionRangeItemWidget({
    Key? key,
    required this.item,
    required this.minTextEditingController,
    required this.maxTextEditingController,
    this.isShouldClearText = false,
    this.onRangeChanged,
    this.onFocusChanged,
    required this.themeData,
  }) : super(key: key);

  @override
  _BrnSelectionRangeItemWidgetState createState() =>
      _BrnSelectionRangeItemWidgetState();
}

class _BrnSelectionRangeItemWidgetState
    extends State<BrnSelectionRangeItemWidget> {
  final FocusNode _minFocusNode = FocusNode();
  final FocusNode _maxFocusNode = FocusNode();

  @override
  void initState() {
    widget.minTextEditingController.text =
        (widget.item.customMap != null && widget.item.customMap!['min'] != null)
            ? widget.item.customMap!['min']?.toString() ?? ''
            : '';
    widget.maxTextEditingController.text =
        (widget.item.customMap != null && widget.item.customMap!['max'] != null)
            ? widget.item.customMap!['max']?.toString() ?? ''
            : '';

    //输入框焦点
    _minFocusNode.addListener(() {
      if (widget.onFocusChanged != null) {
        widget
            .onFocusChanged!(_minFocusNode.hasFocus || _maxFocusNode.hasFocus);
      }
    });

    _maxFocusNode.addListener(() {
      if (widget.onFocusChanged != null) {
        widget
            .onFocusChanged!(_minFocusNode.hasFocus || _maxFocusNode.hasFocus);
      }
    });

    widget.minTextEditingController.addListener(() {
      String minInput = widget.minTextEditingController.text;

      if (widget.item.customMap == null) {
        widget.item.customMap = {};
      }
      widget.item.customMap!['min'] = minInput;
      widget.item.isSelected = true;
    });

    widget.maxTextEditingController.addListener(() {
      String maxInput = widget.maxTextEditingController.text;
      if (widget.item.customMap == null) {
        widget.item.customMap = {};
      }
      widget.item.customMap!['max'] = maxInput;
      widget.item.isSelected = true;
    });

    EventBus.instance
        .on<ClearSelectionFocusEvent>()
        .listen((ClearSelectionFocusEvent event) {
      _minFocusNode.unfocus();
      _maxFocusNode.unfocus();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              "${widget.item.title.isNotEmpty ? widget.item.title : BrnIntl.of(context).localizedResource.customRange}(${widget.item.extMap['unit']?.toString() ?? ''})",
              textAlign: TextAlign.left,
              style: widget.themeData.rangeTitleTextStyle.generateTextStyle(),
            ),
          ),
          Row(
            children: <Widget>[
              getRangeTextField(false),
              Text(
                BrnIntl.of(context).localizedResource.to,
                style: widget.themeData.inputTextStyle.generateTextStyle(),
              ),
              getRangeTextField(true),
            ],
          )
        ],
      ),
    );
  }

  Widget getRangeTextField(bool isMax) {
    return Expanded(
      child: TextFormField(
        style: widget.themeData.inputTextStyle.generateTextStyle(),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: const TextInputType.numberWithOptions(),
        onChanged: (input) {
          widget.item.isSelected = true;
        },
        focusNode: isMax ? _maxFocusNode : _minFocusNode,
        controller: isMax
            ? widget.maxTextEditingController
            : widget.minTextEditingController,
        cursorColor: widget.themeData.commonConfig.brandPrimary,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintStyle: widget.themeData.hintTextStyle.generateTextStyle(),
          hintText: (isMax
              ? BrnIntl.of(context).localizedResource.maxValue
              : BrnIntl.of(context).localizedResource.minValue),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: widget.themeData.commonConfig.dividerColorBase,
          )),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            width: 1,
            color: widget.themeData.commonConfig.dividerColorBase,
          )),
          contentPadding: const EdgeInsets.all(0),
        ),
      ),
    );
  }
}
