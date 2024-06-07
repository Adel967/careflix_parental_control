import 'dart:developer';
import 'dart:io';

import 'package:careflix_parental_control/core/configuration/styles.dart';
import 'package:careflix_parental_control/core/routing/route_path.dart';
import 'package:careflix_parental_control/layers/bloc/connecting/connecting_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../core/app/state/app_state.dart';
import '../../../core/loaders/loading_overlay.dart';
import '../../../core/utils.dart';
import '../../../injection_container.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final _connectingCubit = sl<ConnectingCubit>();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ConnectingCubit, ConnectingState>(
        bloc: _connectingCubit,
        listener: (context, state) async {
          if (state is ConnectingLoading) {
            LoadingOverlay.of(context).show();
            controller!.pauseCamera();
          } else if (state is ConnectingLoaded) {
            await Provider.of<AppState>(context, listen: false).init();
            LoadingOverlay.of(context).hide();
            Navigator.of(context).pushNamedAndRemoveUntil(
                RoutePaths.TimeManagementScreen, (route) => false);
          } else if (state is ConnectingError) {
            LoadingOverlay.of(context).hide();
            controller!.resumeCamera();
            Utils.showSnackBar(context, state.error);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildQrView(context),
            Positioned(
              top: 30,
              left: 20,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back),
                style:
                    IconButton.styleFrom(backgroundColor: Styles.colorPrimary),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Styles.colorPrimary,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      Vibrate.feedback(FeedbackType.success);
      if (result != null && result!.code != null) {
        _connectingCubit.connect(result!.code!);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
