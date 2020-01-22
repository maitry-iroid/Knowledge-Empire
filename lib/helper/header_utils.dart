import 'package:ke_employee/injection/dependency_injection.dart';

import 'constant.dart';

class HeaderUtils {
  static String getHeaderIcon(int type) {
    if (type == Const.typeSalesPersons)
      return "ic_sales_header";
    else if (type == Const.typeEmployee)
      return "ic_people";
    else if (type == Const.typeBadge)
      return "ic_badge";
    else if (type == Const.typeServicesPerson)
      return "ic_resourses";
    else if (type == Const.typeDollar)
      return "ic_dollar";
    else
      return "";
  }

  static getProgress(int type) {
    if (type == Const.typeSalesPersons) {
      return getProgressText(type);
    } else if (type == Const.typeEmployee) {
      return getProgressText(type);
    }  else if (type == Const.typeServicesPerson) {
      return getProgressText(type);
    }else if (type == Const.typeBadge) {
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
    } else if (type == Const.typeBadge) {
      return getBonusValue();
    } else
      return 0.0;
  }

  static getProgressValue(int organizationType) {
    if (Injector.customerValueData != null) {
      int totalEmployee = getTotalValue(organizationType);
      int remainingCapacity = getOccupiedValue(organizationType);

      if (remainingCapacity != null && totalEmployee != null) {
        double value =
            (remainingCapacity / (totalEmployee == 0 ? 1 : totalEmployee))
                .toDouble();
        return value <= 1 || value >= 0 ? value : 0.0;
      } else {
        return 0.0;
      }
    } else {
      return 0.0;
    }
  }

  static getProgressText(int organizationType) {
    if (Injector.customerValueData != null) {
      int totalEmployee = getTotalValue(organizationType)??0 * 10;
      int remainingCapacity = getOccupiedValue(organizationType);

      if (remainingCapacity != null && totalEmployee != null) {
        return getOccupiedValue(organizationType).toString() +
            "/" +
            getTotalValue(organizationType).toString();
      } else {
        return "0/0";
      }
    } else {
      return "0/0";
    }
  }

  static getTotalEmployee() {
//    return "";

    if (Injector.customerValueData != null) {
      return Injector.customerValueData.remainingEmployeeCapacity.toString() +
          "/" +
          Injector.customerValueData.totalEmployeeCapacity.toString();
    } else
      return "";
  }

  static getAnswerRatio() {
    if (Injector.customerValueData != null &&
        Injector.customerValueData.correctAnswerCount != null &&
        Injector.customerValueData.totalAttemptedQuestion != null &&
        Injector.customerValueData.totalAttemptedQuestion != 0) {
      return ((Injector.customerValueData.correctAnswerCount??0 /
                  Injector.customerValueData.totalAttemptedQuestion) *
              100)
          .toStringAsFixed(2);
    } else
      return "0%";
  }

  static double getBonusValue() {
    return (Injector.customerValueData.correctAnswerCount??0 /
                    Injector.customerValueData.totalAttemptedQuestion) >=
                0 &&
            (Injector.customerValueData.correctAnswerCount??0 /
                    Injector.customerValueData.totalAttemptedQuestion) <=
                1
        ? (Injector.customerValueData.correctAnswerCount??0 /
            Injector.customerValueData.totalAttemptedQuestion)
        : 0.0;
  }

  static int getOccupiedValue(int organizationType) {
    try {
      if (organizationType == Const.typeEmployee) {
            return Injector.customerValueData.totalEmployeeCapacity??0 -
                Injector.customerValueData.remainingEmployeeCapacity;
          } else if (organizationType == Const.typeSalesPersons) {
            return Injector.customerValueData.totalSalesPerson??0 -
                Injector.customerValueData.remainingSalesPerson;
          } else if (organizationType == Const.typeServicesPerson) {
            return Injector.customerValueData.totalCustomerCapacity??0 -
                Injector.customerValueData.remainingCustomerCapacity;
          } else
            return 0;
    } catch (e) {
      print(e);
    }
    return 0;
  }

  static int getTotalValue(int organizationType) {
    if (organizationType == Const.typeEmployee) {
      return Injector.customerValueData.totalEmployeeCapacity??0;
    } else if (organizationType == Const.typeSalesPersons) {
      return Injector.customerValueData.totalSalesPerson??0;
    } else if (organizationType == Const.typeServicesPerson) {
      return Injector.customerValueData.totalCustomerCapacity??0;
    } else
      return 0;
  }
}
