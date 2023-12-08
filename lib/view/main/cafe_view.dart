import 'package:bootcamp_project/components/place_build.dart';
import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/constants/sized_box.dart';
import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:bootcamp_project/model/place_models.dart';
import 'package:bootcamp_project/services/location_services.dart';
import 'package:bootcamp_project/services/place_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CafeView extends StatefulWidget {
  const CafeView({super.key});

  @override
  State<CafeView> createState() => _CafeViewState();
}

class _CafeViewState extends State<CafeView> {
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
              )
            ],
          ),
          SB.h15,
          Expanded(
            child: PlaceListBuild(
                nearbyPlaces: nearbyPlaces,
                isLoading: isLoading,
                isError: isError,
                onRetry: () {
                  setState(() {
                    isLoading = true;
                    isError = false;
                  });
                  _initializeMap();
                }),
          ),
        ],
      ),
    );
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

  Future<void> _fetchNearbyPlaces(double rlat, double rlong) async {
    try {
      final places = await PlacesService().searchNearbyPlaces(
        rlat,
        rlong,
        'cafe',
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
