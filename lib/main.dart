import 'package:flutter/material.dart';

import 'package:hands_on_app/settings_screen.dart';
import 'package:hands_on_app/weather_response_model.dart';
import 'package:hands_on_app/weather_service.dart';

enum ProgressStatus {
  initializing,
  notAnswered,
  answered,
  error,
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '明日の東京の天気クイズ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProgressStatus _progressStatus = ProgressStatus.initializing;
  bool? _isCorrect;
  late Weather _tokyoWeather;

  Future<void> _fetchTokyoWeather() async {
    try {
      _tokyoWeather = await WeatherService().fetchTomorrowWeather('130010');
      // print(_tokyoWeather.description["bodyText"]);
      setState(() {
        _progressStatus = ProgressStatus.notAnswered;
      });
    } catch (e) {
      setState(() {
        _progressStatus = ProgressStatus.error;
      });
    }
  }

  @override
  void initState() {
    _fetchTokyoWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SettingsScreen();
                },
              ),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: _mainContent(),
        ),
      ),
    );
  }

  Widget _mainContent() {
    if (_progressStatus == ProgressStatus.initializing) {
      return const CircularProgressIndicator();
    } else if (_progressStatus == ProgressStatus.notAnswered) {
      return _notAnsweredWidget();
    } else if (_progressStatus == ProgressStatus.answered) {
      return _answeredWidget();
    }
    return const Text(
      'なんらかのエラーがおきました',
      style: TextStyle(
        locale: Locale('ja'),
      ),
    );
  }

  Widget _notAnsweredWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            '明日の天気は？',
            style: TextStyle(
              locale: Locale('ja'),
              fontSize: 30,
            ),
          ),
        ),
        _answerButton(
          '晴れ',
          Colors.orange,
          () {
            setState(() {
              _isCorrect = _tokyoWeather.forecasts[1]["telop"].contains('晴');
              _progressStatus = ProgressStatus.answered;
            });
          },
        ),
        _answerButton(
          'くもり',
          Colors.grey,
          () {
            setState(() {
              _isCorrect = _tokyoWeather.forecasts[1]["telop"].contains('曇');
              _progressStatus = ProgressStatus.answered;
            });
          },
        ),
        _answerButton(
          '雨',
          Colors.blueAccent,
          () {
            setState(() {
              _isCorrect = _tokyoWeather.forecasts[1]["telop"].contains('雨');
              _progressStatus = ProgressStatus.answered;
            });
          },
        ),
        _answerButton(
          'その他',
          Colors.lightBlueAccent,
          () {
            setState(() {
              _isCorrect = !_tokyoWeather.forecasts[1]["telop"].contains('晴') &&
                  !_tokyoWeather.forecasts[1]["telop"].contains('曇') &&
                  !_tokyoWeather.forecasts[1]["telop"].contains('雨');
              _progressStatus = ProgressStatus.answered;
            });
          },
        ),
      ],
    );
  }

  Widget _answeredWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: _isCorrect!
              ? const Text(
                  '正解！',
                  style: TextStyle(
                    locale: Locale('ja'),
                    fontSize: 30,
                    color: Colors.red,
                  ),
                )
              : const Text(
                  '不正解',
                  style: TextStyle(
                    locale: Locale('ja'),
                    fontSize: 30,
                    color: Colors.blueAccent,
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            '明日の天気は　' + _tokyoWeather.forecasts[1]["telop"],
            style: const TextStyle(
              locale: Locale('ja'),
              fontSize: 26,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            _tokyoWeather.description["bodyText"] as String,
            style: const TextStyle(
              locale: Locale('ja'),
              fontSize: 16,
            ),
          ),
        ),
        _answerButton(
          'クイズに戻る',
          Colors.lightBlueAccent,
          () {
            setState(() {
              _isCorrect = null;
              _progressStatus = ProgressStatus.notAnswered;
            });
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _answerButton(
    String text,
    Color color,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: 200, //横幅
        height: 50, //高さ
        child: ElevatedButton(
          child: Text(
            text,
            style: const TextStyle(
              locale: Locale('ja'),
              fontSize: 24,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: color,
            onPrimary: Colors.black,
            elevation: 16,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
