class BaseUrl {
  static const String apiKey = "0c070c173d864fdab05b7107f954537c";
  static const String baseUrl = "https://newsapi.org/v2";

  static String semua =
      "$baseUrl/everything?q=indonesia&sortBy=publishedAt&apiKey=$apiKey";
  static String technology =
      "$baseUrl/top-headlines?category=technology&country=us&apiKey=$apiKey";
  static String internasional =
      "$baseUrl/top-headlines?category=general&apiKey=$apiKey";
  static String ekonomi =
      "$baseUrl/top-headlines?category=business&country=us&apiKey=$apiKey";
  static String olahraga =
      "$baseUrl/top-headlines?category=sports&country=us&apiKey=$apiKey";
  static String teknologi =
      "$baseUrl/top-headlines?category=technology&apiKey=$apiKey";
  static String hiburan =
      "$baseUrl/top-headlines?category=entertainment&country=us&apiKey=$apiKey";
  static String gayaHidup =
      "$baseUrl/top-headlines?category=health&country=us&apiKey=$apiKey";

  static String searchBase = "$baseUrl/everything?apiKey=$apiKey";
}
