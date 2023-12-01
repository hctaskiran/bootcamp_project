import 'package:bootcamp_project/product/enum/language_enum.dart';

class Application {
  static String apiKey = "AIzaSyAxy81E8S_k6JqdLkXz3Z67rTJw4BcZ9RQ";

  static const Languages language = Languages.english;

  static const Iterable<Languages> supportedLanguages = Languages.values;

  static const ApplicationPaths paths = ApplicationPaths();
}

class ApplicationPaths {
  const ApplicationPaths();
  final String translation = 'assets/translations';
  final String images = 'assets/images';
}
