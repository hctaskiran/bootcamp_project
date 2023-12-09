import 'package:bootcamp_project/core/enum/language_enum.dart';
import 'package:googleapis/places/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

class Application {
  // api
  static String apiKey = "YOUR_API_KEY_HERE";

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
