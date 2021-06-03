import 'package:knowledge_empire/helper/string_res.dart';

enum ModuleOptions{
  finance,
  marketing,
  sales,
  management,
  product
}

extension ModuleOptionsExtension on ModuleOptions {

  // ignore: missing_return
  String get title {
    switch (this) {
      case ModuleOptions.finance:         return "Finance";
      case ModuleOptions.marketing:       return "Marketing";
      case ModuleOptions.sales:           return "Sales";
      case ModuleOptions.management:      return "Management";
      case ModuleOptions.product:         return "Product";
    }
  }

  // ignore: missing_return
  double get progressValue {
    switch (this) {
      case ModuleOptions.finance:         return 0.5;
      case ModuleOptions.marketing:       return 0.2;
      case ModuleOptions.sales:           return 0.4;
      case ModuleOptions.management:      return 0.7;
      case ModuleOptions.product:         return 0.8;
    }
  }

}