import 'package:flutter/material.dart';
import 'package:phoenix_base/phoenix.dart';
import 'package:phoenix_btn/button/big_main_button.dart';
import 'package:phoenix_calendar/phoenix_calendar.dart';
import 'package:phoenix_line/phoenix_line.dart';
import 'package:phoenix_picker/phoenix_picker.dart';
import 'package:phoenix_tabbar/phoenix_tabbar.dart';
import 'package:phoenix_toast/phoenix_toast.dart';

import '../bean/selection_common_entity.dart';
import '../config/selection_config.dart';
import '../selection_util.dart';
import 'selection_menu_widget.dart';
import 'selection_range_input_item_widget.dart';
import 'selection_range_tag_widget.dart';
import 'selection_date_range_item_widget.dart';

/// 范围选择子组件
class RangeSelectionGroupWidget extends StatefulWidget {
  /// 根节点的筛选数据
  final SelectionEntity entity;

  /// 最大高度
  final double maxContentHeight;

  /// 是否显示选中数量
  final bool showSelectedCount;

  /// 背景点击事件
  final VoidCallback? bgClickFunction;

  /// 确认按钮点击事件
  final BrnOnRangeSelectionConfirm? onSelectionConfirm;

  /// 每行 tag 数
  final int? rowCount;

  /// 顶部间距
  final double marginTop;

  /// 主题配置
  final SelectionConfig themeData;

  const RangeSelectionGroupWidget(
      {Key? key,
      required this.entity,
      this.maxContentHeight = DESIGN_SELECTION_HEIGHT,
      this.rowCount,
      this.showSelectedCount = false,
      this.bgClickFunction,
      this.onSelectionConfirm,
      this.marginTop = 0,
      required this.themeData})
      : super(key: key);

  @override
  _RangeSelectionGroupWidgetState createState() =>
      _RangeSelectionGroupWidgetState();
}

class _RangeSelectionGroupWidgetState extends State<RangeSelectionGroupWidget>
    with SingleTickerProviderStateMixin {
  List<SelectionEntity> _originalSelectedItemsList = [];
  List<SelectionEntity> _firstList = [];
  List<SelectionEntity> _secondList = [];
  int _firstIndex = -1;
  int _secondIndex = -1;
  int totalLevel = 0;
  late double _screenWidth;

  late TabController _tabController;

  final TextEditingController _minTextEditingController =
      TextEditingController();
  final TextEditingController _maxTextEditingController =
      TextEditingController();

  bool _isConfirmClick = false;

  @override
  void initState() {
    _screenWidth =
        View.of(context).physicalSize.width / View.of(context).devicePixelRatio;
    _initData();
    _tabController = TabController(vsync: this, length: _firstList.length);
    if (_firstIndex >= 0) {
      _tabController.index = _firstIndex;
    }
    _tabController.addListener(() {
      _clearAllSelectedItems();
      _clearNotTagItem(totalLevel == 1
          ? _firstList
          : _firstList[_tabController.index].children);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    if (!_isConfirmClick) {
      _resetSelectionDatas(widget.entity);
      _clearNotTagItem(totalLevel == 1
          ? _firstList
          : _firstList[_tabController.index].children);
      _resetCustomMapData();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    totalLevel = SelectionUtil.getTotalLevel(widget.entity);
    return GestureDetector(
      onTap: () {
        _backgroundTap();
      },
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: Column(
            children: _configWidgets(),
          ),
        ),
      ),
    );
  }

  //pragma mark -- config widgets

  List<Widget> _configWidgets() {
    List<Widget> widgetList = [];
    widgetList.add(_listWidget());
    return widgetList;
  }

  Widget _listWidget() {
    Widget? rangeWidget;

    if (_firstList.isNotEmpty && _secondList.isEmpty) {
      /// 1、仅有一级的情况
      /// 1.2 一级多选 || 存在自定义范围的情况
      rangeWidget = _createNewTagAndRangeWidget(_firstList, Colors.white);
    } else if (_firstList.isNotEmpty && _secondList.isNotEmpty) {
      /// 2、有二级的情况
      rangeWidget = _createNewTagAndRangeWidget(_firstList, Colors.white);
    }

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      constraints: _hasCalendarItem(widget.entity)
          ? BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.bottom -
                  widget.marginTop)
          : BoxConstraints(
              maxHeight: widget.maxContentHeight + DESIGN_BOTTOM_HEIGHT),
      child: rangeWidget,
    );
  }

  Widget _createNewTagAndRangeWidget(
      List<SelectionEntity> firstList, Color white) {
    if (firstList.isNotEmpty &&
        SelectionUtil.getTotalLevel(widget.entity) == 1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _getOneTabContent(widget.entity)),
            ),
          ),
          const Line(
            height: 0.5,
          ),
          _bottomWidget()
        ],
      );
    } else if (firstList.isNotEmpty &&
        SelectionUtil.getTotalLevel(widget.entity) == 2) {
      var tabBar = PhoenixTabBar(
        tabHeight: 50,
        controller: _tabController,
        tabs: firstList.map((f) => BadgeTab(text: f.title)).toList(),
      );
      var tabContent = SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _getOneTabContent(firstList[_tabController.index])));

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          tabBar,
          Flexible(
            child: tabContent,
          ),
          const Line(
            height: 0.5,
          ),
          _bottomWidget()
        ],
      );
    } else {
      return Container();
    }
  }

  List<Widget> _getOneTabContent(SelectionEntity filterItem) {
    List<SelectionEntity> subFilterList = filterItem.children;

    /// TODO 还要添加 Date  DateRange 类型的判断。
    List<SelectionEntity> tagFilterList = subFilterList
        .where((f) =>
            f.filterType != SelectionFilterType.range &&
            f.filterType != SelectionFilterType.date &&
            f.filterType != SelectionFilterType.dateRange &&
            f.filterType != SelectionFilterType.dateRangeCalendar)
        .toList();
    Size maxWidthSize = Size.zero;
    for (SelectionEntity entity in subFilterList) {
      Size size = PhoenixTextUtil.textSize(entity.title,
          widget.themeData.tagNormalTextStyle.generateTextStyle());
      if (maxWidthSize.width < size.width) {
        maxWidthSize = size;
      }
    }

    int tagWidth;

    ///如果指定展示列，则按照指定列展示，否则动态计算宽度。最大不超过四列。
    if (widget.rowCount == null) {
      int oneCountTagWidth = (_screenWidth - 40 - 12 * (1 - 1)) ~/ 1;
      int twoCountTagWidth = (_screenWidth - 40 - 12 * (2 - 1)) ~/ 2;
      int threeCountTagWidth = (_screenWidth - 40 - 12 * (3 - 1)) ~/ 3;
      int fourCountTagWidth = (_screenWidth - 40 - 12 * (4 - 1)) ~/ 4;
      if (maxWidthSize.width > twoCountTagWidth) {
        tagWidth = oneCountTagWidth;
      } else if (threeCountTagWidth < maxWidthSize.width &&
          maxWidthSize.width <= twoCountTagWidth) {
        tagWidth = twoCountTagWidth;
      } else if (fourCountTagWidth < maxWidthSize.width &&
          maxWidthSize.width <= threeCountTagWidth) {
        tagWidth = threeCountTagWidth;
      } else {
        tagWidth = fourCountTagWidth;
      }
    } else {
      tagWidth =
          (_screenWidth - 40 - 12 * (widget.rowCount! - 1)) ~/ widget.rowCount!;
    }

    var tagContainer = tagFilterList.isNotEmpty
        ? Container(
            alignment: Alignment.centerLeft,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: BrnSelectionRangeTagWidget(
                tagWidth: tagWidth,
                tagFilterList: tagFilterList,
                initFocusedIndex: _getInitFocusedIndex(subFilterList),
                themeData: widget.themeData,
                onSelect: (index, isSelected) {
                  setState(() {
                    _setFirstIndex(_tabController.index);
                    _setSecondIndex(index);
                    _clearNotTagItem(totalLevel == 1
                        ? _firstList
                        : _firstList[_tabController.index].children);
                    _clearEditRangeText();
                  });
                }),
          )
        : Container();

    Widget? content;
    for (SelectionEntity item in subFilterList) {
      if (item.filterType == SelectionFilterType.range) {
        content = BrnSelectionRangeItemWidget(
            item: item,
            minTextEditingController: _minTextEditingController,
            maxTextEditingController: _maxTextEditingController,
            themeData: widget.themeData,
            onFocusChanged: (bool focus) {
              item.isSelected = focus;
              if (focus) {
                setState(() {
                  _clearTagSelectStatus(subFilterList);
                });
              }
            });
        break;
      } else if (item.filterType == SelectionFilterType.dateRange) {
        content = SelectionDateRangeItemWidget(
            item: item,
            minTextEditingController: _minTextEditingController,
            maxTextEditingController: _maxTextEditingController,
            themeData: widget.themeData,
            onTapped: () {
              setState(() {
                _clearTagSelectStatus(subFilterList);
              });
            });
        break;
      } else if (item.filterType == SelectionFilterType.date) {
        DateTime? initialStartDate =
            DateTimeFormatter.convertIntValueToDateTime(item.value);
        DateTime? initialEndDate =
            DateTimeFormatter.convertIntValueToDateTime(item.value);
        content = CalendarView.single(
          key: GlobalKey(),
          initStartSelectedDate: initialStartDate,
          initEndSelectedDate: initialEndDate,
          initDisplayDate: initialEndDate,
          dateChange: (DateTime date) {
            item.value = date.millisecondsSinceEpoch.toString();
            item.isSelected = true;
            setState(() {
              _clearTagSelectStatus(subFilterList);
            });
          },
        );
      } else if (item.filterType == SelectionFilterType.dateRangeCalendar) {
        DateTime? initialStartDate = item.customMap == null
            ? null
            : DateTimeFormatter.convertIntValueToDateTime(
                item.customMap!['min']);
        DateTime? initialEndDate = item.customMap == null
            ? null
            : DateTimeFormatter.convertIntValueToDateTime(
                item.customMap!['max']);
        content = CalendarView.range(
          key: GlobalKey(),
          initStartSelectedDate: initialStartDate,
          initEndSelectedDate: initialEndDate,
          rangeDateChange: (DateTimeRange range) {
            item.customMap = {};
            item.customMap = {
              'min': range.start.millisecondsSinceEpoch.toString(),
              'max': range.end.millisecondsSinceEpoch.toString()
            };
            item.isSelected = true;
            setState(() {
              _clearTagSelectStatus(subFilterList);
            });
          },
        );
      }
    }
    var widgets = <Widget>[tagContainer];
    if (content != null) {
      widgets.add(content);
    }
    return widgets;
  }

  Widget _bottomWidget() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(8, 11, 20, 11),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: _clearAllSelectedItems,
            child: Container(
              padding: const EdgeInsets.only(left: 12, right: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 24,
                    width: 24,
                    child: PhoenixTools.getAssetImage(
                        BaseAsset.iconSelectionReset),
                  ),
                  Text(
                    BrnIntl.of(context).localizedResource.reset,
                    style: widget.themeData.resetTextStyle.generateTextStyle(),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: BigMainButton(
              title: BrnIntl.of(context).localizedResource.ok,
              onTap: () {
                _confirmButtonClickEvent();
              },
            ),
          )
        ],
      ),
    );
  }

  //pragma mark -- event responder

  /// 点击确定按钮时，处理数据。
  ///
  void _confirmButtonClickEvent() {
    _isConfirmClick = true;

    if (totalLevel == 2) {
      List<SelectionEntity> subFilterList =
          widget.entity.children[_tabController.index].children;
      List<SelectionEntity> selectItems =
          subFilterList.where((f) => f.isSelected).toList();
      if (selectItems.isNotEmpty) {
        _firstList[_tabController.index].isSelected = true;
      } else {
        _firstList[_tabController.index].isSelected = false;
      }
    }

    // 处理Range类型的校验
    SelectionEntity? rangeEntity = _getSelectRangeItem(totalLevel == 1
        ? _firstList
        : _firstList[_tabController.index].children);
    if (rangeEntity != null) {
      if (rangeEntity.customMap != null &&
          (!PhoenixTools.isEmpty(rangeEntity.customMap!['min']) ||
              !PhoenixTools.isEmpty(rangeEntity.customMap!['max']))) {
        if (!rangeEntity.isValidRange()) {
          FocusScope.of(context).requestFocus(FocusNode());
          if (rangeEntity.filterType == SelectionFilterType.range) {
            PhoenixToast.show(
                BrnIntl.of(context).localizedResource.enterRangeError, context);
          } else if (rangeEntity.filterType == SelectionFilterType.dateRange ||
              rangeEntity.filterType == SelectionFilterType.dateRangeCalendar) {
            PhoenixToast.show(
                BrnIntl.of(context).localizedResource.selectRangeError,
                context);
          }
          return;
        }
      } else {
        rangeEntity.isSelected = false;
      }
    }

    if (widget.onSelectionConfirm != null) {
      widget.onSelectionConfirm!(widget.entity, _firstIndex, _secondIndex, -1);
    }
  }

  void _clearAllSelectedItems() {
    _resetSelectionDatas(widget.entity);
    _clearNotTagItem(totalLevel == 1
        ? _firstList
        : _firstList[_tabController.index].children);
    _clearEditRangeText();
    setState(() {
      _configDefaultInitSelectIndex();
      _refreshDataSource();
    });
  }

  /// 初始化数据
  void _initData() {
    // 生成筛选节点树
    _originalSelectedItemsList = widget.entity.selectedList();
    for (SelectionEntity entity in _originalSelectedItemsList) {
      entity.isSelected = true;
      if (entity.customMap != null) {
        entity.originalCustomMap = Map.from(entity.customMap!);
      }
    }
    // 初始化每列的选中 index 为 -1，未选中。
    _configDefaultInitSelectIndex();
    // 遍历数据源，设置真正选中的index
    _configDefaultSelectedData();
    // 使用真正选中的index来刷新数组
    _refreshDataSource();
  }

  /// 设置默认无选中项的时候默认选择index
  void _configDefaultInitSelectIndex() {
    _firstIndex = _secondIndex = -1;
  }

  void _setFirstIndex(int firstIndex) {
    _firstIndex = firstIndex;
    _secondIndex = -1;
    if (widget.entity.children.length > _firstIndex) {
      List<SelectionEntity> seconds =
          widget.entity.children[_firstIndex].children;
      if (seconds.isNotEmpty) {
        for (SelectionEntity entity in seconds) {
          if (entity.isSelected) {
            _setSecondIndex(seconds.indexOf(entity));
            break;
          }
        }
      }
    }
    setState(() {
      _refreshDataSource();
    });
  }

  void _setSecondIndex(int secondIndex) {
    _secondIndex = secondIndex;
    setState(() {
      _refreshDataSource();
    });
  }

  /// 刷新3个ListView的数据源
  void _refreshDataSource() {
    _firstList = widget.entity.children;
    if (_firstIndex >= 0 && _firstList.length > _firstIndex) {
      _secondList = _firstList[_firstIndex].children;
    } else {
      _secondList = [];
    }
  }

  void _configDefaultSelectedData() {
    _firstList = widget.entity.children;
    //是否已选择的item里面有第一列的
    if (_firstList.isEmpty) {
      _secondIndex = -1;
      _secondList = [];
      return;
    }
    for (SelectionEntity entity in _firstList) {
      if (entity.isSelected) {
        _firstIndex = _firstList.indexOf(entity);
        break;
      }
    }

    if (_firstIndex >= 0 && _firstIndex < _firstList.length) {
      _secondList = _firstList[_firstIndex].children;
      if (_secondList.isNotEmpty) {
        for (SelectionEntity entity in _secondList) {
          if (entity.isSelected) {
            _secondIndex = _secondList.indexOf(entity);
            break;
          }
        }
      }
    }
  }

  /// 设置数据为未选中状态
  void _resetSelectionDatas(SelectionEntity entity) {
    entity.isSelected = false;
    entity.customMap = Map();
    for (SelectionEntity subEntity in entity.children) {
      _resetSelectionDatas(subEntity);
    }
  }

  void _clearNotTagItem(List<SelectionEntity> subFilterList) {
    subFilterList
        .where((f) =>
            f.filterType == SelectionFilterType.range ||
            f.filterType == SelectionFilterType.date ||
            f.filterType == SelectionFilterType.dateRange ||
            f.filterType == SelectionFilterType.dateRangeCalendar)
        .forEach((f) {
      f.isSelected = false;
      f.customMap = Map();
      f.value = null;
    });
  }

  void _clearEditRangeText() {
    _minTextEditingController.text = "";
    _maxTextEditingController.text = "";
    EventBus.instance.fire(ClearSelectionFocusEvent());
  }

  void _clearTagSelectStatus(List<SelectionEntity> subFilterList) {
    subFilterList
        .where((f) => f.filterType != SelectionFilterType.range)
        .where((f) => f.filterType != SelectionFilterType.date)
        .where((f) => f.filterType != SelectionFilterType.dateRange)
        .where((f) => f.filterType != SelectionFilterType.dateRangeCalendar)
        .forEach((f) {
      f.isSelected = false;
      f.customMap = Map();
    });
  }

  /// 获取针对 Range 类型进行value 检查。 DateRange、DateRangeCalendar 类型不需要检查，因为在选择时间的时候已经做了时间范围限制。
  SelectionEntity? _getSelectRangeItem(List<SelectionEntity> filterList) {
    List<SelectionEntity> ranges = filterList
        .where((f) =>
            (f.filterType == SelectionFilterType.range ||
                f.filterType == SelectionFilterType.dateRange ||
                f.filterType == SelectionFilterType.dateRangeCalendar) &&
            f.isSelected)
        .toList();

    if (ranges.isNotEmpty) {
      return ranges[0];
    }
    return null;
  }

  void _backgroundTap() {
    _resetSelectStatus();
    if (widget.bgClickFunction != null) {
      widget.bgClickFunction!();
    }
  }

  void _resetSelectStatus() {
    _clearAllSelectedItems();
    _resetCustomMapData();
  }

  ///数据还原
  void _resetCustomMapData() {
    for (SelectionEntity commonEntity in _originalSelectedItemsList) {
      commonEntity.isSelected = true;
      commonEntity.customMap = Map.from(commonEntity.originalCustomMap);
    }
  }

  /// 如果自定义输入和默认选中都没有，则尝试默认高亮【不限】这种类型的 Tag。
  int _getInitFocusedIndex(List<SelectionEntity> subFilterList) {
    bool isCustomInputSelected = false;
    for (SelectionEntity entity in subFilterList) {
      if (SelectionFilterType.range == entity.filterType ||
          SelectionFilterType.dateRange == entity.filterType ||
          SelectionFilterType.dateRangeCalendar == entity.filterType) {
        isCustomInputSelected = entity.isSelected;
        break;
      }
    }

    var selectedItem = subFilterList
        .where((f) =>
            f.filterType != SelectionFilterType.range &&
            f.filterType != SelectionFilterType.dateRange &&
            f.filterType != SelectionFilterType.dateRangeCalendar &&
            f.isSelected)
        .toList();
    if (!isCustomInputSelected && PhoenixTools.isEmpty(selectedItem)) {
      for (SelectionEntity item in subFilterList) {
        if (item.isUnLimit()) {
          return subFilterList.indexOf(item);
        }
      }
    }

    return -1;
  }

  bool _hasCalendarItem(SelectionEntity entity) {
    bool hasCalendarItem = false;
    hasCalendarItem = entity.children
        .where((_) =>
            _.filterType == SelectionFilterType.date ||
            _.filterType == SelectionFilterType.dateRangeCalendar)
        .toList()
        .isNotEmpty;

    /// 查找第二层级
    if (!hasCalendarItem) {
      for (SelectionEntity subItem in entity.children) {
        int count = subItem.children
            .where((_) =>
                _.filterType == SelectionFilterType.date ||
                _.filterType == SelectionFilterType.dateRangeCalendar)
            .toList()
            .length;
        if (count > 0) {
          hasCalendarItem = true;
          break;
        }
      }
    }
    return hasCalendarItem;
  }
}
