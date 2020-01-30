import 'package:ke_employee/injection/dependency_injection.dart';

import 'constant.dart';

class HeaderUtils {
  static String getHeaderIcon(int type) {
    if (type == Const.typeSalesPersons)
      return "ic_sales_header";
    else if (type == Const.typeEmployee)
      return "ic_people";
    else if (type == Const.typeBrandValue)
      return "ic_badge";
    else if (type == Const.typeServicesPerson)
      return "ic_resourses";
    else if (type == Const.typeMoney)
      return "ic_dollar";
    else
      return "";
  }

  static getProgress(int type) {
    if (type == Const.typeSalesPersons) {
      return getProgressText(type);
    } else if (type == Const.typeEmployee) {
      return getProgressText(type);
    } else if (type == Const.typeServicesPerson) {
      return getProgressText(type);
    } else if (type == Const.typeBrandValue) {
      return getAnswerRatio();
    } else
      return "0/0";
  }

  static double getProgressInt(int type) {
    if (type == Const.typeSalesPersons) {
      return getProgressValue(type);
    } else if (type == Const.typeEmployee) {
      return getProgressValue(type);
    } else if (type == Const.typeServicesPerson) {
      return getProgressValue(type);
    } else if (type == Const.typeBrandValue) {
      return getBonusValue();
    } else
      return 0.0;
  }

  static getProgressValue(int organizationType) {
    int totalEmployee = getTotalValue(organizationType);
    int remainingCapacity = getRemainingValue(organizationType);

    double value = ((remainingCapacity ?? 0) / (totalEmployee ?? 1)).toDouble();

    print(value.toString());

    return value <= 1 || value >= 0 ? value : 0.0;
  }

  static String getProgressText(int organizationType) {
    return (getRemainingValue(organizationType)?.toString() ?? "0") +
        "/" +
        (getTotalValue(organizationType)?.toString() ?? "0");
  }

  static getTotalEmployee() {
    return (Injector.customerValueData?.remainingEmployeeCapacity?.toString() ??
            "0") +
        "/" +
        (Injector.customerValueData?.totalEmployeeCapacity?.toString() ?? "0");
  }

  static getAnswerRatio() {
    return ((Injector.customerValueData?.correctAnswerCount ?? 0) /
            (Injector.customerValueData?.totalAttemptedQuestion == null ||
                    Injector.customerValueData?.totalAttemptedQuestion == 0
                ? 1
                : Injector.customerValueData?.totalAttemptedQuestion) *
            100)
        .toStringAsFixed(2);
  }

  static double getBonusValue() {
    try {
      double value = (Injector.customerValueData?.correctAnswerCount ?? 0) /
          ((Injector.customerValueData?.totalAttemptedQuestion == null ||
                  Injector.customerValueData?.totalAttemptedQuestion == 0)
              ? 1
              : Injector.customerValueData?.totalAttemptedQuestion);

      value = (value / 10);

      return value <= 1 || value >= 0 ? value : 0.0;
    } catch (e) {
      print("getBonusValue_" + e.toString());
      return 0.0;
    }
  }

  static int getRemainingValue(int organizationType) {
    try {
      if (organizationType == Const.typeEmployee) {
        return Injector.customerValueData?.remainingEmployeeCapacity ?? 0;
      } else if (organizationType == Const.typeSalesPersons) {
        return Injector.customerValueData?.remainingSalesPerson ?? 0;
      } else if (organizationType == Const.typeServicesPerson) {
        return Injector.customerValueData?.remainingCustomerCapacity ?? 0;
      } else
        return 0;
    } catch (e) {
      print("getRemainingValue_" + e.toString());
    }
    return 0;
  }

  static int getTotalValue(int organizationType) {
    if (organizationType == Const.typeEmployee) {
      return Injector.customerValueData.totalEmployeeCapacity ?? 0;
    } else if (organizationType == Const.typeSalesPersons) {
      return Injector.customerValueData.totalSalesPerson ?? 0;
    } else if (organizationType == Const.typeServicesPerson) {
      return Injector.customerValueData.totalCustomerCapacity ?? 0;
    } else
      return 0;
  }
}
