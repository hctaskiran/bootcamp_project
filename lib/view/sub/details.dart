import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/constants/sized_box.dart';
import 'package:bootcamp_project/extension/photo_extension.dart';
import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:bootcamp_project/model/place_models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget PlaceDetailsModal(BuildContext context, PlaceElement place) {
  String notFound = 'assets/img/not_found.png';

  return SizedBox(
    height: MediaQuery.of(context).size.height,
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: place.photos.isNotEmpty
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: PlaceImgExt(place.photos[0].name).toImg(),
                    )
                  : Image.asset(notFound),
            ),
            SB.h20,
            Text(
              place.displayName.text,
              style: TextStyle(fontSize: 20, color: CColor.black),
            ),
            SB.h20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: CColor.gry300,
                  child: Text(
                    "${LocaleKeys.details_rating.tr()}: ${place.rating.toString()}",
                    style: TextStyle(fontSize: 16, color: CColor.black),
                  ),
                ),
                Container(
                  color: CColor.gry300,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border_outlined,
                      color: CColor.red,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SB.h40,
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: CColor.black,
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: CColor.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            place.formattedAddress,
                            style: TextStyle(fontSize: 16, color: CColor.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
