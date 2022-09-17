import 'package:flutter/material.dart';

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

//TODO：フロントで返す値を逆にする（5は雨が降る方が良い、になってる）
class _SelectComponentState extends State<_SelectComponent> {
  double rain = 0.0;
  double temperatureHight = 0.0;
  double temperatureLow = 0.0;
  double security = 0.0;

  // 最初に一度だけ実行される
  // 始めの値が0か確認している
  @override
  void initState() {
    super.initState();
    valueChanged();
  }

  // 値が変わったかどうか確認する関数
  // ボタンを押したときに実行するようになっている
  //　APIとの繋ぎで使用する
  void valueChanged() {
    debugPrint(rain.toString());
    debugPrint(temperatureHight.toString());
    debugPrint(temperatureLow.toString());
    debugPrint(security.toString());
    debugPrint(widget.region);
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
