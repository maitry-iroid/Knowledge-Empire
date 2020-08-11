class AppConfig {
  static FlavorConfig devConfig() {
//    return FlavorConfig(webUrl: "http://13.127.186.25:7000/api", appName: "KE dev");
//    return FlavorConfig(webUrl: "https://knowledge-empire.com:7003/api", appName: "KE dev");
    return FlavorConfig(webUrl: "https://knowledge-empire.com:7003/api", appName: "Knowledge Empire");
  }

  static FlavorConfig prodConfig() {
//    return FlavorConfig(webUrl: "http://18.141.132.109:7000/api", appName: "Knowledge Empire");
//    return FlavorConfig(webUrl: "http://knowledge-empire.com:7000/api", appName: "Knowledge Empire");
    return FlavorConfig(webUrl: "https://knowledge-empire.com:7001/api", appName: "Knowledge Empire");
  }
}

class FlavorConfig {
  String appName;
  String webUrl;


  FlavorConfig({this.appName, this.webUrl});
}