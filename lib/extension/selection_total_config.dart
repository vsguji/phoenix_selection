import 'package:phoenix_base/phoenix.dart';

import '../config/selection_config.dart';
import 'selection_default_config_utils.dart';

class SelectionTotalConfig extends BaseTotalConfig {
  SelectionTotalConfig({SelectionConfig? selectionConfig})
      : _selectionConfig = selectionConfig;

  SelectionConfig? _selectionConfig;

  SelectionConfig get selectionConfig =>
      _selectionConfig ?? BaseSelectionConfigUtils.defaultSelectionConfig;

  @override
  void initThemeConfig(String configId) {
    super.initThemeConfig(configId);
    _selectionConfig ??= SelectionConfig();
    selectionConfig.initThemeConfig(
      configId,
      currentLevelCommonConfig: commonConfig,
    );
  }
}

extension BaseSelectionTotalConfig on BaseTotalConfig {
  ///
  static SelectionConfig? _selectionConfig;
  SelectionConfig get selectionConfig =>
      _selectionConfig ?? BaseSelectionConfigUtils.defaultSelectionConfig;
  set pickerTotalConfig(SelectionTotalConfig config) {
    _selectionConfig = config.selectionConfig;
  }
}
