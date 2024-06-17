import 'package:flutter/material.dart';
import 'package:surrealdb_console/ui/widgets/common/input_field.dart';

class DatabaseConnectionDialog extends StatefulWidget {
  const DatabaseConnectionDialog(
      {super.key,
      this.protocol,
      this.addressPort,
      this.namespace,
      this.database,
      this.username,
      this.password,
      this.errorMessage = '',
      required this.connectFunction});

  final Function connectFunction;
  final String? protocol;
  final String? addressPort;
  final String? namespace;
  final String? database;
  final String? username;
  final String? password;
  final String errorMessage;

  @override
  State<DatabaseConnectionDialog> createState() =>
      _DatabaseConnectionDialogState();
}

class _DatabaseConnectionDialogState extends State<DatabaseConnectionDialog> {
  late TextEditingController _addressPortController;
  late TextEditingController _namespaceController;
  late TextEditingController _databaseController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  String _selectedProtocol = 'ws'; // Default value for dropdown
  late String _errorMessage;

  @override
  void initState() {
    super.initState();
    _errorMessage = widget.errorMessage;
    _addressPortController =
        TextEditingController(text: widget.addressPort ?? '127.0.0.1:8000');
    _namespaceController =
        TextEditingController(text: widget.namespace ?? 'test');
    _databaseController =
        TextEditingController(text: widget.database ?? 'test');
    _usernameController =
        TextEditingController(text: widget.username ?? 'root');
    _passwordController =
        TextEditingController(text: widget.password ?? 'root');
    _addressPortController.addListener(clearErrorMessage);
    _namespaceController.addListener(clearErrorMessage);
    _databaseController.addListener(clearErrorMessage);
    _usernameController.addListener(clearErrorMessage);
    _passwordController.addListener(clearErrorMessage);
  }

  @override
  void dispose() {
    _addressPortController.dispose();
    _namespaceController.dispose();
    _databaseController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void clearErrorMessage() {
    setState(() {
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Connection',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[50], // Light red background color
                    border: Border.all(color: Colors.red), // Red border color
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100.0,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    value: _selectedProtocol,
                    items: const [
                      DropdownMenuItem(
                        value: 'http',
                        child: Text('http'),
                      ),
                      DropdownMenuItem(
                        value: 'https',
                        child: Text('https'),
                      ),
                      DropdownMenuItem(
                        value: 'ws',
                        child: Text('ws'),
                      ),
                      DropdownMenuItem(
                        value: 'wss',
                        child: Text('wss'),
                      ),
                    ],
                    onChanged: (value) {
                      clearErrorMessage();
                      _selectedProtocol = value!;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InputField(
                    hintText: 'address:port',
                    controller: _addressPortController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        labelText: 'Namespace',
                        controller: _namespaceController,
                      ),
                      InputField(
                        labelText: 'Database',
                        controller: _databaseController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        labelText: 'Username',
                        controller: _usernameController,
                      ),
                      InputField(
                        labelText: 'Password',
                        controller: _passwordController,
                        textInputType: TextInputType.none,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String protocol = _selectedProtocol;
                    String addressPort = _addressPortController.text;
                    String namespace = _namespaceController.text;
                    String database = _databaseController.text;
                    String username = _usernameController.text;
                    String password = _passwordController.text;

                    final errorMessage = await widget.connectFunction(
                        false,
                        protocol,
                        addressPort,
                        namespace,
                        database,
                        username,
                        password);

                    if (errorMessage != null && errorMessage.isNotEmpty) {
                      setState(() {
                        _errorMessage = errorMessage;
                      });
                    } else {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Connect'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
