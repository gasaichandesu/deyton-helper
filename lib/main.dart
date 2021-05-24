import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Deyton Helper');
    setWindowMinSize(const Size(660, 900));
    setWindowMaxSize(const Size(660, 900));
  }

  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deyton Helper',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: DeytonHelper(title: 'Deyton Helper'),
    );
  }
}

class DeytonHelper extends StatefulWidget {
  DeytonHelper({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _DeytonHelperState createState() => _DeytonHelperState();
}

class _DeytonHelperState extends State<DeytonHelper> {
  final List<String> symbols = <String>[
    '±',
    'ε',
    'ξ',
    '—',
    'α',
    'ζ',
    'φ',
    '°C',
    'β',
    'η',
    'ψ',
    '≤',
    'γ',
    'θ',
    'ω',
    '≥',
    'δ',
    'λ',
    '•',
    'Δ',
    'μ',
    '·',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
        ),
        body: Container(
            child: Wrap(
          direction: Axis.vertical,
          children: [
            ...symbols
                .map((symbol) => Container(
                      margin: const EdgeInsets.all(20.0),
                      height: 80.0,
                      width: 110.0,
                      color: Colors.red,
                      child: MaterialButton(
                        color: Colors.indigoAccent,
                        height: 40.0,
                        onPressed: () => _copySymbol(symbol),
                        child: Text(symbol,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                    ))
                .toList(),
            Container(
              margin: const EdgeInsets.all(20.0),
              height: 80.0,
              width: 110.0,
              color: Colors.red,
              child: MaterialButton(
                color: Colors.indigoAccent,
                height: 40.0,
                onPressed: () => _showAboutDialog(context),
                child: Text('О программе',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              height: 80.0,
              width: 110.0,
              color: Colors.red,
              child: MaterialButton(
                color: Colors.indigoAccent,
                height: 40.0,
                onPressed: () => SystemNavigator.pop(),
                child: Text('Выход',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            )
          ],
        )) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void _copySymbol(String symbol) async {
    await Clipboard.setData(ClipboardData(text: symbol));

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Символ скопирован'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                height: 200.0,
                width: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deyton Helper',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('Работу выполнил Александр Краев'),
                    MaterialButton(
                      color: Colors.indigoAccent,
                      onPressed: () => Navigator.pop(context),
                      child: Text('Закрыть',
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                )),
          );
        });
  }
}
