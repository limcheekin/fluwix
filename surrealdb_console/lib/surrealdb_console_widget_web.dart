import 'package:console/console.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:surrealdb_console/database_connection_dialog.dart';
import 'package:surrealdb_js/surrealdb_js.dart';

class SurrealdbConsoleWidget extends StatefulWidget {
  const SurrealdbConsoleWidget({
    super.key,
  });

  @override
  State<SurrealdbConsoleWidget> createState() => _SurrealdbConsoleWidgetState();
}

class _SurrealdbConsoleWidgetState extends State<SurrealdbConsoleWidget> {
  final db = Surreal();
  static const rpcUri = '/rpc';
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future<String?> initFunction() async {
    final protocol = await storage.read(key: 'protocol');
    if (protocol == null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DatabaseConnectionDialog(connectFunction: connect);
        },
      );
    } else {
      final addressPort = await storage.read(key: 'addressPort');
      final namespace = await storage.read(key: 'namespace');
      final database = await storage.read(key: 'database');
      final username = await storage.read(key: 'username');
      final password = await storage.read(key: 'password');
      final errorMessage = await connect(
        true,
        protocol,
        addressPort!,
        namespace!,
        database!,
        username!,
        password!,
      );
      if (errorMessage != null && errorMessage.isNotEmpty) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return DatabaseConnectionDialog(
              connectFunction: connect,
              errorMessage: errorMessage,
              protocol: protocol,
              addressPort: addressPort,
              namespace: namespace,
              database: database,
              username: username,
              password: password,
            );
          },
        );
      }
    }
    return getConnectionInfo();
  }

  Future<String?> showDatabaseConnectionDialog() async {
    final protocol = await storage.read(key: 'protocol');

    final addressPort = await storage.read(key: 'addressPort');
    final namespace = await storage.read(key: 'namespace');
    final database = await storage.read(key: 'database');
    final username = await storage.read(key: 'username');
    final password = await storage.read(key: 'password');
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DatabaseConnectionDialog(
          connectFunction: connect,
          protocol: protocol,
          addressPort: addressPort,
          namespace: namespace,
          database: database,
          username: username,
          password: password,
        );
      },
    );
    return getConnectionInfo();
  }

  Future<String?> connect(
    bool valuesfromStorage,
    String protocol,
    String addressPort,
    String namespace,
    String database,
    String username,
    String password,
  ) async {
    String? errorMessage;
    debugPrint('Protocol: $protocol');
    debugPrint('Address & Port: $addressPort');
    debugPrint('Namespace: $namespace');
    debugPrint('Database: $database');
    debugPrint('Username: $username');
    if (!addressPort.endsWith(rpcUri)) {
      addressPort = '$addressPort$rpcUri';
    }
    try {
      await db.connect('$protocol://$addressPort');
      await db.use(
        namespace: namespace,
        database: database,
      );
      await db.signin(
        {'username': username, 'password': password},
      );

      if (!valuesfromStorage) {
        await storage.write(key: 'protocol', value: protocol);
        await storage.write(key: 'addressPort', value: addressPort);
        await storage.write(key: 'namespace', value: namespace);
        await storage.write(key: 'database', value: database);
        await storage.write(key: 'username', value: username);
        await storage.write(key: 'password', value: password);
      }
    } catch (e) {
      final error = e.toString();

      if (error.startsWith('VersionRetrievalFailure')) {
        errorMessage = 'Unable to connect to database!';
      } else if (error.endsWith('authentication')) {
        errorMessage = 'Invalid username or password!';
      } else {
        errorMessage = error;
      }
    }
    return errorMessage;
  }

  Future<Object?> executeFunction(String value) async {
    if (value == 'connect') {
      return showDatabaseConnectionDialog();
    } else {
      return db.query(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Console(
      content: '',
      initFunction: initFunction,
      executeFunction: executeFunction,
    );
  }

  Future<String?> getConnectionInfo() async {
    final protocol = await storage.read(key: 'protocol');
    if (protocol != null) {
      final addressPort = await storage.read(key: 'addressPort');
      final namespace = await storage.read(key: 'namespace');
      final database = await storage.read(key: 'database');
      final version = await db.version();
      return '''
Connected to $protocol://$addressPort, ns: $namespace, db: $database.
$version.
''';
    }
    return null;
  }
}
