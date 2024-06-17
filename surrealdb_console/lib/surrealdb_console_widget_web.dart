import 'package:console/console.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  Future<void> initFunction() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DatabaseConnectionDialog(db);
      },
    );
  }

  Future<Object?> executeFunction(String value) async {
    return db.query(value);
  }

  @override
  Widget build(BuildContext context) {
    return Console(
      content: 'Connected to ...\n',
      initFunction: initFunction,
      executeFunction: executeFunction,
    );
  }
}
