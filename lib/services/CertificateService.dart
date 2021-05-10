import 'package:formularium_desktop/main.dart';
import "package:x509csr/x509csr.dart";

import "package:pointycastle/export.dart";
import 'package:asn1lib/asn1lib.dart';

import 'PGPService.dart';

class CertificateService {
  String publicKey;
  String csr;
  String encryptedPrivateKey;

  AsymmetricKeyPair keyPair;

  getCSR(Map<String, String> dn) {
    ASN1Object encodedCSR =
        makeRSACSR(dn, keyPair.privateKey, keyPair.publicKey);
    this.csr = encodeCSRToPem(encodedCSR);
  }

  static Future<CertificateService> generateKeypair() async {
    ASN1ObjectIdentifier.registerFrequentNames();

    CertificateService certificateService = new CertificateService();
    certificateService.keyPair = rsaGenerateKeyPair();
    certificateService.publicKey =
        encodeRSAPublicKeyToPem(certificateService.keyPair.publicKey);
    var pgp = await getIt<PGPService>().loadKeyPair();
    certificateService.encryptedPrivateKey = await pgp.encrypt(
        encodeRSAPrivateKeyToPem(certificateService.keyPair.privateKey));
    return certificateService;
  }

  encryptPrivateKeyWithPublicKey(publicKey) async {
    var pgp = await PGPService.encryptWithPGP(
        encodeRSAPrivateKeyToPem(this.keyPair.privateKey), publicKey);
    return pgp;
  }
}
