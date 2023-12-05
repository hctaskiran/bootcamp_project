// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, unnecessary_this

String base = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=";
String apiKey = "AIzaSyAxy81E8S_k6JqdLkXz3Z67rTJw4BcZ9RQ";

extension PlaceImgExt on String {
  String toImg() {
    // Find the index of "/photos/"
    int index = this.indexOf("/photos/");

    if (index != -1) {
      // Extract the substring after "/photos/"
      String photoReference = this.substring(index + "/photos/".length);

      // Use the extension method to construct the complete URL
      String imageUrl = photoReference.toImg();

      // Print the result
      print(imageUrl);
    } else {
      print("Invalid input, '/photos/' not found");
    }

    return base + this + '&key=$apiKey';
  }
}
