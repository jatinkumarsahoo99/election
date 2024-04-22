/*
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrintPage extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  PrintPage(this.data);

  @override
  _PrintPageState createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _devicesMsg = "";
  final f = NumberFormat("\$###,###.00", "en_US");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {initPrinter()});
  }

  Future<void> initPrinter() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 2));

    if (!mounted) return;
    bluetoothPrint.scanResults.listen(
          (val) {
        if (!mounted) return;
        setState(() => {_devices = val});
        if (_devices.isEmpty) {
          setState(() {
            _devicesMsg = "No Devices";
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Printer'),
        backgroundColor: Colors.redAccent,
      ),
      body: _devices.isEmpty
          ? Center(
        child: Text(_devicesMsg ?? ''),
      )
          : ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (c, i) {
          return ListTile(
            leading: const Icon(Icons.print),
            title: Text(_devices[i].name??""),
            subtitle: Text(_devices[i].address??""),
            onTap: () {
              _startPrint(_devices[i]);
            },
          );
        },
      ),
    );
  }

  Future<void> _startPrint(BluetoothDevice device) async {
    if (device != null && device.address != null) {
      await bluetoothPrint.connect(device);

      Map<String, dynamic> config = Map();
      List<LineText> list = [];

      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: "Grocery App",
          weight: 2,
          width: 2,
          height: 2,
          align: LineText.ALIGN_CENTER,
          linefeed: 1,
        ),
      );

      for (var i = 0; i < widget.data.length; i++) {
        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: widget.data[i]['title'],
            weight: 0,
            align: LineText.ALIGN_LEFT,
            linefeed: 1,
          ),
        );

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content:
            "${f.format(widget.data[i]['price'])} x ${widget.data[i]['qty']}",
            align: LineText.ALIGN_LEFT,
            linefeed: 1,
          ),
        );
      }

      await bluetoothPrint.printLabel(config, list);
    }
  }
}*/

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:image/image.dart' as img;
import 'package:enough_ascii_art/enough_ascii_art.dart' as art;

class MyApp extends StatefulWidget {
  Uint8List data;
   MyApp({super.key,required this.data});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterThermalPrinterPlugin = FlutterThermalPrinter.instance;

  List<Printer> printers = [];

  StreamSubscription<List<Printer>>? _devicesStreamSubscription;

// Get Printer List
  void startScan() async {
    _devicesStreamSubscription?.cancel();
    await _flutterThermalPrinterPlugin.getPrinters();
    _devicesStreamSubscription =
        _flutterThermalPrinterPlugin.devicesStream.listen((List<Printer> event) {
      log(event.map((e) => e.name).toList().toString());
      setState(() {
        printers = event;
        /*printers.removeWhere((element) =>
            element.name == null ||
            element.name == '' ||
            !element.name!.toLowerCase().contains('print'));*/
      });
    });
  }

  void getUsbDevices() async {
    await _flutterThermalPrinterPlugin.getUsbDevices();
  }

  @override
  void dispose() {
    _devicesStreamSubscription?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                startScan();
              },
              child: const Text('Get Printers'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: printers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      if (printers[index].isConnected ?? false) {
                        await _flutterThermalPrinterPlugin.disconnect(printers[index]);
                      } else {
                        final isConnected =
                            await _flutterThermalPrinterPlugin.connect(printers[index]);
                        log("Devices: $isConnected");
                      }
                    },
                    title: Text(printers[index].name ?? 'No Name'),
                    subtitle: Text(
                        "VendorId: ${printers[index].address} - Connected: ${printers[index].isConnected}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.connect_without_contact),
                      onPressed: () async {
                        final profile = await CapabilityProfile.load();
                        final generator = Generator(PaperSize.mm80, profile);
                        List<int> bytes = [];
                        /*bytes += generator.text("Jatin",
                            styles: const PosStyles(
                              bold: false,
                              height: PosTextSize.size3,
                              width: PosTextSize.size3,
                              // fontType: PosFontType.values

                            ));*/
                        // bytes += utf8.encode("ଆଳି ବିଧାନସଭା ନର୍ବାଚନମଣ୍ଡଳୀ ୨୦୨୪");
                        final ByteData data = await rootBundle.load('assets/images/32.png');
                        final Uint8List imgBytes = data.buffer.asUint8List();
                        final img.Image? imageLogo = img.decodeImage(imgBytes);

                        var thumbnailLogo =
                        img.copyResize(imageLogo!, interpolation: img.Interpolation.nearest, height: 200);
                        if(thumbnailLogo != null){
                          bytes += generator.imageRaster(thumbnailLogo,align: PosAlign.center);
                          // bytes += generator.qrcode("jatin kumar sahoo");
                        }

                        final img.Image? image = img.decodeImage(widget.data,frame: 1);
                        // final img.Image? image =  generateTextImage("ଆଳି ବିଧାନସଭା ନର୍ବାଚନମଣ୍ଡଳୀ ୨୦୨୪") as img.Image?;
                        // bytes += generator.image(image!,align: PosAlign.center);

                        var thumbnail =
                        img.copyResize(image!, interpolation: img.Interpolation.nearest, height: 400,width: 440);
                        if(thumbnail != null){
                          bytes += generator.imageRaster(thumbnail,align: PosAlign.center);
                          // bytes += generator.qrcode("jatin kumar sahoo");
                        }

                        bytes += generator.cut();
                        await _flutterThermalPrinterPlugin.printData(
                          printers[index],
                          bytes,
                          longData: true,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<ui.Image> generateTextImage(String text) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final textPainter = TextPainter(text: TextSpan(text: text,),
        maxLines: 1, textDirection: TextDirection.ltr);

    textPainter.layout(maxWidth: 300.0); // Adjust maxWidth as needed
    textPainter.paint(canvas, const Offset(0, 0));

    final picture = recorder.endRecording();
    final image = await picture.toImage(textPainter.width.toInt(), textPainter.height.toInt());
    return image;
  }

  Widget receiptWidget() {
    return Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        width: 300,
        height: 300,
        child: const Center(
          child: Column(
            children: [
              Text(
                "FLUTTER THERMAL PRINTER",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Hello World",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "This is a test receipt",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ));
  }



  Future<Uint8List> generateImageFromString(String text) async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(
      recorder,
      Rect.fromCenter(
        center: const Offset(0, 0),
        width: 550,
        height: 400,
      ),
    );

    TextSpan span = TextSpan(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      text: text,
    );

    TextPainter tp = TextPainter(
      text: span,
      maxLines: 3,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout(minWidth: 550, maxWidth: 550);
    tp.paint(canvas, const Offset(0.0, 0.0));

    var picture = recorder.endRecording();
    final pngBytes = await picture.toImage(
      tp.size.width.toInt(),
      tp.size.height.toInt() - 2, // decrease padding
    );

    final byteData = await pngBytes.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}


/*
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BluetoothPrintPage extends StatefulWidget {
  @override
  _BluetoothPrintPageState createState() => _BluetoothPrintPageState();
}

class _BluetoothPrintPageState extends State<BluetoothPrintPage> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice ?_connectedDevice;
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    initPrinter();
  }

  initPrinter() {
    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          break;
      }
    });
  }

  Future<void> connectToDevice() async {
    _devices = [];
    try {
      _devices = await bluetooth.getBondedDevices();
      if (_devices.isNotEmpty) {
        _connectedDevice = _devices[0];
        await bluetooth.connect(_connectedDevice!);
      } else {
        print("No devices found");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> printTest() async {
    if (_connected) {
      try {
        bluetooth.printInfo (info: "Jatin kumar sahoo");
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      } catch (e) {
        print(e.toString());
      }
    } else {
      print("Printer not connected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Printer Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: connectToDevice,
              child: Text('Connect to Printer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: printTest,
              child: Text('Print Test'),
            ),
          ],
        ),
      ),
    );
  }
}
*/

