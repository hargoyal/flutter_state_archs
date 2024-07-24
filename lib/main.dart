import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:revs_flutter/Blocs/BlocHomePage.dart';
import 'package:revs_flutter/Futures/FutureHomePage.dart';
import 'package:revs_flutter/Providers/ProviderHomePage.dart';
import 'package:revs_flutter/Streams/StreamsHomePage.dart';

import 'Blocs/counter_bloc.dart';
import 'Providers/CounterNotifier.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => CounterBloc()..add(FetchInitialCounterValue()),
        ),
        ChangeNotifierProvider(
          create: (context) => CounterNotifier(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
        // the application has a purple toolbar. Then, without quitting the app,
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> stateList = [];

  @override
  void initState() {
    stateList.add("Futures");
    stateList.add("Streams");
    stateList.add("Providers");
    stateList.add("Blocs");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return listItem(index);
              })),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget listItem(int index) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => FutureHomePage()));
            break;
          case 1:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => StreamHomePage()));
            break;
          case 2:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => ProviderHomePage()));
            break;
          case 3:
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => BlocHomePage()));
            break;
        }
      },
      child: ListTile(
        title: Text(stateList[index]),
        trailing: const Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
