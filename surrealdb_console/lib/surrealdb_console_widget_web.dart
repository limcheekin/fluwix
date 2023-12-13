import 'package:console/console.dart';
import 'package:flutter/widgets.dart';
import 'package:surrealdb_wasm/surrealdb_wasm.dart';

class SurrealdbConsoleWidget extends StatefulWidget {
  const SurrealdbConsoleWidget({
    required this.endpoint,
    this.ns,
    this.db,
    super.key,
  });

  final String endpoint;
  final String? ns;
  final String? db;

  @override
  State<SurrealdbConsoleWidget> createState() => _SurrealdbConsoleWidgetState();
}

class _SurrealdbConsoleWidgetState extends State<SurrealdbConsoleWidget> {
  final db = Surreal();

  Future<void> initFunction() async {
    await db.connect(widget.endpoint);
    if (widget.ns != null && widget.db != null) {
      await db.use(ns: widget.ns, db: widget.db);
    }
  }

  Future<Object?> executeFunction(String value) async {
    return db.query(value);
  }

  @override
  Widget build(BuildContext context) {
    return Console(
      content:
          'Connected to ${widget.endpoint}, ns: ${widget.ns}, db: ${widget.db}.\n',
      initFunction: initFunction,
      executeFunction: executeFunction,
    );
  }
}
