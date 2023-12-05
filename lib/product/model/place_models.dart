// ignore_for_file: file_names

import 'dart:convert';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Place data) => json.encode(data.toJson());

class Place {
  List<PlaceElement> places;

  Place({
    required this.places,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        places: List<PlaceElement>.from(json["places"].map((x) => PlaceElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "places": List<dynamic>.from(places.map((x) => x.toJson())),
      };
}

class PlaceElement {
  List<String> types;

  String? nationalPhoneNumber;

  String id;

  String formattedAddress;

  DisplayName displayName;

  double? rating;

  String businessStatus;

  Location location;

  List<Photo> photos;

  PlaceElement({
    required this.types,
    required this.nationalPhoneNumber,
    required this.id,
    required this.formattedAddress,
    required this.displayName,
    required this.rating,
    required this.businessStatus,
    required this.location,
    required this.photos,
  });

  factory PlaceElement.fromJson(Map<String, dynamic> json) => PlaceElement(
        types: List<String>.from(json["types"].map((x) => x)),
        nationalPhoneNumber: json["nationalPhoneNumber"],
        id: json["id"],
        formattedAddress: json["formattedAddress"],
        displayName: DisplayName.fromJson(json["displayName"]),
        rating: json["rating"]?.toDouble(),
        businessStatus: json["businessStatus"],
        location: Location.fromJson(json["location"]),
        photos: (json["photos"] as List<dynamic>?)?.map((x) => Photo.fromJson(x)).toList() ?? [],
      );

  factory PlaceElement.fromMap(Map<String, dynamic> map) => PlaceElement(
        types: List<String>.from(map["types"].map((x) => x)),
        nationalPhoneNumber: map["nationalPhoneNumber"],
        id: map["id"],
        formattedAddress: map["formattedAddress"],
        displayName: DisplayName.fromJson(map["displayName"]),
        rating: map["rating"]?.toDouble(),
        businessStatus: map["businessStatus"],
        location: Location.fromJson(map["location"]),
        photos: (map["photos"] as List<dynamic>?)?.map((x) => Photo.fromMap(x)).toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        "types": List<dynamic>.from(types.map((x) => x)),
        "nationalPhoneNumber": nationalPhoneNumber,
        "id": id,
        "formattedAddress": formattedAddress,
        "displayName": displayName.toJson(),
        "rating": rating,
        "location": location.toJson(),
        "businessStatus": businessStatus,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };

  Map<String, dynamic> toMap() {
    return {
      "types": List<dynamic>.from(types.map((x) => x)),
      "nationalPhoneNumber": nationalPhoneNumber,
      "id": id,
      "formattedAddress": formattedAddress,
      "displayName": displayName.toJson(),
      "rating": rating,
      "location": location.toJson(),
      "businessStatus": businessStatus,
      "photos": List<dynamic>.from(photos.map((x) => x.toMap())),
    };
  }
}

class DisplayName {
  String text;

  String languageCode;

  DisplayName({
    required this.text,
    required this.languageCode,
  });

  factory DisplayName.fromJson(Map<String, dynamic> json) => DisplayName(
        text: json["text"],
        languageCode: json["languageCode"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "languageCode": languageCode,
      };
}

class Location {
  double latitude;

  double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Photo {
  String name;

  int widthPx;

  int heightPx;

  List<AuthorAttribution>? authorAttributions;

  Photo({
    required this.name,
    required this.widthPx,
    required this.heightPx,
    required this.authorAttributions,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        name: json["name"],
        widthPx: json["widthPx"],
        heightPx: json["heightPx"],
        authorAttributions:
            List<AuthorAttribution>.from(json["authorAttributions"].map((x) => AuthorAttribution.fromJson(x))),
      );

  factory Photo.fromMap(Map<String, dynamic> map) => Photo(
        name: map["name"],
        widthPx: map["widthPx"],
        heightPx: map["heightPx"],
        authorAttributions:
            List<AuthorAttribution>.from(map["authorAttributions"].map((x) => AuthorAttribution.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "widthPx": widthPx,
        "heightPx": heightPx,
        "authorAttributions": List<dynamic>.from(authorAttributions!.map((x) => x.toJson())),
      };

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "widthPx": widthPx,
      "heightPx": heightPx,
      "authorAttributions": List<dynamic>.from(authorAttributions!.map((x) => x.toMap())),
    };
  }
}

class AuthorAttribution {
  String displayName;

  String uri;

  String photoUri;

  AuthorAttribution({
    required this.displayName,
    required this.uri,
    required this.photoUri,
  });

  factory AuthorAttribution.fromJson(Map<String, dynamic> json) => AuthorAttribution(
        displayName: json["displayName"],
        uri: json["uri"],
        photoUri: json["photoUri"],
      );

  factory AuthorAttribution.fromMap(Map<String, dynamic> map) => AuthorAttribution(
        displayName: map["displayName"],
        uri: map["uri"],
        photoUri: map["photoUri"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "uri": uri,
        "photoUri": photoUri,
      };

  Map<String, dynamic> toMap() {
    return {
      "displayName": displayName,
      "uri": uri,
      "photoUri": photoUri,
    };
  }
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
