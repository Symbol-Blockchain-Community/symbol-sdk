<?php

namespace SymbolSdk\Symbol;

require_once __DIR__ . '/../utils/converter.php';

function generateMosaicId($ownerAddress, $nonce)
{
  $hasher = hash_init('sha3-256');
  hash_update($hasher, pack('V', $nonce));
  hash_update($hasher, $ownerAddress->binaryData);
  $digest = hash_final($hasher, true);
  $result = unpack('P', $digest)[1];

  if ($result & 1 << 63)
    $result -= 1 << 63;

  return $result;
}