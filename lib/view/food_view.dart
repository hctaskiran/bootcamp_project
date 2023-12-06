// ignore_for_file: unused_field, prefer_const_constructors

import 'package:bootcamp_project/extension/photo_extension.dart';
import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:bootcamp_project/model/place_models.dart';
import 'package:bootcamp_project/services/location_services.dart';
import 'package:bootcamp_project/services/place_services.dart';
import 'package:bootcamp_project/view/details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FoodView extends StatefulWidget {
  const FoodView({Key? key}) : super(key: key);

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  double lat = 0;
  double long = 0;
  final TextEditingController _searchController = TextEditingController();
  List<PlaceElement> nearbyPlaces = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    try {
      await LocationService().getCurrentLocation().then((value) {
        setState(() {
          lat = value.latitude;
          long = value.longitude;
        });
        _fetchNearbyPlaces(lat, long);
      });
    } catch (e) {
      print('Error initializing map: $e');
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildSearchBar(),
          const SizedBox(height: 10),
          Expanded(
            child: _placeBuild(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        onTap: () {},
        controller: _searchController,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          hintStyle: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
          hintText: LocaleKeys.search.tr(),
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _placeBuild() {
    if (isLoading) {
      return _shimmer();
    } else if (isError) {
      return _dataNotFound();
    } else {
      return ListView.builder(
        itemCount: nearbyPlaces.length,
        itemBuilder: (context, index) {
          return _placeBuildItem(index);
        },
      );
    }
  }

  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: SizedBox(
              width: 128,
              height: 64,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(color: Colors.white),
                ),
              ),
            ),
            title: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(height: 16, color: Colors.white),
            ),
            subtitle: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(height: 16, color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Widget _placeBuildItem(int index) {
    return ListTile(
      leading: SizedBox(
        width: 128,
        height: 64,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: nearbyPlaces[index].photos.isNotEmpty
                ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: PlaceImgExt(nearbyPlaces[index].photos[0].name).toImg(),
                  )
                : Image.asset('assets/img/not_found.png')),
      ),
      title: Text(nearbyPlaces[index].displayName.text),
      subtitle: Row(
        children: [
          Text('Rating: ${nearbyPlaces[index].rating.toString()}'),
          Spacer(),
          Icon(Icons.star, color: Colors.amber)
        ],
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PlaceDetails()));
      },
    );
  }

  Widget _dataNotFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: Colors.red,
            size: 40,
          ),
          const SizedBox(height: 10),
          Text(
            LocaleKeys.fails_failedData.tr(),
            style: TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isLoading = true;
                isError = false;
              });
              _initializeMap();
            },
            child: Text(LocaleKeys.fails_refreshButton.tr()),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchNearbyPlaces(double rlat, double rlong) async {
    try {
      final places = await PlacesService().searchNearbyPlaces(
        rlat,
        rlong,
        'restaurant',
      );
      if (places != null && places.containsKey('places')) {
        setState(() {
          nearbyPlaces = places['places'].map<PlaceElement>((place) => PlaceElement.fromJson(place)).toList();
          isLoading = false;
        });
      } else {
        print('Invalid response format');
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (e) {
      print('Exception: $e');
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }
}
