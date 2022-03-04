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

/// Example of a scatter plot chart using custom symbols for the points.
///
/// The series has been configured to draw each point as a square by default.
///
/// Some data will be drawn as a circle, indicated by defining a custom "circle"
/// value referenced by [pointSymbolRendererFnKey].
///
/// Some other data have will be drawn as a hollow circle. In addition to the
/// custom renderer key, these data also have stroke and fillColor values
/// defined. Configuring a separate fillColor will cause the center of the shape
/// to be filled in, with white in these examples. The border of the shape will
/// be color with the color of the data.
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ShapesScatterPlotChart extends StatelessWidget {
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  ShapesScatterPlotChart(this.seriesList, {this.animate = false});

  /// Creates a [ScatterPlotChart] with sample data and no transition.
  factory ShapesScatterPlotChart.withSampleData() {
    return new ShapesScatterPlotChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory ShapesScatterPlotChart.withRandomData() {
    return new ShapesScatterPlotChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<LinearSales, num>> _createRandomData() {
    final random = new Random();

    final makeRadius = (int value) => (random.nextInt(value) + 2).toDouble();

    final data = [
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          'circle', null, null),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null),
      // Render a hollow circle, filled in with white.
      new LinearSales(random.nextInt(100), random.nextInt(100),
          makeRadius(4) + 4, 'circle', charts.MaterialPalette.white, 2.0),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          'circle', null, null),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null),
      // Render a hollow circle, filled in with white.
      new LinearSales(random.nextInt(100), random.nextInt(100),
          makeRadius(4) + 4, 'circle', charts.MaterialPalette.white, 2.0),
      new LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null),
      // Render a hollow square, filled in with white.
      new LinearSales(random.nextInt(100), random.nextInt(100),
          makeRadius(4) + 4, null, charts.MaterialPalette.white, 2.0),
    ];

    final maxMeasure = 100;

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (LinearSales sales, _) {
          // Color bucket the measure column value into 3 distinct colors.
          final bucket = sales.sales / maxMeasure;

          if (bucket < 1 / 3) {
            return charts.MaterialPalette.blue.shadeDefault;
          } else if (bucket < 2 / 3) {
            return charts.MaterialPalette.red.shadeDefault;
          } else {
            return charts.MaterialPalette.green.shadeDefault;
          }
        },
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        radiusPxFn: (LinearSales sales, _) => sales.radius,
        fillColorFn: (LinearSales row, _) => row.fillColor,
        strokeWidthPxFn: (LinearSales row, _) => row.strokeWidth,
        data: data,
      )
        // Accessor function that associates each datum with a symbol renderer.
        ..setAttribute(
            charts.pointSymbolRendererFnKey, (int index) => data[index].shape)
        // Default symbol renderer ID for data that have no defined shape.
        ..setAttribute(charts.pointSymbolRendererIdKey, 'rect')
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.ScatterPlotChart(seriesList,
        animate: animate,
        // Configure the point renderer to have a map of custom symbol
        // renderers.
        defaultRenderer:
            new charts.PointRendererConfig<num>(customSymbolRenderers: {
          'circle': new charts.CircleSymbolRenderer(),
          'rect': new charts.RectSymbolRenderer(),
        }));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5, 3.0, 'circle', null, null),
      new LinearSales(10, 25, 5.0, null, null, null),
      new LinearSales(12, 75, 4.0, null, null, null),
      // Render a hollow circle, filled in with white.
      new LinearSales(
          13, 225, 5.0, 'circle', charts.MaterialPalette.white, 2.0),
      new LinearSales(16, 50, 4.0, null, null, null),
      new LinearSales(24, 75, 3.0, null, null, null),
      new LinearSales(25, 100, 3.0, 'circle', null, null),
      new LinearSales(34, 150, 5.0, null, null, null),
      new LinearSales(37, 10, 4.5, null, null, null),
      // Render a hollow circle, filled in with white.
      new LinearSales(
          45, 300, 8.0, 'circle', charts.MaterialPalette.white, 2.0),
      new LinearSales(52, 15, 4.0, null, null, null),
      // Render a hollow square, filled in with white.
      new LinearSales(56, 200, 7.0, null, charts.MaterialPalette.white, 2.0),
    ];

    final maxMeasure = 300;

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        // Providing a color function is optional.
        colorFn: (LinearSales sales, _) {
          // Bucket the measure column value into 3 distinct colors.
          final bucket = sales.sales / maxMeasure;

          if (bucket < 1 / 3) {
            return charts.MaterialPalette.blue.shadeDefault;
          } else if (bucket < 2 / 3) {
            return charts.MaterialPalette.red.shadeDefault;
          } else {
            return charts.MaterialPalette.green.shadeDefault;
          }
        },
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        radiusPxFn: (LinearSales sales, _) => sales.radius,
        fillColorFn: (LinearSales row, _) => row.fillColor,
        strokeWidthPxFn: (LinearSales row, _) => row.strokeWidth,
        data: data,
      )
        // Accessor function that associates each datum with a symbol renderer.
        ..setAttribute(
            charts.pointSymbolRendererFnKey, (int index) => data[index].shape)
        // Default symbol renderer ID for data that have no defined shape.
        ..setAttribute(charts.pointSymbolRendererIdKey, 'rect')
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final double radius;
  final String? shape;
  final charts.Color? fillColor;
  final double? strokeWidth;

  LinearSales(this.year, this.sales, this.radius, this.shape, this.fillColor,
      this.strokeWidth);
}
