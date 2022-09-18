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
  //都道府県一覧
  final List prefectures = [
    "北海道",
    "015000",
    "青森県",
    "020000",
    "秋田県",
    "050000",
    "岩手県",
    "030000",
    "宮城県",
    "040000",
    "宮城県",
    "060000",
    "宮城県",
    "070000",
    "茨城県",
    "080000",
    "栃木県",
    "090000",
    "群馬県",
    "100000",
    "埼玉県",
    "110000",
    "東京都",
    "130000",
    "千葉県",
    "120000",
    "神奈川県",
    "140000",
    "長野県",
    "200000",
    "山梨県",
    "210000",
    "静岡県",
    "220000",
    "愛知県",
    "230000",
    "岐阜県",
    "210000",
    "三重県",
    "240000",
    "新潟県",
    "150000",
    "富山県",
    "160000",
    "石川県",
    "170000",
    "福井県",
    "180000",
    "滋賀県",
    "250000",
    "京都府",
    "260000",
    "大阪府",
    "270000",
    "兵庫県",
    "280000",
    "奈良県",
    "290000",
    "和歌山",
    "300000",
    "岡山県",
    "330000",
    "広島県",
    "340000",
    "島根県",
    "320000",
    "鳥取県",
    "310000",
    "徳島県",
    "360000",
    "香川県",
    "370000",
    "愛媛県",
    "380000",
    "高知県",
    "390000",
    "山口県",
    "350000",
    "福岡県",
    "400000",
    "佐賀県",
    "410000",
    "長崎県",
    "420000",
    "熊本県",
    "430000",
    "大分県",
    "440000",
    "宮崎県",
    "450000",
    "鹿児島県",
    "460100",
    "沖縄県",
    "471000",
  ];

  String description = "";

  // 始めに一度だけ実行される
  @override
  void initState() {
    super.initState();

    _wetherGet();
  }

  Future<void> _wetherGet() async {
    // ユーザーの選択から都道府県コードを取得
    String prefectureCode = prefectures[prefectures.indexOf(widget.region) + 1];

    // APIのURL
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
    bool isRainy = description.contains("雨");
    bool isCloudy = description.contains("曇り");
    return Column(children: [
      const Text(
        "この地域のお天気情報",
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
