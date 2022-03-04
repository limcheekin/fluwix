// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Example of the chart behavior that centers the viewport on domain selection.

// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SlidingViewportOnSelection extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  SlidingViewportOnSelection(this.seriesList, {this.animate = false});

  /// Creates a [BarChart] with sample data and no transition.
  factory SlidingViewportOnSelection.withSampleData() {
    return new SlidingViewportOnSelection(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory SlidingViewportOnSelection.withRandomData() {
    return new SlidingViewportOnSelection(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<OrdinalSales, String>> _createRandomData() {
    final random = new Random();

    final data = [
      new OrdinalSales('2014', random.nextInt(100)),
      new OrdinalSales('2015', random.nextInt(100)),
      new OrdinalSales('2016', random.nextInt(100)),
      new OrdinalSales('2017', random.nextInt(100)),
      new OrdinalSales('2018', random.nextInt(100)),
      new OrdinalSales('2019', random.nextInt(100)),
      new OrdinalSales('2020', random.nextInt(100)),
      new OrdinalSales('2021', random.nextInt(100)),
      new OrdinalSales('2022', random.nextInt(100)),
      new OrdinalSales('2023', random.nextInt(100)),
      new OrdinalSales('2024', random.nextInt(100)),
      new OrdinalSales('2025', random.nextInt(100)),
      new OrdinalSales('2026', random.nextInt(100)),
      new OrdinalSales('2027', random.nextInt(100)),
      new OrdinalSales('2028', random.nextInt(100)),
      new OrdinalSales('2029', random.nextInt(100)),
      new OrdinalSales('2030', random.nextInt(100)),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      behaviors: [
        // Add the sliding viewport behavior to have the viewport center on the
        // domain that is currently selected.
        new charts.SlidingViewport(),
        // A pan and zoom behavior helps demonstrate the sliding viewport
        // behavior by allowing the data visible in the viewport to be adjusted
        // dynamically.
        new charts.PanAndZoomBehavior(),
      ],
      // Set an initial viewport to demonstrate the sliding viewport behavior on
      // initial chart load.
      domainAxis: new charts.OrdinalAxisSpec(
          viewport: new charts.OrdinalViewport('2018', 4)),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
      new OrdinalSales('2018', 33),
      new OrdinalSales('2019', 80),
      new OrdinalSales('2020', 21),
      new OrdinalSales('2021', 77),
      new OrdinalSales('2022', 8),
      new OrdinalSales('2023', 12),
      new OrdinalSales('2024', 42),
      new OrdinalSales('2025', 70),
      new OrdinalSales('2026', 77),
      new OrdinalSales('2027', 55),
      new OrdinalSales('2028', 19),
      new OrdinalSales('2029', 66),
      new OrdinalSales('2030', 27),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
