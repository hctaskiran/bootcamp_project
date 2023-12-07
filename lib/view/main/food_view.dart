// ignore_for_file: avoid_print

import 'package:bootcamp_project/components/data_not_found.dart';
import 'package:bootcamp_project/components/shimmer.dart';
import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/constants/sized_box.dart';
import 'package:bootcamp_project/extension/photo_extension.dart';
import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:bootcamp_project/model/place_models.dart';
import 'package:bootcamp_project/services/location_services.dart';
import 'package:bootcamp_project/services/place_services.dart';
import 'package:bootcamp_project/view/sub/details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FoodView extends StatefulWidget {
  const FoodView({Key? key}) : super(key: key);

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  double lat = 0;
  double long = 0;
  List<PlaceElement> nearbyPlaces = [];
  bool isLoading = true;
  bool isError = false;
  String notFound = 'assets/img/not_found.png';

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
          SB.h20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.help_outline,
                color: CColor.blue,
                size: 20,
              ),
              SB.w5,
              Text(
                LocaleKeys.info.tr(),
                style: TextStyle(color: CColor.gry600, fontSize: 12),
              ),
            ],
          ),
          SB.h15,
          Expanded(
            child: _placeBuild(),
          ),
        ],
      ),
    );
  }

  Widget _placeBuild() {
    if (isLoading) {
      return const ShimmerLoad();
    } else if (isError) {
      return DataNotFound(() {
        setState(() {
          isLoading = true;
          isError = false;
        });
        _initializeMap();
      });
    } else {
      return ListView.builder(
        itemCount: nearbyPlaces.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              tileColor: CColor.gry100,
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
                        : Image.asset(notFound)),
              ),
              title: Text(nearbyPlaces[index].displayName.text),
              subtitle: Text('${LocaleKeys.details_rating.tr()}: ${nearbyPlaces[index].rating.toString()}'),
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return PlaceDetailsModal(context, nearbyPlaces[index]);
                    });
              },
            ),
          );
        },
      );
    }
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
