import 'package:flutter/material.dart';

class SurrealdbConsoleWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Surrealdb Console is working in web only!'),
    );
  }
}
