import 'dart:developer';

import 'package:async/async.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

RestartableTimer? timer;

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        return Material(
          child: InkWell(
            onTap: () => timer?.reset(),
            child: const MyHomePage(
              title: 'With Material.router',
            ),
          ),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Material(
        child: InkWell(
          onTap: () => timer?.reset(),
          child: const MyHomePage(
            title: 'With Material',
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  AppLifecycleState? _lastLifecycleState;
  int kTimeoutInSeconds = const Duration(seconds: 5).inSeconds;
  String text = 'Alive';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _lastLifecycleState = WidgetsBinding.instance.lifecycleState;
    _keepAlive(false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (_lastLifecycleState == AppLifecycleState.resumed &&
        state == AppLifecycleState.paused) {
      _keepAlive(true);
    } else if (_lastLifecycleState == AppLifecycleState.paused &&
        state == AppLifecycleState.resumed) {
      _keepAlive(false);
    }

    _lastLifecycleState = state;
  }

  void _keepAlive(bool visible) {
    if (visible) {
      timer?.cancel();
    } else {
      timer = RestartableTimer(Duration(seconds: kTimeoutInSeconds), () {
        // Do whatever the fuck you want, like logging a user out
        text = 'Logged out';
        log('LOGGED OUT');
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
