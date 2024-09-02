import 'dart:io';

import 'package:dart_server/app_module.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
//import 'api/teste_api.dart';
//import 'infra/custom_server.dart';
//import 'utils/env_manager.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

bool dontCheckCNNRequests(String origin) {
  if (origin.contains('http://localhost')) {
    return true;
  }
  return false;
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  final hasuraServerUrl = "http://192.168.56.1:8080/v1/graphql";

  final overrideHeaders = {
    ACCESS_CONTROL_ALLOW_ORIGIN: '*',
    ACCESS_CONTROL_ALLOW_METHODS: 'POST, OPTIONS, GET, DELETE, PUT',
    ACCESS_CONTROL_ALLOW_HEADERS:
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  };

  final handler = const Pipeline()
      .addMiddleware(
        corsHeaders(
          headers: overrideHeaders,
          originChecker: dontCheckCNNRequests,
        ),
      )
      .addHandler(
        Modular(
          module: AppModule(
            hasuraServerURL: hasuraServerUrl,
            hasuraGraphQLAdminSecret: 'myadminsecretkey',
          ),
        ),
      );

  final restServer = await io.serve(
    handler,
    '0.0.0.0',
    4000,
  );
  print(
    'Server online: ${restServer.address.host} '
    '${restServer.address.address}:${restServer.port}',
  );

//  await CustomServer().initialize(
//      handler: ApiTeste().handler,
//      address: await EnvManager.get<String>(key: "server_address"),
//      port: await EnvManager.get<int>(key: "server_port"));
}
