import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class CountNotifier extends StateNotifier<int> {
  CountNotifier() : super(0);

  void incrementCount() {
    state += 1;
  }
}

class FakeModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  FakeModel({
    required this.category,
    required this.description,
    required this.id,
    required this.image,
    required this.price,
    required this.title,
  });

  static FakeModel fromJson(Map<String, dynamic> data) {
    return FakeModel(
      category: data['category'],
      description: data['description'],
      id: data['id'],
      image: data['image'],
      price: data['price'],
      title: data['title'],
    );
  }
}

var countProvider = StateProvider((ref) => 0);

var countProvider2 =
    StateNotifierProvider<CountNotifier, int>((ref) => CountNotifier());

var fetchProvider = FutureProvider((ref) => getFromStore());

Future<FakeModel> getFromStore() async {
  var dio = Dio();
  final response = await dio.get('https://fakestoreapi.com/products/1');
  return FakeModel.fromJson(response.data);
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer(builder: (context, ref, _) {
              var fakeModel = ref.watch(fetchProvider);

              return fakeModel.when(
                data: (value) => Column(
                  children: [
                    Image.network(
                      value.image,
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      value.title,
                    ),
                    Text(
                      value.description,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      value.description,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                error: (error, trace) => Text('$trace'),
                loading: () => const CircularProgressIndicator.adaptive(),
              );
            }),
            Consumer(builder: (context, ref, _) {
              var count = ref.watch(countProvider);
              var count2 = ref.watch(countProvider2);
              return Column(
                children: [
                  Text(
                    '$count',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    '$count2',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              ref.read(countProvider.notifier).state += 1;
              ref.read(countProvider2.notifier).incrementCount();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () => getFromStore(),
            tooltip: 'Increment',
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
