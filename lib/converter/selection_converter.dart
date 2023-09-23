import 'package:phoenix_base/phoenix.dart';

import '../bean/selection_common_entity.dart';
import '../selection_util.dart';

/// 筛选项数据转换器，用于将统一的数据结构转换为用户需要的数据结构
abstract class SelectionConverterDelegate {
  /// 统一的数据结构 转换为 用户需要的数据结构，并通过 [BrnSelectionOnSelectionChanged] 回传给用户使用。
  Map<String, String> convertSelectedData(
      List<SelectionEntity> selectedResults);
}

/// 默认的筛选项数据转换器
class DefaultSelectionConverter implements SelectionConverterDelegate {
  const DefaultSelectionConverter();

  @override
  Map<String, String> convertSelectedData(
      List<SelectionEntity> selectedResults) {
    return getSelectionParams(selectedResults);
  }
}

/// 默认的【更多】筛选项数据转换器
class DefaultMoreSelectionConverter implements SelectionConverterDelegate {
  const DefaultMoreSelectionConverter();

  @override
  Map<String, String> convertSelectedData(
      List<SelectionEntity> selectedResults) {
    return getSelectionParams(selectedResults);
  }
}

/// 默认的【快捷筛选】筛选项数据转换器
class DefaultSelectionQuickFilterConverter
    implements SelectionConverterDelegate {
  const DefaultSelectionQuickFilterConverter();

  @override
  Map<String, String> convertSelectedData(
      List<SelectionEntity> selectedResults) {
    return getSelectionParams(selectedResults);
  }
}

/// 注意，此方法仅在初始化筛选项之前调用。如果再筛选之后使用会影响筛选View 的展示以及筛选结果。
Map<String, String> getSelectionParamsWithConfigChild(
    List<SelectionEntity>? selectedResults) {
  Map<String, String> params = Map();
  if (selectedResults == null) return params;
  selectedResults.forEach((f) => f.configRelationshipAndDefaultValue());
  return getSelectionParams(selectedResults);
}

/// 根据传入的原始数据，返回用户选中的筛选数据
Map<String, String> getSelectionParams(List<SelectionEntity>? selectedResults) {
  Map<String, String> params = Map();
  if (selectedResults == null) return params;
  for (SelectionEntity menuItemEntity in selectedResults) {
    if (menuItemEntity.filterType == SelectionFilterType.more) {
      params.addAll(getSelectionParams(menuItemEntity.children));
    } else {
      /// 1、首先找出 自定义范围的筛选项参数。
      SelectionEntity? selectedCustomInputItem =
          SelectionUtil.getFilledCustomInputItem(menuItemEntity.children);
      if (selectedCustomInputItem != null &&
          !PhoenixTools.isEmpty(selectedCustomInputItem.customMap)) {
        String? key = selectedCustomInputItem.parent?.key;
        if (!PhoenixTools.isEmpty(key)) {
          params[key!] =
              '${selectedCustomInputItem.customMap!["min"] ?? ''}:${selectedCustomInputItem.customMap!["max"] ?? ''}';
        }
      }

      /// 2、一次找出层级为 1、2、3 的选中项的参数，递归不好阅读，直接写成 for 嵌套遍历。
      int levelCount = SelectionUtil.getTotalLevel(menuItemEntity);
      if (levelCount == 1) {
        params.addAll(getCurrentSelectionEntityParams(menuItemEntity));
      } else if (levelCount == 2) {
        params.addAll(getCurrentSelectionEntityParams(menuItemEntity));
        menuItemEntity.children.forEach((firstLevelItem) =>
            params.addAll(getCurrentSelectionEntityParams(firstLevelItem)));
      } else if (levelCount == 3) {
        params.addAll(getCurrentSelectionEntityParams(menuItemEntity));
        menuItemEntity.children.forEach((firstLevelItem) {
          params.addAll(getCurrentSelectionEntityParams(firstLevelItem));
          firstLevelItem.children.forEach((secondLevelItem) {
            params.addAll(getCurrentSelectionEntityParams(secondLevelItem));
          });
        });
      }
    }
  }
  return params;
}

/// 获取当前选中项中用户选择的筛选数据
Map<String, String> getCurrentSelectionEntityParams(
    SelectionEntity selectionEntity) {
  Map<String, String> params = Map();
  String? parentKey = selectionEntity.key;
  List<String?> selectedEntity = selectionEntity.children
      .where((SelectionEntity f) => f.isSelected)
      .where((SelectionEntity f) => !PhoenixTools.isEmpty(f.value))
      .map((SelectionEntity f) => f.value)
      .toList();
  String selectedParams =
      selectedEntity.isEmpty ? '' : selectedEntity.join(',');
  if (!PhoenixTools.isEmpty(selectedParams) &&
      !PhoenixTools.isEmpty(parentKey)) {
    params[parentKey!] = selectedParams;
  }
  return params;
}
