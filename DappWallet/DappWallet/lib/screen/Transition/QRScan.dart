import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../Utils/export.dart';

class QrScan extends StatefulWidget {
  const QrScan({Key? key}) : super(key: key);

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  int flag = 0;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              cameraFacing: CameraFacing.back,
              formatsAllowed: [BarcodeFormat.qrcode],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scan Qrcode',
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      Logger.logprint(scanData.toString());
      flag++;
      if (flag == 1) {
        Get.back(result: scanData.code.toString());
      }
      showCustomSnackBar(message: scanData.code.toString(), isError: false);
    });
  }
}
