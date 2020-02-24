class AppConfig {
  static FlavorConfig devConfig() {
    return FlavorConfig(webUrl: "http://13.127.186.25:7000/api", appName: "KE dev");
  }

  static FlavorConfig prodConfig() {
    return FlavorConfig(webUrl: "http://18.141.132.109:7000/api", appName: "Ke prod");
  }
}

class FlavorConfig {
  String appName;
  String webUrl;

  FlavorConfig({this.appName, this.webUrl});
}
