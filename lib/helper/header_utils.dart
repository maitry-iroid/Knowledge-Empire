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
//    if()

    if (type == Const.typeSalesPersons) {
      return getProgressText(Const.typeSales);
    } else if (type == Const.typeEmployee) {
      return getTotalEmployee();
    } else if (type == Const.typeBadge) {
      return getAnswerRatio();
    } else if (type == Const.typeServicesPerson) {
      return getProgressText(Const.typeServices);
    } else
      return "0/0";
  }

  static double getProgressInt(int type) {
    if (type == Const.typeSalesPersons) {
      return getProgressValue(Const.typeSales);
    } else if (type == Const.typeEmployee) {
      return getProgressValue(Const.typeHR);
    } else if (type == Const.typeBadge) {
      return 0.0;
    } else if (type == Const.typeServicesPerson) {
      return getProgressValue(Const.typeServices);
    } else
      return 0.0;
  }

  static getProgressValue(int organizationType) {
    if (Injector.customerValueData != null) {
      List<Organization> arrOrganization =
          Injector.customerValueData.organization;

      int totalEmployee = Injector.customerValueData.totalEmployeeCapacity;
      int remainingCapacity = arrOrganization
          .where((organization) => (organization.type == organizationType))
          .toList()[0]
          .employeeCount;

      if (remainingCapacity != null && totalEmployee != null) {
        double value =
            (remainingCapacity / (totalEmployee == 0 ? 1 : totalEmployee))
                .toDouble();
        return value > 1 ? 1.0 : value.abs().toDouble();
      } else {
        return 0.0;
      }
    } else {
      return 0.0;
    }
  }

  static getProgressText(int organizationType) {
    if (Injector.customerValueData != null) {
      List<Organization> arrOrganization =
          Injector.customerValueData.organization;

      int totalEmployee = arrOrganization
              .where((organization) => (organization.type == organizationType))
              .toList()[0]
              .level *
          10;
      int remainingCapacity = arrOrganization
          .where((organization) => (organization.type == organizationType))
          .toList()[0]
          .employeeCount;

      if (remainingCapacity != null && totalEmployee != null) {
        return remainingCapacity.toString() + "/" + totalEmployee.toString();
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
      return Injector.customerValueData.employeeCount.toString() +
          "/" +
          Injector.customerValueData.totalEmployeeCapacity.toString();
    } else
      return "";
  }

  static getAnswerRatio() {
    if (Injector.customerValueData != null &&
        Injector.customerValueData.totalCorrectAnswer != null &&
        Injector.customerValueData.totalAttemptedQuestion != null &&
        Injector.customerValueData.totalAttemptedQuestion != 0) {
      return ((Injector.customerValueData.totalCorrectAnswer /
                  Injector.customerValueData.totalAttemptedQuestion) *
              100)
          .toString();
    } else
      return "0%";
  }
}
