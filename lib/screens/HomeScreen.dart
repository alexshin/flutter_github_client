import 'package:flutter/material.dart';
import 'DeviceInfoScreen.dart';


class HomeScreen extends StatelessWidget {

  final DeviceInfoScreen _deviceInfoScreen = DeviceInfoScreen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text('Home screen')
        ),
        body: GridView.count(
          crossAxisCount: 3,
          children: <Widget>[
            _createImageButton(Icons.device_unknown, _deviceInfoScreen, context),
            _createImageButton(Icons.info, _deviceInfoScreen, context),
            _createImageButton(Icons.insert_emoticon, _deviceInfoScreen, context),
          ],
        )
    );
  }

  Widget _createImageButton(IconData icon, Widget goto, BuildContext context) {
    return new Center(
        child: new IconButton(
          icon: Icon(icon, size: 32.0,),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => goto)
            );
          }
        )
    );
  }
}