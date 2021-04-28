import 'package:flutter/cupertino.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/constant.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';

class VersionManager {
  /*
  *           IMPORTANT
  * We introduced the "App version", so that we have a reference we can use to have a common understanding which version we are talking about.
  * The versioning could work like this:
  * "A-BBB-C Version: XXX.YYY-ZZZ"
  * A is replaced with P for Productive, T for Testing (which we do not have at the moment) and D for Development.
  * BBB is replaced if we have customer specific versions. Standard is BES (for Blue Elephants Solutions)
  * C is replaced with the target operating system (I for iOS and A for Android). is this enough or should we have more coding for the operating system
  * (e.g. in case of mayor changes of operating system and we need to have different versions ready for different operating systems?
  * X= is version numbering for mayor releases. Currently 000. Once we have a version to really go live with it will be 001.
  * Y= For bigger updated (e.g. new features implemented). Falls back to 000 when X goes up by one
  * Z= for smaller updates and bug fixes. Falls back to 000 when Y goes up by one.
  * */

  static String getVersion(BuildContext context) {
    String mode = getMode();
    String customerSpecificVersion = "BES"; //Blue Elephants Solutions
    String os = Injector.deviceType == "ios" ? "I" : "A";

    String x = "001";
    String y = "003";
    String z = "000";

    return mode + "-" + customerSpecificVersion + "-" + os + " ${Utils.getText(context, StringRes.strVersion)}: " + x + "." + y + "-" + z;
  }

  static String getMode() {
    if(Const.envType == Environment.DEV)
      return "D";
    else if(Const.envType == Environment.PROD)
      return "P";
    else if(Const.envType == Environment.DEV_V2)
      return "D-V2";
    else if(Const.envType == Environment.PROD_V2)
      return "P-V2";
    else
      return "D";
  }

}
