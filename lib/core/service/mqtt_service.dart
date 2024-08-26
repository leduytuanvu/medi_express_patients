import 'package:flutter/foundation.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final String broker;
  final String clientId;
  final String username;
  final String password;

  late MqttServerClient _client;
  final List<String> _messageStack = [];

  MqttService({
    required this.broker,
    required this.clientId,
    required this.username,
    required this.password,
  });

  Future<void> initializeMQTT() async {
    _client = MqttServerClient(broker, clientId);
    _client.logging(on: kDebugMode); // Enable logging in debug mode
    _client.port = 1883;
    _client.keepAlivePeriod = 20;
    _client.onDisconnected = _onDisconnected;
    _client.onConnected = _onConnected;
    _client.onSubscribed = _onSubscribed;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean() // Start with a clean session
        .withWillQos(MqttQos.atLeastOnce);

    _client.connectionMessage = connMessage;

    try {
      await _client.connect(username, password);
    } catch (e) {
      Log.info('MQTT::Client exception - $e');
      disconnect();
    }

    if (_client.connectionStatus!.state == MqttConnectionState.connected) {
      Log.info('MQTT::Client connected');
      _client.updates?.listen(_onMessage);
    } else {
      Log.info(
          'MQTT::ERROR Client connection failed - disconnecting, status is ${_client.connectionStatus}');
      disconnect();
    }
  }

  void _onMessage(List<MqttReceivedMessage<MqttMessage>> event) {
    final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
    final String message =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    // Add the received message to the stack
    _messageStack.add(message);

    Log.info('MQTT::Message received: $message from topic: ${event[0].topic}>');
  }

  void disconnect() {
    Log.info('MQTT::Disconnecting');
    _client.disconnect();
  }

  void _onConnected() {
    Log.info('MQTT::Connected');
  }

  void _onDisconnected() {
    Log.info('MQTT::Disconnected');
  }

  void _onSubscribed(String topic) {
    Log.info('MQTT::Subscribed to topic $topic');
  }

  void subscribeToTopic(String topic) {
    _client.subscribe(topic, MqttQos.atLeastOnce);
  }

  void unsubscribeFromTopic(String topic) {
    _client.unsubscribe(topic);
  }

  void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  // Retrieve and remove the first message from the stack
  String? popMessage() {
    if (_messageStack.isNotEmpty) {
      return _messageStack.removeAt(0);
    }
    return null;
  }

  // Peek at the first message without removing it
  String? peekMessage() {
    if (_messageStack.isNotEmpty) {
      return _messageStack.first;
    }
    return null;
  }

  // Get the current size of the message stack
  int getMessageStackSize() {
    return _messageStack.length;
  }
}
