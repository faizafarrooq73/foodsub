import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_sub/services/sharedpref_service.dart';
import 'package:food_sub/ui/common/app_colors.dart';
import 'package:food_sub/ui/common/ui_helpers.dart';

import '../app_strings.dart';
import '../uihelper/text_helper.dart';

void showdetails(BuildContext context, SharedprefService sharedpref){
  showDialog(context: context, builder: (BuildContext context){
    return Dialog(
      child: Container(
        width: screenWidth(context),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: sharedpref.readString('img'),
                  imageBuilder: (context, imageProvider) => Container(
                    width: screenWidthCustom(context, 0.2),
                    height: screenWidthCustom(context, 0.2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: kcDarkGreyColor,
                  ),
                ),
              ),
            ),
            verticalSpaceLarge,
            rowd("Name", sharedpref.readString('name')),
            rowd("Number", sharedpref.readString('number')),
            rowd("Cnic", sharedpref.readString('cnic')),
            rowd("Address", sharedpref.readString('address')),
            rowd("DOB", sharedpref.readString('dob')),
          ],
        ),
      ),
    );
  });
}

Widget rowd(String title, String des){
  return Row(
    children: [
      text_helper(
          data: title,
          font: openSans,
          color: kcDarkGreyColor,
          bold: true,
          size: fontSize14),
      horizontalSpaceSmall,
      text_helper(
          data: des,
          font: openSans,
          color: kcDarkGreyColor,
          size: fontSize14),
    ],
  );
}