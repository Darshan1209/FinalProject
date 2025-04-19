import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

// Mock Classes
class MockFlutterTts extends Mock implements FlutterTts {}

class MockImagePicker extends Mock implements ImagePicker {}

class MockGemini extends Mock {
  Stream<String> streamGenerateContent(String text) async* {
    yield 'This is a test response from Gemini.';
  }
}void main() {
  group('ChatPage Tests', () {
    late MockFlutterTts mockTts;
    late MockImagePicker mockImagePicker;
    late MockGemini mockGemini;

    setUp(() {
      mockTts = MockFlutterTts();
      mockImagePicker = MockImagePicker();
      mockGemini = MockGemini();
    });
    test('Gemini AI response should be streamed successfully', () async {
      final stream = mockGemini.streamGenerateContent('Describe the image');
      await for (var response in stream) {
        expect(response, 'This is a test response from Gemini.');
      }
    });
  });
}
