part of '../../communicate_mediexpress.dart';

final Map<DeviceIdentifier, _StreamControllerReEmit<bool>> _cglobal = {};
final Map<DeviceIdentifier, _StreamControllerReEmit<bool>> _dglobal = {};

/// connect & disconnect + update stream
extension Extra on BluetoothDevice {
  // convenience
  _StreamControllerReEmit<bool> get _cstream {
    _cglobal[remoteId] ??= _StreamControllerReEmit(initialValue: false);
    return _cglobal[remoteId]!;
  }

  // convenience
  _StreamControllerReEmit<bool> get _dstream {
    _dglobal[remoteId] ??= _StreamControllerReEmit(initialValue: false);
    return _dglobal[remoteId]!;
  }

  // get stream
  Stream<bool> get isConnecting {
    return _cstream.stream;
  }

  // get stream
  Stream<bool> get isDisconnecting {
    return _dstream.stream;
  }

  // connect & update stream
  Future<void> connectAndUpdateStream() async {
    _cstream.add(true);
    try {
      await connect(mtu: null,autoConnect: true);
    } finally {
      _cstream.add(false);
    }
  }

  // disconnect & update stream
  Future<void> disconnectAndUpdateStream({bool queue = true}) async {
    _dstream.add(true);
    try {
      await disconnect(queue: queue);
    } finally {
      _dstream.add(false);
    }
  }
}