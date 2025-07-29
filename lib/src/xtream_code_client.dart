import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:xtream_code_client/src/http/http_client_factory.dart'
  if (dart.library.js_interop) 'package:xtream_code_client/src/http/http_client_factory_web.dart'
  as http_factory;
import 'package:xtream_code_client/src/xtream_client.dart';

/// {@template xtream_code_client}
/// A WebClient to access a XTream Code API
///
/// Use it:
///
/// ```dart
/// final instance = XtreamCode(
///   url: ...,
///   port: ...,
///   username: ...,
///   password: ...,
/// );
/// ```
///
/// {@endtemplate}
class XtreamCode {
  /// {@macro xtream_code_client}
  XtreamCode({
  required String url,
  required String port,
  required String username,
  required String password,
  Client? httpClient,
  bool? debug,
  })  : _debugEnable = debug ?? kDebugMode {
  _init(
    url,
    port,
    username,
    password,
    httpClient,
  );
  _log('***** XtreamCode init completed $this');
  }

  bool _debugEnable;
  late XtreamCodeClient client;
  late Client? _httpClient;

  /// Dispose the instance to free up resources.
  Future<void> dispose() async {
  _httpClient?.close();
  _httpClient = null;
  }

  void _init(
  String url,
  String port,
  String username,
  String password,
  Client? httpClient,
  ) {
  _httpClient = httpClient ?? http_factory.httpClient();
  client = XtreamCodeClient(
    _createBaseUrl(url, port, username, password),
    _createStreamUrl(url, port, username, password),
    _createMovieUrl(url, port, username, password),
    _createSeriesUrl(url, port, username, password),
    _httpClient!,
  );
  }

  void _log(String msg, [StackTrace? stackTrace]) {
  if (_debugEnable) {
    debugPrint(msg);
    if (stackTrace != null) {
    debugPrintStack(stackTrace: stackTrace);
    }
  }
  }

  String _createBaseUrl(
  String url,
  String port,
  String username,
  String password,
  ) {
  final uri =
    '$url:$port/player_api.php?username=$username&password=$password';
  assert(
    Uri.parse(uri).isAbsolute,
    '''
    The provided combination of url, port, username and password is not a
    valid uri
    ''',
  );
  return uri;
  }

  String _createStreamUrl(
  String url,
  String port,
  String username,
  String password,
  ) {
  final uri = '$url:$port/$username/$password';
  assert(
    Uri.parse(uri).isAbsolute,
    '''
    The provided combination of url, port, username and password is not a
    valid uri
    ''',
  );
  return uri;
  }

  String _createMovieUrl(
  String url,
  String port,
  String username,
  String password,
  ) {
  final uri = '$url:$port/movie/$username/$password';
  assert(
    Uri.parse(uri).isAbsolute,
    '''
    The provided combination of url, port, username and password is not a
    valid uri
    ''',
  );
  return uri;
  }

  String _createSeriesUrl(
  String url,
  String port,
  String username,
  String password,
  ) {
  final uri = '$url:$port/series/$username/$password';
  assert(
    Uri.parse(uri).isAbsolute,
    '''
    The provided combination of url, port, username and password is not a
    valid uri
    ''',
  );
  return uri;
  }
}
