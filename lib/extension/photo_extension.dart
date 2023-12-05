String baseURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=";
String apiKey = "AIzaSyAxy81E8S_k6JqdLkXz3Z67rTJw4BcZ9RQ";

extension PlaceImgExt on String {
  String toImg() {
    // Find the index of "/photos/"
    int index = this.indexOf("/photos/");

    if (index != -1) {
      // Extract the substring after "/photos/"
      String photoReference = this.substring(index + "/photos/".length);

      // Construct the complete URL
      return  baseURL +"$photoReference&key=$apiKey";
    } else {
      print("Invalid input, '/photos/' not found");
      // If '/photos/' is not found, return the original string
      return this;
    }
  }
}

