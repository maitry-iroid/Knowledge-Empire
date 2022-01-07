class AppConfig {
  static FlavorConfig devConfig() {
    return FlavorConfig(webUrl: "https://knowledge-empire.com:7003/api", appName: "Knowledge Empire");//Client Development
    // return FlavorConfig(webUrl: "https://knowledge-empire.com:7001/api/", appName: "Knowledge Empire");//Client Production
  }

  static FlavorConfig prodConfig() {
    return FlavorConfig(webUrl: "https://knowledge-empire.com:7003/api", appName: "Knowledge Empire");//Client Development
    // return FlavorConfig(webUrl: "https://knowledge-empire.com:7001/api", appName: "Knowledge Empire");//Client Production
  }
}

class FlavorConfig {
  String appName;
  String webUrl;

  FlavorConfig({this.appName, this.webUrl});
}
