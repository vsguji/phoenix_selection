import 'bean/selection_common_entity.dart';

class SelectionEntityListBean {
  List<SelectionEntity>? list;

  SelectionEntityListBean(this.list);

  static SelectionEntityListBean? fromJson(Map<String, dynamic>? map) {
    if (map == null || map['list'] == null) return null;
    SelectionEntityListBean bean = SelectionEntityListBean(null);
    bean.list =
        (map['list'] as List).map((o) => SelectionEntity.fromMap(o)).toList();
    return bean;
  }
}
