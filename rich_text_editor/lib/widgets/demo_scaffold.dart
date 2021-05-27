import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

typedef DemoContentBuilder = Widget Function(
    BuildContext context, QuillController? controller);

// Common scaffold for all examples.
class DemoScaffold extends StatefulWidget {
  const DemoScaffold({
    required this.documentFilename,
    required this.builder,
    this.actions,
    this.showToolbar = true,
    this.floatingActionButton,
    Key? key,
  }) : super(key: key);

  /// Filename of the document to load into the editor.
  final String documentFilename;
  final DemoContentBuilder builder;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool showToolbar;

  @override
  _DemoScaffoldState createState() => _DemoScaffoldState();
}

class _DemoScaffoldState extends State<DemoScaffold> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  QuillController? _controller;

  bool _loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller == null && !_loading) {
      _loading = true;
      _loadFromAssets();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _loadFromAssets() async {
    try {
      final result = await rootBundle.loadString(
          'packages/rich_text_editor/assets/${widget.documentFilename}');
      final doc = Document.fromJson(jsonDecode(result));
      setState(() {
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
        _loading = false;
      });
    } catch (error) {
      final doc = Document()..insert(0, 'Empty asset');
      setState(() {
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final actions = widget.actions ?? <Widget>[];
    return Scaffold(
      key: _scaffoldKey,
      appBar: _loading || widget.showToolbar == false
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).canvasColor,
              centerTitle: false,
              titleSpacing: 0,
              title: QuillToolbar.basic(controller: _controller!),
              actions: actions,
            ),
      floatingActionButton: widget.floatingActionButton,
      body: _loading
          ? const Center(child: Text('Loading...'))
          : widget.builder(context, _controller),
    );
  }
}
