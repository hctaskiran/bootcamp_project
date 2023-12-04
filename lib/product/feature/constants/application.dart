import 'package:bootcamp_project/product/feature/enum/language_enum.dart';
import 'package:googleapis/places/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

class Application {
  // api
  static String apiKey = "AIzaSyAxy81E8S_k6JqdLkXz3Z67rTJw4BcZ9RQ";

  static final PlacesApi placesApi = PlacesApi(client);

  static final client = clientViaApiKey(Application.apiKey);

  // others
  String autoCompleteURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json";

  static const Languages language = Languages.english;

  static const Iterable<Languages> supportedLanguages = Languages.values;

  static const ApplicationPaths paths = ApplicationPaths();
}

class ApplicationPaths {
  const ApplicationPaths();
  final String translation = 'assets/translations';
  final String images = 'assets/images';
}