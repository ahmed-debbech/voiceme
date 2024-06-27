import 'package:flutter/material.dart';
import 'package:voiceme/logic/Shared.dart';
import 'package:voiceme/parts/VoiceComposer.dart';
import 'package:voiceme/parts/ListMessages.dart';

void main() {
  pre();
  runApp(const MyApp());
}

void pre() async {
  WidgetsFlutterBinding.ensureInitialized();
  Shared d = Shared();
  if (await d.isFirstLaunch()) {
    int p = d.generatePin();
    print(p);
    d.storePin(p);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice Me',
      darkTheme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(title: 'Voice Me'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 134, 142),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListMessages(),
            Padding(padding: EdgeInsets.all(10), child: VoiceComposer()),
          ],
        ),
      ),
    );
  }
}
