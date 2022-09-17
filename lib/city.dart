import 'package:flutter/material.dart';
import 'google_map_api.dart';

class City extends StatelessWidget {
  const City({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff66B6C0),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: StaticMapView(),
          )
        ],
      ),
      backgroundColor: const Color(0xff66B6C0),
    );
  }
}

class StaticMapView extends StatelessWidget {
  static const _baseMapURL = 'https://maps.googleapis.com/maps/api/staticmap';
  static const _latitude = 35.667097;
  static const _longitude = 139.740178;
  static const _mapType = 'maptype=satellite';
  static const _mapZoom = 'zoom=16';
  static const _mapSize = 'size=720x640';
  static const _scale = 'scale=2';
  static const _language = 'language=ja';
  static const _mapCenter = 'center=$_latitude,$_longitude';
  static const _mapMarkers = 'markers=$_latitude,$_longitude';
  static const _apiKey = 'key=${ApiKey.googleApi}';
  static const _imageUrl =
      '$_baseMapURL?$_mapCenter&$_mapZoom&$_mapMarkers&$_mapType&$_mapSize&$_scale&$_language&$_apiKey';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Image.network(
          _imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}