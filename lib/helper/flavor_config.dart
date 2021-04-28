class AppConfig {
  static FlavorConfig devConfig() {
    return FlavorConfig(webUrl: "https://knowledge-empire.com:7003/api", appName: "Knowledge Empire");
  }

  static FlavorConfig prodConfig() {
    return FlavorConfig(webUrl: "https://knowledge-empire.com:7001/api", appName: "Knowledge Empire");
  }

  static FlavorConfig devV2Config() {
    return FlavorConfig(webUrl: "https://knowledge-empire.com:7003/api", appName: "Knowledge Empire");
  }

  static FlavorConfig prodV2Config() {
    return FlavorConfig(webUrl: "https://knowledge-empire.com:7001/api", appName: "Knowledge Empire");
  }
}

class FlavorConfig {
  String appName;
  String webUrl;


  FlavorConfig({this.appName, this.webUrl});
}