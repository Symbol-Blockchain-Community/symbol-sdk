import 'dart:typed_data';
import 'dart:convert';
import 'package:base32/base32.dart';
import 'package:convert/convert.dart';

final Map<String, Map<String, int>> _constants = {
  'sizes': {
    'ripemd160': 20,
    'symbolAddressDecoded': 24,
    'nemAddressDecoded': 25,
    'symbolAddressEncoded': 39,
    'nemAddressEncoded': 40,
    'key': 32,
    'checksum': 3,
  }
};

String intToHex(dynamic num) {
  return num.toRadixString(16).padLeft(16, '0').toUpperCase();
}

String bytesToHex(Uint8List bytes) {
  return hex.encode(bytes).toUpperCase();
}

Uint8List hexToBytes(String hexString) {
  return Uint8List.fromList(hex.decode(hexString));
}

Uint8List bigintToUint8List(BigInt value) {
  var result = Uint8List(8);
  for (var i = 0; i < 8; i++) {
    result[i] = (value >> (8 * i)).toUnsigned(8).toInt();
  }
  return result;
}

Uint8List intToBytes(dynamic value, int byteSize) {
  var byteData = ByteData(byteSize);

  switch (byteSize) {
    case 1:
      byteData.setUint8(0, value);
      break;
    case 2:
      byteData.setUint16(0, value, Endian.little);
      break;
    case 4:
      byteData.setUint32(0, value, Endian.little);
      break;
    case 8:
      return bigintToUint8List(value);
    default:
      throw Exception('byteSize not supported');
  }
  return byteData.buffer.asUint8List();
}

BigInt uint8ListToBigInt(Uint8List data) {
  var result = BigInt.from(0);
  for (var i = 0; i < 8; i++) {
    result += BigInt.from(data[i]) << (8 * i);
  }
  return result;
}

dynamic bytesToInt(Uint8List input, int size) {
  var byteData = ByteData.view(input.buffer, input.offsetInBytes, size);

  switch (size) {
    case 1:
      return byteData.getUint8(0);
    case 2:
      return byteData.getUint16(0, Endian.little);
    case 4:
      return byteData.getUint32(0, Endian.little);
    case 8:
      return uint8ListToBigInt(input);
    default:
      throw Exception('byteSize not supported');
  }
}

BigInt intToUnsignedInt(int i) {
  var signedInt = BigInt.from(i);
  BigInt unsignedInt;

  if (signedInt < BigInt.zero) {
    unsignedInt = signedInt + (BigInt.two.pow(64));
  } else {
    unsignedInt = signedInt;
  }
  return unsignedInt;
}

Uint8List stringToAddress(String encoded) {
  if (_constants['sizes']!['symbolAddressEncoded'] == encoded.length) {
    var bytes = base32.decode(encoded + 'A');
    return Uint8List.fromList(
        bytes.sublist(0, _constants['sizes']!['symbolAddressDecoded']));
  }
  if (_constants['sizes']!['nemAddressEncoded'] == encoded.length) {
    return utf8ToBytes(encoded);
  }
  throw Exception('$encoded does not represent a valid encoded address');
}

String addressToString(Uint8List decoded) {
  if (_constants['sizes']!['symbolAddressDecoded'] == decoded.length) {
    var padded = Uint8List(_constants['sizes']!['symbolAddressDecoded']! + 1);
    padded.setRange(0, decoded.length, decoded);
    return base32
        .encode(padded)
        .substring(0, _constants['sizes']!['symbolAddressEncoded']);
  }
  if (_constants['sizes']!['nemAddressDecoded'] == decoded.length) {
    return base32.encode(decoded);
  }
  throw Exception(
      'Bytes to Hex function is not implemented yet. It does not represent a valid decoded address');
}

bool isHexString(String value) {
  final hexPattern = RegExp(r'^[0-9a-fA-F]+$', caseSensitive: false);
  return hexPattern.hasMatch(value);
}

void tryHexString(String value) {
  if (!isHexString(value)) {
    throw ArgumentError('value was not a valid hex string');
  }
}

String utf8ToHex(String input) {
  List<int> bytes = utf8.encode(input);
  return bytes
      .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
      .join()
      .toUpperCase();
}

Uint8List utf8ToBytes(String input) {
  return utf8.encode(input);
}

String bytesToUtf8(Uint8List input) {
  return utf8.decode(input);
}
