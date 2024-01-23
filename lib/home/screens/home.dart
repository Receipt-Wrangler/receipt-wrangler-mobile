import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_wrangler_mobile/auth/set-homeserver-url/screens/set_homeserver_url.dart';
import 'package:receipt_wrangler_mobile/models/layout_model.dart';

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
