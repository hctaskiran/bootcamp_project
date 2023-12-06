String baseURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=";
String apiKey = "AIzaSyAxy81E8S_k6JqdLkXz3Z67rTJw4BcZ9RQ";

extension PlaceImgExt on String {
  String toImg() {
    int index = indexOf("/photos/");

    if (index != -1) {
      String photoReference = substring(index + "/photos/".length);
      return "$baseURL$photoReference&key=$apiKey";
    } else {
      print("Invalid input, '/photos/' not found");
      return this;
    }
  }
}
