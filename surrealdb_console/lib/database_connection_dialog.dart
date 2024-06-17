import 'package:flutter/material.dart';
import 'package:surrealdb_console/ui/widgets/common/input_field.dart';
import 'package:surrealdb_js/surrealdb_js.dart';

class DatabaseConnectionDialog extends StatefulWidget {
  const DatabaseConnectionDialog(this.db, {super.key});

  final Surreal db;

  @override
  State<DatabaseConnectionDialog> createState() =>
      _DatabaseConnectionDialogState();
}

class _DatabaseConnectionDialogState extends State<DatabaseConnectionDialog> {
  final TextEditingController _addressPortController =
      TextEditingController(text: '127.0.0.1:8000');
  final TextEditingController _namespaceController =
      TextEditingController(text: 'test');
  final TextEditingController _databaseController =
      TextEditingController(text: 'test');
  final TextEditingController _usernameController =
      TextEditingController(text: 'root');
  final TextEditingController _passwordController =
      TextEditingController(text: 'root');
  String _selectedProtocol = 'ws'; // Default value for dropdown
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
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

                    debugPrint('Protocol: $protocol');
                    debugPrint('Address & Port: $addressPort');
                    debugPrint('Namespace: $namespace');
                    debugPrint('Database: $database');
                    debugPrint('Username: $username');
                    debugPrint('Password: $password');
                    try {
                      await widget.db.connect('$protocol://$addressPort/');
                      await widget.db.use(
                        namespace: namespace,
                        database: database,
                      );
                      await widget.db.signin(
                        {'username': username, 'password': password},
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    } catch (e) {
                      final error = e.toString();
                      setState(() {
                        if (error.startsWith('VersionRetrievalFailure')) {
                          _errorMessage = 'Unable to connect to database!';
                        } else if (error.endsWith('authentication')) {
                          _errorMessage = 'Invalid username or password!';
                        } else {
                          _errorMessage = error;
                        }
                      });
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
