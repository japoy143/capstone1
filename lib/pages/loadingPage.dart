import 'package:capstoneapp1/pages/addusername.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../components/loadingsreen1.dart';

class loadingPage extends StatefulWidget {
  const loadingPage({super.key});

  @override
  State<loadingPage> createState() => _loadingPageState();
}

class _loadingPageState extends State<loadingPage>
    with SingleTickerProviderStateMixin {
  //loading animation
  static const spinkit = SpinKitFadingFour(
    color: Colors.green,
    size: 50.0,
  );
  @override
  void initState() {
    super.initState();
    //fullscreen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => AddUsername()));
    });
  }

  // to reset
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    super.dispose();
  }

  LoadingScreen1 _loading = LoadingScreen1();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 200,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ..._loading.title
                    .map((titles) => _loading.titleList(context, titles))
                    .toList(),
              ],
            ),
          ),
          Text(
            'woodpicker',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(
            height: 150.0,
          ),
          Container(
            child: spinkit,
          )
        ],
      ),
    );
  }
}
