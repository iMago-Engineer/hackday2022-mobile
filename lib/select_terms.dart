import 'package:flutter/material.dart';

class SelectTerms extends StatelessWidget {
  const SelectTerms({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const SizedBox(child: MainPage(title: '見つけld'));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainState();
}

class _MainState extends State<MainPage> {
  // void _incrementCounter() {
  //   setState(() {});
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   while(true){
  //   }
  // }

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
            _Rain(),
            _TemperatureHight(),
            _TemperatureLow(),
            _Security(),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xff66B6C0),
                  shape: const StadiumBorder(),
                  fixedSize: const Size(double.maxFinite, 40)),
              child: const Text(
                "検索",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Rain extends StatefulWidget {
  @override
  State<_Rain> createState() => _RainState();
}

//メモ：フロントで返す値を逆にする（5は雨が降る方が良い、になってる）
class _RainState extends State<_Rain> {
  var rain = 0.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
        ));
  }
}

class _TemperatureHight extends StatefulWidget {
  @override
  State<_TemperatureHight> createState() => _TemperatureHightState();
}

//メモ：フロントで返す値を逆にする（5は雨が降る方が良い、になってる）
class _TemperatureHightState extends State<_TemperatureHight> {
  var temperatureHight = 0.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
        ));
  }
}

class _TemperatureLow extends StatefulWidget {
  @override
  State<_TemperatureLow> createState() => _TemperatureLowState();
}

//メモ：フロントで返す値を逆にする（5は雨が降る方が良い、になってる）
class _TemperatureLowState extends State<_TemperatureLow> {
  var temperatureLow = 0.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
        child: Column(
          children: [
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
          ],
        ));
  }
}

class _Security extends StatefulWidget {
  @override
  State<_Security> createState() => _SecurityState();
}

//メモ：フロントで返す値を逆にする（5は雨が降る方が良い、になってる）
class _SecurityState extends State<_Security> {
  var security = 0.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
        ));
  }
}
