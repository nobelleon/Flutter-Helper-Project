import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Changing State',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PickerRole(
              type: PickerType.sledge,
            ),
            PickerRole(
              type: PickerType.reverse,
            ),
            PickerRole(
              type: PickerType.drop,
            ),
            PickerRole(
              type: PickerType.setting,
            ),
          ],
        ),
      ),
    );
  }
}

enum PickerType { sledge, reverse, drop, setting, none }

class PickerRole extends StatefulWidget {
  final PickerType type;
  const PickerRole({
    super.key,
    required this.type,
  });

  @override
  State<PickerRole> createState() => _PickerRoleState();
}

class _PickerRoleState extends State<PickerRole> {
  var picker = PickerType.none;

  @override
  void initState() {
    super.initState();
    picker = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      // color: Colors.green,
      height: 60,
      width: MediaQuery.sizeOf(context).width * 0.75,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Center(
                  child: Text('Sigil'),
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => setState(() {
                        picker = PickerType.sledge;
                      }),
                      icon: const Icon(
                        Icons.sledding,
                      ),
                    ),
                    Container(
                      color: picker == PickerType.sledge
                          ? Colors.blue
                          : Colors.transparent,
                      height: 2,
                      width: 50,
                      margin: EdgeInsets.zero,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => setState(() {
                        picker = PickerType.reverse;
                      }),
                      icon: const Icon(
                        Icons.swap_horiz,
                      ),
                    ),
                    Container(
                      color: picker == PickerType.reverse
                          ? Colors.blue
                          : Colors.transparent,
                      height: 2,
                      width: 50,
                      margin: EdgeInsets.zero,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => setState(() {
                        picker = PickerType.drop;
                      }),
                      icon: const Icon(
                        Icons.water_drop,
                      ),
                    ),
                    Container(
                      color: picker == PickerType.drop
                          ? Colors.blue
                          : Colors.transparent,
                      height: 2,
                      width: 50,
                      margin: EdgeInsets.zero,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => setState(() {
                        picker = PickerType.setting;
                      }),
                      icon: const Icon(
                        Icons.settings,
                      ),
                    ),
                    Container(
                      color: picker == PickerType.setting
                          ? Colors.blue
                          : Colors.transparent,
                      height: 2,
                      width: 50,
                      margin: EdgeInsets.zero,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Divider(
              height: 0,
              color: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }
}
