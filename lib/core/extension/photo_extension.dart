String baseURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=";
String apiKey = "YOUR_API_KEY_HERE";

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
