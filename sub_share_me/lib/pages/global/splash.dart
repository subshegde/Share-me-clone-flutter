import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sub_share_me/constants/app_colors.dart';
import 'package:sub_share_me/pages/home/pages/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Map<String, List<AssetEntity>> groupedAssets = {};
  @override
  void initState() {
    super.initState();
    requestPermission().then((value){
      if(value == true){
        load().then((value){
          if(value == true){
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home(grouped: groupedAssets,)),
          );
          }
        });
      }
    });
  }

Future<bool> requestPermission() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    bool storageGranted = true;
    bool videosGranted = true;
    bool photosGranted = true;

    // Check permissions for Android 13 and above
    if (androidInfo.version.sdkInt >= 33) {
      videosGranted = await Permission.videos.isGranted;
      photosGranted = await Permission.photos.isGranted;
    } else {
      storageGranted = await Permission.storage.isGranted;
    }

    if (storageGranted && videosGranted && photosGranted) {
      return true;
    } else {
      print("Storage or media permissions denied on Android");
      return false;
    }
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    bool storageGranted = await Permission.storage.isGranted;

    if (storageGranted) {
      return true;
    } else {
      print("Storage permission denied on iOS");
      return false;
    }
  }

  return false;
}


Future<bool> load() async {
  try {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.all);

    if (albums.isEmpty) {
      print('No albums found.');
      return false;
    }

    // only 100
    List<AssetEntity> allAssets = await albums[0].getAssetListPaged(page: 0, size: 100);

    //all 
    //  int assetCount = await albums[0].assetCountAsync;
    //  List<AssetEntity> allAssets = await albums[0].getAssetListRange(start: 0, end: assetCount);

    // Sort assets by creation date
    allAssets.sort((a, b) => b.createDateTime!.compareTo(a.createDateTime!));;

    // Group assets by their creation date
    Map<String, List<AssetEntity>> grouped = {};
    for (var asset in allAssets) {
      String formattedDate = asset.createDateTime != null
          ? '${asset.createDateTime!.year}-${asset.createDateTime!.month}-${asset.createDateTime!.day}'
          : 'Unknown Date';

      if (!grouped.containsKey(formattedDate)) {
        grouped[formattedDate] = [];
      }
      grouped[formattedDate]!.add(asset);
    }

    setState(() {
      groupedAssets = grouped;
    });

    return true; 
  } catch (e) {
    print('Error loading assets: $e');
    return false;
  }
}



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bg,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/shareme.png',
                scale: 2.2,
              ),
              const SizedBox(height: 20),
              const Text(
                'ShareMe',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'Share files without connecting to the internet',
                style: TextStyle(
                  color: AppColors.grey500Color,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
