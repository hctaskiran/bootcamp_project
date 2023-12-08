import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/constants/sized_box.dart';
import 'package:bootcamp_project/extension/photo_extension.dart';
import 'package:bootcamp_project/model/place_models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget PlaceDetailsModal(BuildContext context, PlaceElement place) {
  String notFound = 'assets/img/not_found.png';


  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.8,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Divider(
            color: CColor.black,
            thickness: 3,
            indent: MediaQuery.of(context).size.width * 0.35,
            endIndent: MediaQuery.of(context).size.width * 0.35,
          ),
          SB.h10,
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: place.photos.isNotEmpty
                ? CachedNetworkImage(
                    height: MediaQuery.of(context).size.height * 0.3,
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
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    place.rating.toString(),
                    style: TextStyle(fontSize: 20, color: CColor.black),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: CColor.red,
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
                    Icons.location_on_outlined,
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
              SB.h40,
              Row(
                children: [
                  Icon(
                    Icons.phone_forwarded_outlined,
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
                            place.nationalPhoneNumber != null ? place.nationalPhoneNumber.toString() : 'Not Founded',
                            style: place.nationalPhoneNumber != null
                                ? TextStyle(fontSize: 16, color: CColor.black)
                                : TextStyle(color: CColor.red, fontSize: 16)),
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
  );
}
