import 'package:biometric_storage/biometric_storage.dart';
import 'package:openpgp/model/bridge.pb.dart';
import 'package:openpgp/openpgp.dart';

class PGPService {
  KeyPair _keyPair;
  String _passphrase;
  static PGPService _instance;

  static Future<PGPService> getInstance() async {
    if (_instance == null) {
      _instance = PGPService();
    }
    return _instance;
  }

  static fromKeyPair(KeyPair keyPair) {
    PGPService pgpService = PGPService();
    pgpService._keyPair = keyPair;
    return pgpService;
  }

  Future<PGPService> loadKeyPair() async {
    return PGPService.fromKeyPair(KeyPair.fromJson(
        await (await PGPService.getBiometricStorage()).read()));
  }

  static Future<CanAuthenticateResponse> canAccessBiometricStorage() async {
    final response = await BiometricStorage().canAuthenticate();
    print('checked if authentication was possible: $response');
    return response;
  }

  static Future<BiometricStorageFile> getBiometricStorage() async {
    CanAuthenticateResponse authenticate =
        await PGPService.canAccessBiometricStorage();
    final supportsAuthenticated =
        authenticate == CanAuthenticateResponse.success ||
            authenticate == CanAuthenticateResponse.statusUnknown;
    if (supportsAuthenticated) {
      return await BiometricStorage().getStorage('pgpKey',
          options: StorageFileInitOptions(
              authenticationRequired: false,
              authenticationValidityDurationSeconds: 1200));
    }

    return BiometricStorage().getStorage('pgpKey',
        options: StorageFileInitOptions(
            authenticationValidityDurationSeconds: 1200));
  }

  static generateNewKey(String name, String email, String passphrase) async {
    var keyOptions = KeyOptions()..rsaBits = 4096;
    var keyPair = await OpenPGP.generate(
        options: Options()
          ..name = name
          ..email = email
          ..passphrase = passphrase
          ..keyOptions = keyOptions);
    await (await PGPService.getBiometricStorage()).write(keyPair.writeToJson());
    return PGPService.fromKeyPair(keyPair);
  }

  set passphrase(String passphrase) {
    this._passphrase = passphrase;
  }

  get publicKey {
    return this._keyPair.publicKey;
  }

  get keyHash {
    return this._keyPair.hashCode;
  }

  Future<String> decrypt(String encrypted) async {
    return await OpenPGP.decrypt(
        encrypted, this._keyPair.privateKey, this._passphrase);
  }

  Future<String> encrypt(String text) async {
    return await OpenPGP.encrypt(text, this._keyPair.publicKey);
  }

  static Future<String> encryptWithPGP(String text, String pgpKey) async {
    return await OpenPGP.encrypt(text, pgpKey);
  }

  Future<String> sign(String text) async {
    return await OpenPGP.sign(text, this._keyPair.publicKey,
        this._keyPair.privateKey, this._passphrase);
  }

  Future<bool> verify(String signedText, String text) async {
    return await OpenPGP.verify(signedText, text, this._keyPair.publicKey);
  }

  static Future<bool> verifyWithPGP(
      String signedText, String text, String pgpKey) async {
    return await OpenPGP.verify(signedText, text, pgpKey);
  }
}
