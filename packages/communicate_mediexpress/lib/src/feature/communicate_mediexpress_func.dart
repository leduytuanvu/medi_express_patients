part of '../../communicate_mediexpress.dart';

enum BleStatus { connected, connecting, disconnecting, disconnected, unknown }

enum BleScanStatus {
  errorBleNotEnable,
  errorLocationNotEnable,
  errorBleAndLocationNotEnable,
  scanning,
  stop,
  unknown
}

enum TypeCommand {
  ///Start to Test BP
  b1,

  ///Testing BP
  b2,

  ///Normal for BP and Outputs of the BP Testing
  b3,

  ///Abnormal for BP and Code of Error Results
  b4,

  ///Start to test SpO2
  b5,

  ///Normal for SpO2 and Outputs of the SpO2
  b6,

  ///Abnormal for BP and Code of Error Results
  b7,

  ///Start to Test Blood
  b8,

  ///Note the type of testing paper while inserting the testing paper
  b9,

  ///Note the type of testing paper while dripping the blood
  ba,

  ///Normal Blood Glucose and Outputs of the Blood Glucose
  bb,

  ///Abnormal for BG and Code of Error Results
  bc,

  ///Normal for Uric Acid and Outputs of the Uric Acid
  bd,

  ///Abnormal for Uric Acid and Code f other Error Results
  be,

  ///Start to Test Temp
  bf,

  ///Temp Data
  c0,

  ///Exit the Testing Temp
  c1,
  unknown
}

enum TypeInformation {
  startBp,
  testingBp,
  resultBp,
  startTestSpO2,
  resultSpO2,
  startTestTemp,
  currentTemp,
  exitTestTemp,
  startTestBlood,
  testingPaper,
  resultPaper,
  resultUa,
  resultBg,
  errorBp,
  errorSp02,
  errorBg,
  errorUa,
  unknown,
}

class CommunicateMediExpress {
  CommunicateMediExpress._privateConstructor();

  static final CommunicateMediExpress _instance =
      CommunicateMediExpress._privateConstructor();

  factory CommunicateMediExpress() {
    return _instance;
  }

  List<ScanResult> scanResults = [];
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> isScanningSubscription;
  Timer? _timerLoopScan;
  final CommandParameter _commandParameter = CommandParameter(
      commandParameterUser: CommandParameterUser(),
      typeCommand: TypeCommand.unknown,
      typeInformation: TypeInformation.unknown);
  final CommandParameterUser _commandParameterUser = CommandParameterUser();

  // late StreamSubscription<List<int>> lastValueSubscription;
  bool isTimerStarted = false;
  TypeCommand currentTypeCommand = TypeCommand.unknown;
  bool bluetoothStatus = true;
  bool locationStatus = true;
  BluetoothConnectionState connectionState =
      BluetoothConnectionState.disconnected;
  late StreamSubscription<BluetoothConnectionState> connectionStateSubscription;
  late StreamSubscription<bool> isConnectingSubscription;
  late StreamSubscription<bool> isDisconnectingSubscription;
  late StreamSubscription<int> mtuSubscription;
  late StreamSubscription<BluetoothAdapterState> adapterBleStateSubscription;
  late StreamSubscription<ServiceStatus> serviceStatusStream;

  String nameDevice = "";
  String macAddressDevice = "";

  /// stream used for the scanResults public api
  static final _bleScanStatus = _StreamControllerReEmit<BleScanStatus>(
      initialValue: BleScanStatus.unknown);

  static Stream<BleScanStatus> get currentBleScanStatus =>
      _bleScanStatus.stream;

  static final _bleDeviceStatus =
      _StreamControllerReEmit<BleStatus>(initialValue: BleStatus.unknown);

  static Stream<BleStatus> get currentBleStatus => _bleDeviceStatus.stream;

  static final _readDataUserBp = _StreamControllerReEmit<CommandParameter>(
    initialValue: CommandParameter(
      commandParameterUser: CommandParameterUser(),
      typeCommand: TypeCommand.unknown,
      // rawData: const <int>[],
      typeInformation: TypeInformation.unknown,
    ),
  );
  Throttler throttlerGetServices = Throttler();

  static Stream<CommandParameter> get readDataUserBp => _readDataUserBp.stream;

  Future<void> bleInitListen(
      {required String nameDevice, String macAddressDevice = ""}) async{
    this.nameDevice = nameDevice;
    this.macAddressDevice = macAddressDevice;

    if(await _checkBleAndLocationPermission()){
      await _checkBleAndLocationEnable();

      if (_bleScanStatus.latestValue == BleScanStatus.unknown ||
          _bleScanStatus.latestValue == BleScanStatus.stop) {
        BluetoothDevice? currentDevice =
            FlutterBluePlus.connectedDevices.firstOrNull;

        if ((currentDevice?.advName ?? "")
            .toLowerCase()
            .contains(this.nameDevice)) {
          _bleScanStatus.add(BleScanStatus.stop);
          _bleDeviceStatus.add(BleStatus.connected);
        } else {
          _bleDeviceStatus.add(BleStatus.unknown);
          _bleScanStatus.add((BleScanStatus.stop));
        }
        _scanResultsSubscription =
            FlutterBluePlus.scanResults.listen((results) async {
              if (results.isNotEmpty) {
                List<ScanResult> listFilterDevice = results.where(
                      (element) {
                    if (this.macAddressDevice.isNotEmpty) {
                      return element.device.remoteId.str == this.macAddressDevice;
                    } else {
                      return element.device.advName
                          .toLowerCase()
                          .contains(nameDevice.toLowerCase());
                    }
                  },
                ).toList();

                if (listFilterDevice.isNotEmpty) {
                  scanResults = [listFilterDevice.first];
                  stopAutoDetectDevice();
                  autoConnectDeviceBp(scanResults.first.device);
                }
              }
            }, onError: (e) {
              debugPrint("Error scan device Bluetooth: $e");
            });

        isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
          switch (state) {
            case true:
              _bleScanStatus.add(BleScanStatus.scanning);

            case false:
              _bleScanStatus.add(BleScanStatus.stop);
          }
        });
      }
    }else{
      debugPrint("Ble or location not granted");
    }

  }

  Future<void> startAutoDetectDevice(String from) async {
    try {
      if (_bleScanStatus.latestValue != BleScanStatus.scanning &&
          bluetoothStatus &&
          locationStatus) {

        _bleScanStatus.add(BleScanStatus.scanning);
        Future.delayed(const Duration(milliseconds: 500), () async {
          await FlutterBluePlus.startScan(
              timeout: const Duration(seconds: 178));
        });
      }
    } catch (e) {
      debugPrint("Error scan device: $e");
    }
    _timerLoopScan ??=
        Timer.periodic(const Duration(minutes: 3), (timer) async {
      try {
        if (_bleScanStatus.latestValue != BleScanStatus.scanning &&
            bluetoothStatus &&
            locationStatus) {
          // _bleScanStatus.add(BleScanStatus.scanning);
          await FlutterBluePlus.startScan(
              timeout: const Duration(seconds: 178));
        }
      } catch (e) {
        // await stopAutoDetectDevice();
        // await startAutoDetectDevice();
        debugPrint("Error scan device: $e");
      }
    });
  }

  Future<void> autoConnectDeviceBp(BluetoothDevice device) async {
    if (scanResults.isNotEmpty) {
      device.connectAndUpdateStream().catchError(
        (e) {
          return;
        },
      );
      connectionStateSubscription =
          device.connectionState.listen((state) async {
        connectionState = state;
        if (state == BluetoothConnectionState.connected) {
          _bleDeviceStatus.add(BleStatus.connected);

          try {
            throttlerGetServices.run(() async {
              await stopAutoDetectDevice();
              await getServicesDeviceBp(device);
            });
          } catch (e) {
            debugPrint("Error stop scan device: $e");
          }
        } else if (state == BluetoothConnectionState.disconnected) {
          _bleDeviceStatus.add(BleStatus.disconnected);
          if (_readDataUserBp.latestValue.typeInformation ==
              TypeInformation.currentTemp) {
            _readDataUserBp.add(
              CommandParameter(
                commandParameterUser:
                    _readDataUserBp.latestValue.commandParameterUser,
                typeCommand: TypeCommand.c1,
                // rawData: value,
                typeInformation: TypeInformation.exitTestTemp,
              ),
            );
          }
          await startAutoDetectDevice("device disconnect");
        }
      });
    }
  }
  Future<bool> _checkBleAndLocationPermission() async {
    permission.PermissionStatus permissionStatusBlue = await permission.Permission.bluetooth.status;
    permission.PermissionStatus permissionStatusLocation =
    await permission.Permission.location.status;

    permissionStatusBlue = await permission.Permission.bluetooth.request();
    permissionStatusLocation = await permission.Permission.location.request();


    if (permissionStatusBlue == permission.PermissionStatus.granted &&
        permissionStatusLocation == permission.PermissionStatus.granted) {

      return true;
    } else {
      return false;
    }
  }
  Future<void> _checkBleAndLocationEnable() async {
    await permission.Permission.bluetooth.request();
    await permission.Permission.location.request();

    serviceStatusStream =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      locationStatus = (status == ServiceStatus.enabled) ? true : false;
      debugPrint("locationStatus: $locationStatus");
      _permissionAndCheckEnableScan();
    });

    adapterBleStateSubscription = FlutterBluePlus.adapterState.listen(
      (state) {
        if (state == BluetoothAdapterState.on ||
            state == BluetoothAdapterState.turningOn) {
          bluetoothStatus = true;
        } else if (state == BluetoothAdapterState.off ||
            state == BluetoothAdapterState.turningOff) {
          bluetoothStatus = false;
        }
        debugPrint("bleStatus: $bluetoothStatus");
        _permissionAndCheckEnableScan();
      },
    );
    bluetoothStatus = (FlutterBluePlus.adapterStateNow ==
                BluetoothAdapterState.on ||
            FlutterBluePlus.adapterStateNow == BluetoothAdapterState.turningOn)
        ? true
        : false;
    locationStatus = await Geolocator.isLocationServiceEnabled();

    _permissionAndCheckEnableScan();
  }

  void _permissionAndCheckEnableScan() {
    if (!bluetoothStatus && !locationStatus) {
      _bleScanStatus.add(BleScanStatus.errorBleAndLocationNotEnable);
      return;
    } else if (!locationStatus) {
      _bleScanStatus.add(BleScanStatus.errorLocationNotEnable);
      return;
    } else if (!bluetoothStatus) {
      _bleScanStatus.add(BleScanStatus.errorBleNotEnable);
      return;
    } else {
      _bleScanStatus.add(BleScanStatus.stop);
      Future.delayed(const Duration(seconds: 1), () {
        startAutoDetectDevice("check permission");
      });

      return;
    }
  }

  Future<void> getServicesDeviceBp(BluetoothDevice device) async {
    debugPrint("_getServicesDeviceBp");
    Future.delayed(const Duration(seconds: 1), () async {
      try {
        List<BluetoothService> services = await device.discoverServices();
        for (BluetoothService bluetoothService in services) {
          if (bluetoothService.serviceUuid.str.toLowerCase() == "fff0") {
            for (var characteristic in bluetoothService.characteristics) {
              if (characteristic.uuid.str.toLowerCase() == "fff1") {
                readCharacteristic(characteristic);
              }
            }
          }
        }
      } catch (e) {
        debugPrint("_getServicesDeviceBp Error: $e");
      }
    });
  }

  Future<void> readCharacteristic(
      BluetoothCharacteristic bluetoothCharacteristic) async {
    debugPrint("_readCharacteristic");
    // lastValueSubscription =
    try {
      await bluetoothCharacteristic.setNotifyValue(true);
      Future.delayed(const Duration(milliseconds: 100), () async {
        await bluetoothCharacteristic.read();
      });
    } catch (e) {
      debugPrint("Error read data characteristic: $e");
    }
    bluetoothCharacteristic.lastValueStream.listen(
      (value) {
        if (value.length > 5) {
          try {
            final int command = value[3];

            if (command == 177) {
              _commandParameterUser.gender =
                  value[4] == 1 ? Gender.male : Gender.female;
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.b1
                ..typeInformation = TypeInformation.startBp;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 178) {
              _commandParameterUser.gender =
                  value[4] == 1 ? Gender.male : Gender.female;
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.b2
                ..typeInformation = TypeInformation.testingBp;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 179) {
              _commandParameterUser
                ..gender = value[4] == 1 ? Gender.male : Gender.female
                ..sys = value[5]
                ..dia = value[6]
                ..pul = value[7]
                ..ihb = value[8] == 0 ? Ihb.normal : Ihb.irregular;
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.b3
                ..typeInformation = TypeInformation.resultBp;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 180) {
              _commandParameterUser.gender =
                  value[4] == 1 ? Gender.male : Gender.female;
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.b4
                ..typeInformation = TypeInformation.errorBp;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 181) {
              _commandParameterUser.gender =
                  value[4] == 1 ? Gender.male : Gender.female;
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.b5
                ..typeInformation = TypeInformation.startTestSpO2;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 182) {
              _commandParameterUser
                ..gender = value[4] == 1 ? Gender.male : Gender.female
                ..spO2 = value[5];
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.b6
                ..typeInformation = TypeInformation.resultSpO2;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 183) {
              _commandParameterUser.gender =
                  value[4] == 1 ? Gender.male : Gender.female;
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.b7
                ..typeInformation = TypeInformation.errorSp02;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 184) {
              _commandParameterUser.gender =
                  value[4] == 1 ? Gender.male : Gender.female;
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.b8
                ..typeInformation = TypeInformation.startTestBlood;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 185) {
              _commandParameterUser.gender =
                  value[4] == 1 ? Gender.male : Gender.female;
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.b9
                ..typeInformation = TypeInformation.testingPaper;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 186) {
              _commandParameterUser.gender =
                  value[4] == 1 ? Gender.male : Gender.female;
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.ba
                ..typeInformation = TypeInformation.resultPaper;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 187) {
              _commandParameterUser
                ..gender = value[4] == 1 ? Gender.male : Gender.female
                ..gluH = value[6]
                ..gluL = value[7]
                ..resultGlu = calculateBg(
                  value[6],
                );
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.bb
                ..typeInformation = TypeInformation.resultBg;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 188) {
              _commandParameterUser.gender =
                  value[4] == 1 ? Gender.male : Gender.female;
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.bc
                ..typeInformation = TypeInformation.errorBg;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 189) {
              _commandParameterUser
                ..gender = value[4] == 1 ? Gender.male : Gender.female
                ..uaH = value[5]
                ..uaL = value[6]
                ..resultUa = calculateUa(value[5], value[6]);
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.bd
                ..typeInformation = TypeInformation.resultUa;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 190) {
              _commandParameterUser.gender =
                  value[4] == 1 ? Gender.male : Gender.female;
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.be
                ..typeInformation = TypeInformation.errorUa;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 191) {
              _commandParameterUser.gender =
                  value[4] == 1 ? Gender.male : Gender.female;
              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.bf
                ..typeInformation = TypeInformation.startTestTemp;
              _readDataUserBp.add(_commandParameter);
            } else if (command == 192) {
              _commandParameterUser
                ..gender = value[4] == 1 ? Gender.male : Gender.female
                ..tempH = value[5]
                ..tempL = value[6]
                ..resultTemp = calculateTemp(value[5], value[6]);

              _commandParameter
                ..commandParameterUser = _commandParameterUser
                ..typeCommand = TypeCommand.c0
                ..typeInformation = TypeInformation.currentTemp;
              _readDataUserBp.add(_commandParameter);
            }
            // else if (command == 193) {
            //   debugPrint("C1");
            //   _readDataUserBp.add(
            //     CommandParameter(
            //       commandParameterUser: CommandParameterUser(
            //         gender: value[4] == 1 ? Gender.male : Gender.female,
            //       ),
            //       typeCommand: TypeCommand.c1,
            //       // rawData: value,
            //       typeInformation: TypeInformation.exitTestTemp,
            //     ),
            //   );
            // }
            else {
              debugPrint("Unknown command: $command");
            }
          } catch (e, stacktrace) {
            debugPrint("Error processing value stream: $e");
            debugPrint("Stacktrace: $stacktrace");
          }
        }
      },
    );
  }

  Future<void> stopAutoDetectDevice() async {
    if (_timerLoopScan != null) {
      if (_bleScanStatus.latestValue == BleScanStatus.scanning) {
        await FlutterBluePlus.stopScan();
        FlutterBluePlus.cancelWhenScanComplete(_scanResultsSubscription);
        debugPrint("_stop scan from stopAutoDetectDevice");
      }
      _bleScanStatus.add(BleScanStatus.stop);
      _timerLoopScan!.cancel();
      _timerLoopScan = null;
      debugPrint("Loop scan is stop");
    } else {
      debugPrint("Timer is not active");
    }
  }

  Future<void> cancelAllServices() async {
    scanResults = [];
    nameDevice = "";
    currentTypeCommand = TypeCommand.unknown;
    connectionState = BluetoothConnectionState.disconnected;
    await stopAutoDetectDevice();
    await _scanResultsSubscription.cancel();
    await isScanningSubscription.cancel();
    // await lastValueSubscription.cancel();
    await connectionStateSubscription.cancel();
    await isConnectingSubscription.cancel();
    await isDisconnectingSubscription.cancel();
    await mtuSubscription.cancel();
    await adapterBleStateSubscription.cancel();
    await serviceStatusStream.cancel();
    await _bleScanStatus.close();
    await _bleDeviceStatus.close();
  }

  double calculateTemp(int tempH, int tempL) {
    return (tempH * 256 + tempL) / 100;
  }

  double calculateBg(int gluH) {
    return gluH / 10;
  }

  int calculateUa(int uaH, int uaL) {
    return uaH * 256 + uaL;
  }

  
}
