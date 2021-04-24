import 'dart:async';
import 'dart:io';

import 'package:formularium_desktop/models/InstanceSettings.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'PreferencesService.dart';

class OauthService {
  InstanceSettings instanceSettings;
  oauth2.Client oauthClient;


  static Future<OauthService> setup(InstanceSettings settings) async {
    OauthService oa = OauthService();
    oa.instanceSettings = settings;
    return oa;
  }

  Future<oauth2.Client> getClient(oauth2.Credentials credentials) async {
    this.oauthClient = oauth2.Client(credentials, identifier: this.instanceSettings.clientID);
    return this.oauthClient;
  }

  refreshToken() async {
    await this.oauthClient.refreshCredentials();
    getIt<PreferencesService>().oAuthCredentials = this.oauthClient.credentials;
  }

  Future<oauth2.Client> authorize() async {

    // If we don't have OAuth2 credentials yet, we need to get the resource owner
    // to authorize us. We're assuming here that we're a command-line application.
    var grant = oauth2.AuthorizationCodeGrant(
        this.instanceSettings.clientID, Uri.parse(this.instanceSettings.authURL), Uri.parse(this.instanceSettings.tokenURL));

    // A URL on the authorization server (authorizationEndpoint with some additional
    // query parameters). Scopes and state can optionally be passed into this method.
    var authorizationUrl = grant.getAuthorizationUrl(Uri.parse(this.instanceSettings.redirectURL));

    // Redirect the resource owner to the authorization URL. Once the resource
    // owner has authorized, they'll be redirected to `redirectUrl` with an
    // authorization code. The `redirect` should cause the browser to redirect to
    // another URL which should also have a listener.
    Stream<Map<String, String>> onCode = await _server();
    launch(authorizationUrl.toString());
    final Map<String, String> code = await onCode.first;
    // Once the user is redirected to `redirectUrl`, pass the query parameters to
    // the AuthorizationCodeGrant. It will validate them and extract the
    // authorization code to create a new Client.
    this.oauthClient =  await grant.handleAuthorizationResponse(code);
    await this.refreshToken();
    return this.oauthClient;
  }


  // inspired by https://www.didierboelens.com/2018/04/facebook-oauth-login-with-flutter-solution/
  Future<Stream<Map<String, String>>> _server() async {
    final StreamController<Map<String, String>> onCode = new StreamController();
    HttpServer server =
    await HttpServer.bind(InternetAddress.loopbackIPv4, this.instanceSettings.loopBackPort);
    server.listen((HttpRequest request) async {
      final Map<String, String> code = request.uri.queryParameters;
      request.response
        ..statusCode = 200
        ..headers.set("Content-Type", ContentType.html.mimeType)
        ..write("<html>You can now close this window</html>");
      await request.response.close();
      await server.close(force: true);
      onCode.add(code);
      await onCode.close();
    });
    return onCode.stream;
  }
}