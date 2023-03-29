import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'providers/weather_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyWeatherApp()));
}

class MyWeatherApp extends StatelessWidget {
  const MyWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      home: MyHomePage(title: 'Väder appen'),
      debugShowCheckedModeBanner: false,
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
    );
  }
}

class MyHomePage extends ConsumerWidget {

  final String title;
  final RefreshController _refreshController = 
    RefreshController(initialRefresh: false);

  MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  void _onRefresh(WidgetRef ref) async {
    // monitor network fetch
    // await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    ref.read(weatherNotifier.notifier).reload();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }

  // final moviesProvider = StateNotifierProvider<WeatherNotifier, WeatherState>((ref) => WeatherNotifier());
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      /*appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      */
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const WaterDropHeader(),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        //child: SingleChildScrollView(
        controller: _refreshController,
        onRefresh: () => {_onRefresh(ref)},
        onLoading: _onLoading,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).

            children: const <Widget>[
              WeatherWidget(),
              /*
            ref.watch(weatherDatetimeFutureProvivder).when(
              error: (_, trace) {
                return const Center(
                  child: Text('Error'),
                );
              },
              loading: () {
                return Column(
                  children: const [
                     Text("Laddar väder"),
                     CircularProgressIndicator.adaptive()
                  ],
                );
              },
              data: (WeatherDatetime data) {
                return Text("Temperaturen vid Turning Torso är nu ${data.airTemperature ?? 'Jaj veeet inte'}");
              },
            ),
            */
            ],
          ),
        ),
        //),
      ),
/*
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          // ref.read(counterProvider.notifier).increment()
        },
        child: const Icon(Icons.add),
      ),
      */ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class WeatherWidget extends ConsumerWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(weatherNotifier).when(data: (wdt) {
      return Text("From weather widget ${wdt.airTemperature} temp");
    }, error: (Object error, StackTrace stackTrace) {
      return const Text("Error");
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
  }
}
