import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/organization.dart';

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
    } else if (type == Const.typeBadge) {
      return getAnswerRatio();
    } else if (type == Const.typeServicesPerson) {
      return (Injector.customerValueData.totalCustomerCapacity -
                  Injector.customerValueData.remainingCustomerCapacity)
              .toString() +
          "/" +
          Injector.customerValueData.totalCustomerCapacity.toString();
    } else
      return "0/0";
  }

  static double getProgressInt(int type) {
    if (type == Const.typeSalesPersons) {
      return getProgressValue(Const.typeSales);
    } else if (type == Const.typeEmployee) {
      return getProgressValue(Const.typeHR);
    } else if (type == Const.typeBadge) {
      return getBonusValue();
    } else if (type == Const.typeServicesPerson) {
      return getCustomerCapacityRatio();
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
      int totalEmployee = getTotalValue(organizationType) * 10;
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
      return ((Injector.customerValueData.correctAnswerCount /
                  Injector.customerValueData.totalAttemptedQuestion) *
              100)
          .toStringAsFixed(2);
    } else
      return "0%";
  }

  static double getCustomerCapacityRatio() {
    double val = Injector.customerValueData.totalCustomerCapacity != null &&
            Injector.customerValueData.totalCustomerCapacity != 0
        ? (Injector.customerValueData.totalCustomerCapacity -
                Injector.customerValueData.remainingCustomerCapacity) /
            Injector.customerValueData.totalCustomerCapacity
        : 0;

    if (val >= 0 || val <= 1) {
      return val;
    } else {
      return 0.0;
    }
  }

  static double getBonusValue() {
    return (Injector.customerValueData.correctAnswerCount /
                    Injector.customerValueData.totalAttemptedQuestion) >=
                0 &&
            (Injector.customerValueData.correctAnswerCount /
                    Injector.customerValueData.totalAttemptedQuestion) <=
                1
        ? (Injector.customerValueData.correctAnswerCount /
            Injector.customerValueData.totalAttemptedQuestion)
        : 0.0;
  }

  static int getOccupiedValue(int organizationType) {
    if (organizationType == Const.typeEmployee) {
      return Injector.customerValueData.totalEmployeeCapacity -
          Injector.customerValueData.remainingEmployeeCapacity;
    } else if (organizationType == Const.typeSales) {
      return Injector.customerValueData.totalSalesPerson -
          Injector.customerValueData.remainingSalesPerson;
    } else if (organizationType == Const.typeServices) {
      return Injector.customerValueData.totalCustomerCapacity -
          Injector.customerValueData.remainingCustomerCapacity;
    } else
      return 0;
  }

  static int getTotalValue(int organizationType) {
    if (organizationType == Const.typeEmployee) {
      return Injector.customerValueData.totalEmployeeCapacity;
    } else if (organizationType == Const.typeSales) {
      return Injector.customerValueData.totalSalesPerson;
    } else if (organizationType == Const.typeServices) {
      return Injector.customerValueData.totalCustomerCapacity;
    } else
      return 0;
  }
}
