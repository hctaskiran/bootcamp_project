// place_list_widget.dart

import 'package:bootcamp_project/components/data_not_found.dart';
import 'package:bootcamp_project/components/shimmer.dart';
import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/core/extension/photo_extension.dart';
import 'package:bootcamp_project/core/init/lang/locale_keys.g.dart';
import 'package:bootcamp_project/model/place_models.dart';
import 'package:bootcamp_project/view/details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PlaceListBuild extends StatelessWidget {
  final List<PlaceElement> nearbyPlaces;
  final bool isLoading;
  final bool isError;
  final Function onRetry;

  const PlaceListBuild({
    super.key,
    required this.nearbyPlaces,
    required this.isLoading,
    required this.isError,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ShimmerLoad();
    } else if (isError) {
      return DataNotFound(() {
        onRetry();
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
                      : Image.asset('assets/img/not_found.png'),
                ),
              ),
              title: Text(nearbyPlaces[index].displayName.text),
              subtitle: nearbyPlaces[index].businessStatus == 'OPERATIONAL'
                  ? Text(
                      LocaleKeys.placeStatus_open.tr(),
                      style: TextStyle(color: CColor.blue),
                    )
                  : nearbyPlaces[index].businessStatus == 'CLOSED_TEMPORARILY'
                      ? Text(
                          LocaleKeys.placeStatus_tempClosed.tr(),
                          style: TextStyle(color: CColor.orange),
                        )
                      : Text(
                          LocaleKeys.placeStatus_closed.tr(),
                          style: TextStyle(color: CColor.red),
                        ),
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return PlaceDetailsModal(context, nearbyPlaces[index]);
                  },
                );
              },
            ),
          );
        },
      );
    }
  }
}
