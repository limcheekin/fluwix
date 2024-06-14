import 'package:flutter/material.dart';
import 'package:surrealdb_console/ui/widgets/common/input_field.dart';

class ConnectButton extends StatefulWidget {
  const ConnectButton({super.key});

  @override
  State<ConnectButton> createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<ConnectButton> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _namespaceController = TextEditingController();
  final TextEditingController _databaseController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
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
                            value: 'ws',
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
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: InputField(
                            hintText: 'address:port',
                            controller: _urlController,
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
                          onPressed: () {},
                          child: const Text('Connect'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Text('Connect'),
    );
  }
}
