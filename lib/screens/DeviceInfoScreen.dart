import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';


class DeviceInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DeviceInfoState();
  }

}

class _DeviceInfoState extends State<DeviceInfoScreen>{
  static final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  String _operationSystemName = 'unknown operation system';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<Null> initPlatformState() async {
    Map<String, dynamic> deviceData;

    try {
      if (Platform.isIOS) {
        deviceData = _getIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
      else if (Platform.isAndroid) {
        deviceData = _getAndroidDeviceInfo(await deviceInfoPlugin.androidInfo);
      }
      else {
        deviceData = <String, dynamic> {
          'platform.name': Platform.operatingSystemVersion,
          'info': 'Information of this platform is not awailable yet'
        };
      }
    } on PlatformException catch (e) {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
      _operationSystemName = Platform.isAndroid ? 'Android' : 'iOS';
    });

  }


  Map<String, dynamic> _getAndroidDeviceInfo(AndroidDeviceInfo data) {
    return <String, dynamic> {
      'version.securityPatch': data.version.securityPatch,
      'version.sdkInt': data.version.sdkInt,
      'version.release': data.version.release,
      'version.previewSdkInt': data.version.previewSdkInt,
      'version.incremental': data.version.incremental,
      'version.codename': data.version.codename,
      'version.baseOS': data.version.baseOS,
      'board': data.board,
      'bootloader': data.bootloader,
      'brand': data.brand,
      'device': data.device,
      'display': data.display,
      'fingerprint': data.fingerprint,
      'hardware': data.hardware,
      'host': data.host,
      'id': data.id,
      'manufacturer': data.manufacturer,
      'model': data.model,
      'product': data.product,
      'supported32BitAbis': data.supported32BitAbis,
      'supported64BitAbis': data.supported64BitAbis,
      'supportedAbis': data.supportedAbis,
      'tags': data.tags,
      'type': data.type,
      'isPhysicalDevice': data.isPhysicalDevice,
    };
  }

  Map<String, dynamic> _getIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic> {
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(_operationSystemName)),
      body: new Container(child: _createListBox(),),
      bottomNavigationBar: new Container(
        child: new RaisedButton(
            child: Text('return back'),
            onPressed: () => Navigator.pop(context)
        ),
      ),

    );
  }

  ListView _createListBox() {
    return new ListView(
      shrinkWrap: true,
      children: _deviceData.keys.map(
        (String key) {
          return new Row(
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.all(10.0),
                child: new Text(
                  key,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              new Expanded(
                  child: new Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: new Text(
                      '${_deviceData[key]}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
            ],
          );
        }
      ).toList(),
    );
  }
}