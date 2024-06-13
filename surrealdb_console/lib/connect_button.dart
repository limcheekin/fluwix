import 'package:flutter/material.dart';

class ConnectButton extends StatelessWidget {
  const ConnectButton({super.key});

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
                  children: [
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: 'WS',
                          items: const [
                            DropdownMenuItem(
                              value: 'WS',
                              child: Text('WS'),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'address:port',
                              labelStyle: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Database'),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Namespace',
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Database',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Authentication'),
                              DropdownButton<String>(
                                value: 'Root',
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Root',
                                    child: Text('Root'),
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                              const TextField(
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                ),
                              ),
                              const TextField(
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  suffixIcon: Icon(Icons.visibility),
                                ),
                                obscureText: true,
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
