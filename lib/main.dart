import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/models/layout_model.dart';

import 'auth/set-homeserver-url/screens/set_homeserver_url.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LayoutModel()),
    ],
    child: const ReceiptWrangler(),
  ));
}

class ReceiptWrangler extends StatelessWidget {
  const ReceiptWrangler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var layoutModel = Provider.of<LayoutModel>(context, listen: true);

    return Scaffold(
      appBar: layoutModel.displayAppBar
          ? AppBar(
              title: Text(layoutModel.appBarTitle),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            )
          : null,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[SetHomeserverUrl(title: "hello?")],
        ),
      ),
    );
  }
}
