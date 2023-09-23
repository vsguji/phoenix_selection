import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phoenix_base/phoenix.dart';
import 'package:phoenix_popup/measure_size.dart';
import 'package:phoenix_selection/extension/selection_total_config.dart';
import 'package:phoenix_toast/phoenix_toast.dart';

import 'bean/selection_common_entity.dart';
import 'selection_util.dart';
import 'selection_view.dart';
import 'config/selection_config.dart';
import 'controller/flat_selection_controller.dart';
import 'converter/selection_converter.dart';
import 'widget/flat_selection_item.dart';

/// 支持tag 、输入 、range、选择等类型混合一级筛选
/// 也可支持点击选项跳转二级页面
// ignore: must_be_immutable
class FlatSelection extends StatefulWidget {
  /// 筛选原始数据
  final List<SelectionEntity> entityDataList;

  /// 点击确定回调
  final Function(Map<String, String>)? confirmCallback;

  /// 每行展示tag数量  默认真是3个
  final int preLineTagSize;

  /// 当[BrnSelectionEntity.filterType]为[BrnSelectionFilterType.layer] or[BrnSelectionFilterType.customLayer]时
  /// 跳转到二级页面的自定义操作
  final OnCustomFloatingLayerClick? onCustomFloatingLayerClick;

  /// controller.dispose() 操作交由外部处理
  final FlatSelectionController? controller;

  /// 是否需要配置子选项
  final bool isNeedConfigChild;

  /// 主题配置
  /// 如有对文本样式、圆角、间距等[BrnSelectionConfig]有特定要求可以配置该属性
  SelectionConfig? themeData;

  FlatSelection(
      {Key? key,
      required this.entityDataList,
      this.confirmCallback,
      this.onCustomFloatingLayerClick,
      this.preLineTagSize = 3,
      this.isNeedConfigChild = true,
      this.controller,
      this.themeData})
      : super(key: key) {
    themeData ??= SelectionConfig();
    themeData = BaseThemeConfig.instance
        .getConfig(configId: themeData!.configId)
        .selectionConfig
        .merge(themeData!);
  }

  @override
  _FlatSelectionState createState() => _FlatSelectionState();
}

class _FlatSelectionState extends State<FlatSelection>
    with SingleTickerProviderStateMixin {
  List<SelectionEntity> _originalSelectedItemsList = [];

  StreamController<FlatClearEvent> clearController =
      StreamController.broadcast();
  bool isValid = true;

  double _lineWidth = 0.0;

  @override
  void initState() {
    super.initState();

    if (widget.isNeedConfigChild) {
      widget.entityDataList
          .forEach((f) => f.configRelationshipAndDefaultValue());
    }
    widget.controller?.addListener(_handleFlatControllerTick);

    List<SelectionEntity> firstColumn = [];
    if (widget.entityDataList.isNotEmpty) {
      for (SelectionEntity entity in widget.entityDataList) {
        if (entity.isSelected) {
          firstColumn.add(entity);
        }
      }
    }
    _originalSelectedItemsList.addAll(firstColumn);
    if (firstColumn.isNotEmpty) {
      for (SelectionEntity firstEntity in firstColumn) {
        List<SelectionEntity> secondColumn =
            SelectionUtil.currentSelectListForEntity(firstEntity);
        _originalSelectedItemsList.addAll(secondColumn);
        if (secondColumn.isNotEmpty) {
          for (SelectionEntity secondEntity in secondColumn) {
            List<SelectionEntity> thirdColumn =
                SelectionUtil.currentSelectListForEntity(secondEntity);
            _originalSelectedItemsList.addAll(thirdColumn);
          }
        }
      }
    }

    for (SelectionEntity entity in _originalSelectedItemsList) {
      entity.isSelected = true;
      if (entity.customMap != null) {
        // originalCustomMap 是用来存临时状态数据, customMap 用来展示 ui
        entity.originalCustomMap = Map.from(entity.customMap!);
      }
    }
  }

  void _handleFlatControllerTick() {
    if (widget.controller?.isResetSelectedOptions ?? false) {
      if (mounted) {
        setState(() {
          _resetSelectedOptions();
        });
      }
      widget.controller?.isResetSelectedOptions = false;
    } else if (widget.controller?.isCancelSelectedOptions ?? false) {
      // 外部关闭调用无UI更新操作
      _cancelSelectedOptions();
      widget.controller?.isCancelSelectedOptions = false;
    } else if (widget.controller?.isConfirmSelectedOptions ?? false) {
      _confirmSelectedOptions();
      widget.controller?.isConfirmSelectedOptions = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MeasureSize(
        onChange: (size) {
          setState(() {
            _lineWidth = size.width;
          });
        },
        child: _buildSelectionListView());
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleFlatControllerTick);
    super.dispose();
  }

  /// 取消
  _cancelSelectedOptions() {
    if (widget.entityDataList.isEmpty) {
      return;
    }
    for (SelectionEntity entity in widget.entityDataList) {
      SelectionUtil.resetSelectionDatas(entity);
    }
    //把数据还原
    _originalSelectedItemsList.forEach((data) {
      data.isSelected = true;
      if (data.customMap != null) {
        // originalCustomMap 是用来存临时状态数据, customMap 用来展示 ui
        data.customMap = Map<String, String>();
        data.originalCustomMap.forEach((key, value) {
          data.customMap![key.toString()] = value.toString();
        });
      }
    });
  }

  /// 重置
  _resetSelectedOptions() {
    clearController.add(FlatClearEvent());
    if (widget.entityDataList.isNotEmpty) {
      for (SelectionEntity entity in widget.entityDataList) {
        _clearUIData(entity);
      }
    }
  }

  /// 确定
  void _confirmSelectedOptions() {
    _clearSelectedEntity();
    if (!isValid) {
      isValid = true;
      return;
    }

    widget.entityDataList.forEach((data) {
      if (data.selectedList().isNotEmpty) {
        data.isSelected = true;
      } else {
        data.isSelected = false;
      }
    });
    if (widget.confirmCallback != null) {
      widget.confirmCallback!(DefaultSelectionConverter()
          .convertSelectedData(widget.entityDataList));
    }
  }

  /// 标题+筛选条件的 列表
  Widget _buildSelectionListView() {
    var contentWidget = Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FlatMoreSelection(
                clearController: clearController,
                selectionEntity: widget.entityDataList[index],
                onCustomFloatingLayerClick: widget.onCustomFloatingLayerClick,
                preLineTagSize: widget.preLineTagSize,
                parentWidth: _lineWidth,
                themeData: widget.themeData!,
              );
            },
            itemCount: widget.entityDataList.length,
          ),
        ));

    return contentWidget;
  }

  /// 清空UI效果
  void _clearUIData(SelectionEntity entity) {
    entity.isSelected = false;
    entity.customMap = Map<String, String>();
    if (SelectionFilterType.range == entity.filterType) {
      entity.title = '';
    }
    for (SelectionEntity subEntity in entity.children) {
      _clearUIData(subEntity);
    }
  }

  void _clearSelectedEntity() {
    List<SelectionEntity> tmp = [];
    SelectionEntity node;
    tmp.addAll(widget.entityDataList);
    while (tmp.isNotEmpty) {
      node = tmp.removeLast();
      if (!node.isValidRange()) {
        isValid = false;
        PhoenixToast.show(
            BrnIntl.of(context).localizedResource.enterRangeError, context);
        return;
      }
      node.children.forEach((data) {
        tmp.add(data);
      });
    }
  }
}
