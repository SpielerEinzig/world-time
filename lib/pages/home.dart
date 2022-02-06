import 'package:flutter/material.dart';
import 'package:world_time/pages/choose_location.dart';

class HomePage extends StatefulWidget {
  static const String id = "homePage";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor = data["isDayTime"] ? Colors.blue : Colors.indigo;

    return Scaffold(
      backgroundColor: bgColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic result =
              await Navigator.pushNamed(context, ChooseLocation.id);
          setState(() {
            data = {
              "time": result["time"],
              "location": result["location"],
              "isDayTime": result["isDayTime"],
              "flag": result["flag"],
            };
          });
        },
        child: const Icon(Icons.edit_location),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data["location"],
                      style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  data["time"],
                  style: const TextStyle(
                    fontSize: 66,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
