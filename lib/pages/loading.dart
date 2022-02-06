import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/services/word_time.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = "loading";

  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  setupWorldTime() async {
    WorldTime instance = WorldTime(
      url: 'Africa/Lagos',
      location: "Lagos",
      flag: "nigeria.png",
    );
    await instance.getData();
    Navigator.pushNamed(context, HomePage.id, arguments: {
      "location": instance.location,
      "flag": instance.flag,
      "time": instance.time,
      "isDayTime": instance.isDayTime,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: const Padding(
        padding: EdgeInsets.all(50),
        child: Center(
          child: SpinKitFadingCube(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
