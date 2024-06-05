import 'package:careflix_parental_control/core/configuration/assets.dart';
import 'package:careflix_parental_control/core/configuration/styles.dart';
import 'package:careflix_parental_control/core/routing/route_path.dart';
import 'package:careflix_parental_control/core/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

class QrCoderRequest extends StatefulWidget {
  QrCoderRequest({super.key});

  @override
  State<QrCoderRequest> createState() => _QrCoderRequestState();
}

class _QrCoderRequestState extends State<QrCoderRequest> {
  Artboard? _qrArtboard;

  getData() async {
    final file = await RiveFile.asset(AssetsLink.QrCodeScanner);
    final artboard = file.mainArtboard;
    var controller = StateMachineController.fromArtboard(artboard, 'qr_scan');
    if (controller != null) {
      artboard.addController(controller);
    }
    artboard.forEachComponent((child) {
      if (child is Shape && child.name == 'vertical_center_border') {
        Shape fill = child;
        fill.fills.first.paint.color = Colors.red.withOpacity(0.25);
      }
      if (child is Stroke && child.name == 'vertical_center_border') {
        Stroke fill = child;
        fill.paint.color = Colors.red.withOpacity(0.25);
      }
    });
    setState(() {
      _qrArtboard = artboard;
      _qrArtboard!.play();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          _qrArtboard != null
              ? SizedBox(
                  width: SizeConfig.screenWidth * 0.9,
                  height: SizeConfig.screenWidth * 0.9,
                  child: Rive(
                    artboard: _qrArtboard!,
                    fit: BoxFit.fitWidth,
                  ))
              : SizedBox(),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Connect to CAREFLIX account",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      CommonSizes.vSmallerSpace,
                      Text("Open Parental Control from Settings")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(RoutePaths.QrCodeScanner),
                    child: Text(
                      "Scan code",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Styles.colorPrimary),
                  ),
                ),
                Expanded(child: SizedBox())
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
