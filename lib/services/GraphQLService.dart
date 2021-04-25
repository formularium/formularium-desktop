

import 'package:flutter/cupertino.dart';
import 'package:formularium_desktop/services/OauthService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../main.dart';
import 'PreferencesService.dart';

class GraphQLService {
  static GraphQLService _instance;
  Link _link;
  GraphQLClient _gql_client;
  static Future<GraphQLService> getInstance() async {
    if (_instance == null) {
      _instance = GraphQLService();
    }
    await _instance.reloadSettings();
    return _instance;
  }

  reloadSettings() async {
    if(getIt<PreferencesService>().instanceSettings != null && getIt<PreferencesService>().oAuthCredentials != null)
    {
      final HttpLink httpLink = HttpLink(
        getIt<PreferencesService>().instanceSettings.apiURL,
      );
      OauthService oauthService = await OauthService.setup(getIt<PreferencesService>().instanceSettings);
      oauthService.getClient(getIt<PreferencesService>().oAuthCredentials);
      print('Bearer '+await oauthService.accessToken);
      final AuthLink authLink = AuthLink(
        headerKey: "authorization",
        getToken: () async => 'Bearer '+await oauthService.accessToken,
      );
      _instance._link = authLink.concat(httpLink);

      _instance._gql_client =
        GraphQLClient(
          link: _instance._link,
          cache: GraphQLCache(store: HiveStore()),
          // The default store is the InMemoryStore, which does NOT persist to disk
        );
    }
  }

  get graphQLClient {
    return _gql_client;
  }
}