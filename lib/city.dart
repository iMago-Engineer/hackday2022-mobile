import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackday2022/main.dart';
import 'package:http/http.dart' as http;
import 'google_map_api.dart';

class City extends StatelessWidget {
  final String region;
  City({super.key, required this.region});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff66B6C0),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                    (route) => false);
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              region,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: StaticMapView(),
            ),
            _Wether(
              region: region,
            )
          ],
        ),
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

  const StaticMapView({Key? key}) : super(key: key);

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

class _Wether extends StatefulWidget {
  final String region;
  _Wether({required this.region});
  @override
  _WetherState createState() => _WetherState();
}

class _WetherState extends State<_Wether> {
  //??????????????????
  final List prefectures = [
    "?????????",
    "015000",
    "?????????",
    "020000",
    "?????????",
    "050000",
    "?????????",
    "030000",
    "?????????",
    "040000",
    "?????????",
    "060000",
    "?????????",
    "070000",
    "?????????",
    "080000",
    "?????????",
    "090000",
    "?????????",
    "100000",
    "?????????",
    "110000",
    "?????????",
    "130000",
    "?????????",
    "120000",
    "????????????",
    "140000",
    "?????????",
    "200000",
    "?????????",
    "210000",
    "?????????",
    "220000",
    "?????????",
    "230000",
    "?????????",
    "210000",
    "?????????",
    "240000",
    "?????????",
    "150000",
    "?????????",
    "160000",
    "?????????",
    "170000",
    "?????????",
    "180000",
    "?????????",
    "250000",
    "?????????",
    "260000",
    "?????????",
    "270000",
    "?????????",
    "280000",
    "?????????",
    "290000",
    "?????????",
    "300000",
    "?????????",
    "330000",
    "?????????",
    "340000",
    "?????????",
    "320000",
    "?????????",
    "310000",
    "?????????",
    "360000",
    "?????????",
    "370000",
    "?????????",
    "380000",
    "?????????",
    "390000",
    "?????????",
    "350000",
    "?????????",
    "400000",
    "?????????",
    "410000",
    "?????????",
    "420000",
    "?????????",
    "430000",
    "?????????",
    "440000",
    "?????????",
    "450000",
    "????????????",
    "460100",
    "?????????",
    "471000",
  ];

  String description = "";

  // ????????????????????????????????????
  @override
  void initState() {
    super.initState();

    _wetherGet();
  }

  Future<void> _wetherGet() async {
    // ?????????????????????????????????????????????????????????
    String prefectureCode = prefectures[prefectures.indexOf(widget.region) + 1];

    // API???URL
    final request = await http.get(Uri.parse(
        'https://www.jma.go.jp/bosai/forecast/data/overview_forecast/$prefectureCode.json'));
    if (request.statusCode == 200) {
      debugPrint(request.statusCode.toString());

      var json = const Utf8Decoder().convert(request.bodyBytes);
      var map = jsonDecode(json);
      var response = Response.fromJson(map);
      setState(() {
        description = response.text;
        debugPrint(description);
      });
    } else {
      debugPrint(request.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isRainy = description.contains("???");
    bool isCloudy = description.contains("??????");
    return Column(children: [
      const Text(
        "??????????????????????????????",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 8,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          children: [
            isCloudy
                ? const Icon(Icons.cloud)
                : isRainy
                    ? const Icon(Icons.umbrella)
                    : const Icon(Icons.sunny),
          ],
        ),
        const SizedBox(width: 24),
        SizedBox(
            width: 300,
            child: Text(
              description,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ))
      ])
    ]);
  }
}

class Response {
  Response({
    required this.headlineText,
    required this.text,
  });

  String headlineText;
  String text;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        headlineText: json['headlineText'] as String,
        text: json['text'] as String,
      );
}
