import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectWidget extends StatelessWidget {
  const ShimmerEffectWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Center(
            child: Text('Shimmer Effect is not supported in Flutter Web!'),
          )
        : DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: 'Loading List',
                    ),
                    Tab(
                      text: 'Slide To Unlock',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      LoadingListPage(),
                      SlideToUnlockPage(),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

class LoadingListPage extends StatefulWidget {
  @override
  _LoadingListPageState createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: _enabled,
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 48.0,
                        height: 48.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 40.0,
                              height: 8.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                itemCount: 6,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton(
                onPressed: () {
                  setState(() {
                    _enabled = !_enabled;
                  });
                },
                child: Text(
                  _enabled ? 'Stop' : 'Play',
                  style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 18.0,
                      color: _enabled ? Colors.redAccent : Colors.green),
                )),
          )
        ],
      ),
    );
  }
}

class SlideToUnlockPage extends StatelessWidget {
  final List<String> days = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final List<String> months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();
    final hour = time.hour;
    final minute = time.minute;
    final day = time.weekday;
    final month = time.month;
    final dayInMonth = time.day;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          'packages/shimmer_effect/assets/background.jpg',
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 48.0,
          right: 0.0,
          left: 0.0,
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  '${hour < 10 ? '0$hour' : '$hour'}:${minute < 10 ? '0$minute' : '$minute'}',
                  style: const TextStyle(
                    fontSize: 60.0,
                    color: Colors.white,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                ),
                Text(
                  '${days[day - 1]}, ${months[month - 1]} $dayInMonth',
                  style: const TextStyle(fontSize: 24.0, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 24.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Opacity(
                opacity: 0.8,
                child: Shimmer.fromColors(
                  baseColor: Colors.black12,
                  highlightColor: Colors.white,
                  loop: 3,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'packages/shimmer_effect/assets/chevron_right.png',
                        height: 20.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                      ),
                      const Text(
                        'Slide to unlock',
                        style: TextStyle(
                          fontSize: 28.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
