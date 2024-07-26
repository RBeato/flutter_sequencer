import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sequencer/original/flutter_sequencer.dart';
import 'package:flutter_sequencer/original/flutter_sequencer_platform_interface.dart';
import 'package:flutter_sequencer/original/flutter_sequencer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSequencerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterSequencerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterSequencerPlatform initialPlatform =
      FlutterSequencerPlatform.instance;

  test('$MethodChannelFlutterSequencer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSequencer>());
  });

  test('getPlatformVersion', () async {
    FlutterSequencer flutterSequencerPlugin = FlutterSequencer();
    MockFlutterSequencerPlatform fakePlatform = MockFlutterSequencerPlatform();
    FlutterSequencerPlatform.instance = fakePlatform;

    expect(await flutterSequencerPlugin.getPlatformVersion(), '42');
  });
}
