import 'dart:io';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:convert/convert.dart';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
// /Users/matsukawatoshiya/programs/symbol-sdk/symbol/sdk/dart/test/symbol/crypto/0.test-keccak-256_test.dart
// /Users/matsukawatoshiya/programs/symbol-sdk/symbol/tests/vectors/symbol/crypto/0.test-keccak-256.json
void main() async {
  var file = File('../../../../../tests/vectors/symbol/crypto/0.test-keccak-256.json');
  var contents = await file.readAsString();
  var jsonMap = jsonDecode(contents);
  final digest = KeccakDigest(256);
  (jsonMap as List).forEach((element) {
    test(element['hash'], () {
      var data = Uint8List.fromList(hex.decode(element['data']));
      var hash = hex.encode(digest.process(data)).toUpperCase();
      expect(element['hash'], hash);
    });
  });
}
