
import 'package:test/test.dart';
import 'dart:typed_data';
import 'package:convert/convert.dart';
// import '../bin/nem/models.dart';
import '../bin/utils/converter.dart';
import '../models_c.dart';
import 'dart:convert';

int uint32ToInt32(int x) {
  print(x & (1 << 31));
  print(1 << 31);
  if (x & (1 << 31) != 0) {
    print((x & 0xFFFFFFFF));
    return (x & 0xFFFFFFFF) - (1 << 32);
  }
  return x;
}
void main() {
  print(uint32ToInt32(2147483649));
  print(1 << 32);
  /* 
  test('AccountAddressRestrictionTransactionV1_account_address_restriction_single_1', () {
    var payload = 'D0000000000000007695D855CBB6CB83D5BD08E9D76145674F805D741301883387B7101FD8CA84329BB14DBF2F0B4CD58AA84CF31AC6899D134FC38FAB0E7A76F6216ACD60914ACBD294E5E650ACC2A911B548BE2A1806FF4717621BCE3EC1007295219AFFC17B820000000001985041E0FEEEEFFEEEEFFEE0711EE7711EE77101000201000000009841E5B8E40781CF74DABF592817DE48711D778648DEAFB298F409274B52FABBFBCF7E7DF7E20DE1D0C3F657FB8595C1989059321905F681BCF47EA33BBF5E6F8298B5440854FDED';
    var tx = AccountAddressRestrictionTransactionV1(
      network: NetworkType.TESTNET, 
      type: TransactionType.ACCOUNT_ADDRESS_RESTRICTION,
      restrictionFlags: AccountRestrictionFlags.ADDRESS,
      restrictionAdditions: [
        UnresolvedAddress('TBA6LOHEA6A465G2X5MSQF66JBYR254GJDPK7MQ'), UnresolvedAddress('TD2ASJ2LKL5LX66PPZ67PYQN4HIMH5SX7OCZLQI'),
      ],
      restrictionDeletions: [
        UnresolvedAddress('TCIFSMQZAX3IDPHUP2RTXP26N6BJRNKEBBKP33I'),
      ], 
      signerPublicKey: PublicKey('0xD294E5E650ACC2A911B548BE2A1806FF4717621BCE3EC1007295219AFFC17B82'),
      signature: Signature('0x7695D855CBB6CB83D5BD08E9D76145674F805D741301883387B7101FD8CA84329BB14DBF2F0B4CD58AA84CF31AC6899D134FC38FAB0E7A76F6216ACD60914ACB'),
      fee: Amount('18370164183782063840'),
      deadline: Timestamp(8207562320463688160));
    expect(hex.encode(tx.serialize()).toUpperCase(), payload);
  }); */
}
