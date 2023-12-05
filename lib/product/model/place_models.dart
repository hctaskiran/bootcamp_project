class PlaceModel {
  final double rating;
  final List<dynamic> photos;
  final String displayName;
  final String formattedAddress;
  final List<String> types;
  final Map<String, dynamic> location;
  final String id;
  final String nationalPhoneNumber;
  final String businessStatus;

  PlaceModel({
    required this.rating,
    required this.photos,
    required this.displayName,
    required this.formattedAddress,
    required this.types,
    required this.location,
    required this.id,
    required this.nationalPhoneNumber,
    required this.businessStatus,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      rating: json['rating'] ?? 0.0,
      photos: json['photos'] ?? [],
      displayName: json['displayName'] ?? '',
      formattedAddress: json['formattedAddress'] ?? '',
      types: List<String>.from(json['types'] ?? []),
      location: json['location'] ?? {},
      id: json['id'] ?? '',
      nationalPhoneNumber: json['nationalPhoneNumber'] ?? '',
      businessStatus: json['businessStatus'] ?? '',
    );
  }
}
