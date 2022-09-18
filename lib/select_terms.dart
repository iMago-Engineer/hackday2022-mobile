import 'package:flutter/material.dart';
import 'package:hackday2022/city.dart';

class SelectTerms extends StatelessWidget {
  final String region;
  // ignore: use_key_in_widget_constructors
  const SelectTerms({required this.region});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: MainPage(
      title: '見つけld',
      region: region,
    ));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title, required this.region});

  final String title;
  final String region;

  @override
  State<MainPage> createState() => _MainState();
}

class _MainState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xff66B6C0),
        centerTitle: false,
        title: const Text(
          "見つけld",
          style: TextStyle(fontSize: 24),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 24,
            ),
            const Text(
              "それぞれの選択肢でのあなたの重要度を示してください。\n\n右に行く程重要度を高いと見做します。",
              style: TextStyle(color: Color.fromARGB(255, 112, 112, 112)),
            ),
            const SizedBox(
              height: 32,
            ),
            _SelectComponent(
              region: widget.region,
            )
          ],
        ),
      ),
    );
  }
}

class _SelectComponent extends StatefulWidget {
  const _SelectComponent({required this.region});
  final String region;
  @override
  State<_SelectComponent> createState() => _SelectComponentState();
}

class _SelectComponentState extends State<_SelectComponent> {
  // バー用の変数
  double rain = 0.0;
  double temperatureHight = 0.0;
  double temperatureLow = 0.0;
  double security = 0.0;
  // サーバーに送る用の保存用変数
  double rainValue = 0.0;
  double temperatureHightValue = 0.0;
  double temperatureLowValue = 0.0;
  double securityValue = 0.0;

  // 値をサーバーに適した形にする関数+送信もかねている
  // ボタンを押したときに実行するようになっている
  //　APIとの繋ぎで使用する
  void valueChanged() {
    if (rain == 0.0) {
      rainValue = 5.0;
    } else if (rain == 1.0) {
      rainValue = 4.0;
    } else if (rain == 2.0) {
      rainValue = 3.0;
    } else if (rain == 3.0) {
      rainValue = 2.0;
    } else if (rain == 4.0) {
      rainValue = 1.0;
    } else if (rain == 5.0) {
      rainValue = 0.0;
    }
    if (temperatureHight == 0.0) {
      temperatureHightValue = 5.0;
    } else if (temperatureHight == 1.0) {
      temperatureHightValue = 4.0;
    } else if (temperatureHight == 2.0) {
      temperatureHightValue = 3.0;
    } else if (temperatureHight == 3.0) {
      temperatureHightValue = 2.0;
    } else if (temperatureHight == 4.0) {
      temperatureHightValue = 1.0;
    } else if (temperatureHight == 5.0) {
      temperatureHightValue = 0.0;
    }

    if (temperatureLow == 0.0) {
      temperatureLowValue = 5.0;
    } else if (temperatureLow == 1.0) {
      temperatureLowValue = 4.0;
    } else if (temperatureLow == 2.0) {
      temperatureLowValue = 3.0;
    } else if (temperatureLow == 3.0) {
      temperatureLowValue = 2.0;
    } else if (temperatureLow == 4.0) {
      temperatureLowValue = 1.0;
    } else if (temperatureLow == 5.0) {
      temperatureLow = 0.0;
    }
    if (security == 0.0) {
      securityValue = 5.0;
    } else if (security == 1.0) {
      securityValue = 4.0;
    } else if (security == 2.0) {
      securityValue = 3.0;
    } else if (security == 3.0) {
      securityValue = 2.0;
    } else if (security == 4.0) {
      securityValue = 1.0;
    } else if (security == 5.0) {
      securityValue = 0.0;
    }
    debugPrint(rainValue.toString());
    debugPrint(temperatureHightValue.toString());
    debugPrint(temperatureLowValue.toString());
    debugPrint(securityValue.toString());
    debugPrint(widget.region);

    setState(() {});

    // 遷移させる
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => City(
                region: widget.region,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "雨が降らない方が良い",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Slider(
                    value: rain,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    activeColor: const Color(0xff66B6C0),
                    onChanged: (double value) {
                      setState(() {
                        rain = value.roundToDouble();
                      });
                    }),
              ],
            )),
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "昼間の気温は高くない方が良い",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Slider(
                    value: temperatureHight,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    activeColor: const Color(0xff66B6C0),
                    onChanged: (double value) {
                      setState(() {
                        temperatureHight = value.roundToDouble();
                      });
                    }),
              ],
            )),
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
            child: Column(children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "夜の気温は低くない方が良い",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Slider(
                  value: temperatureLow,
                  min: 0,
                  max: 5,
                  divisions: 5,
                  activeColor: const Color(0xff66B6C0),
                  onChanged: (double value) {
                    setState(() {
                      temperatureLow = value.roundToDouble();
                    });
                  }),
            ])),
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "治安が悪くない方が良い",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Slider(
                    value: security,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    activeColor: const Color(0xff66B6C0),
                    onChanged: (double value) {
                      setState(() {
                        security = value.roundToDouble();
                      });
                    }),
              ],
            )),
        const SizedBox(height: 24),
        ElevatedButton(
            onPressed: valueChanged,
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff66B6C0),
                shape: const StadiumBorder(),
                fixedSize: const Size(double.maxFinite, 40)),
            child: const Text(
              "検索",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}

class Response {
  Response({required this.city, required this.location, required this.pref});

  String city;
  String location;
  String pref;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        city: json['city'] as String,
        location: json['location'] as String,
        pref: json['pref'] as String,
      );
}
