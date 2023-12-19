import 'package:flutter/material.dart';

const largeScreenWidth = 800.0;
const mediumScreenWidth = 600.0;

class ThreeColsLayoutWidget extends StatelessWidget {
  const ThreeColsLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Three Cols Layout'),
            leading: constraints.maxWidth < largeScreenWidth
                ? Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu_open),
                    ),
                  )
                : null,
            actions: [
              if (constraints.maxWidth < mediumScreenWidth)
                Builder(
                  builder: (context) => IconButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: const Icon(Icons.settings),
                  ),
                ),
            ],
          ),
          body: BodyWidget(constraints.maxWidth),
          drawer: constraints.maxWidth < largeScreenWidth
              ? const Drawer(
                  child: RedWidget(),
                )
              : null,
          endDrawer: constraints.maxWidth < mediumScreenWidth
              ? const Drawer(
                  child: BlueWidget(),
                )
              : null,
        );
      },
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget(this.maxWidth, {super.key});

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    if (maxWidth >= largeScreenWidth) {
      return const Row(
        children: [
          Flexible(
            flex: 3,
            child: RedWidget(),
          ),
          Flexible(
            flex: 4,
            child: GreenWidget(),
          ),
          Flexible(
            flex: 3,
            child: BlueWidget(),
          ),
        ],
      );
    } else if (maxWidth >= mediumScreenWidth) {
      return const Row(
        children: [
          Flexible(
            flex: 6,
            child: GreenWidget(),
          ),
          Flexible(
            flex: 4,
            child: BlueWidget(),
          ),
        ],
      );
    } else {
      return const Center(
        child: GreenWidget(),
      );
    }
  }
}

class BlueWidget extends StatelessWidget {
  const BlueWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}

class GreenWidget extends StatelessWidget {
  const GreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green);
  }
}

class RedWidget extends StatelessWidget {
  const RedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}
