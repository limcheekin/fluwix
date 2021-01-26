import 'dart:convert';

import 'package:flutter/material.dart';
import 'quarterly_result.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class ChartDataTableScreen extends StatelessWidget {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  static const profitMarginLineRendererId = 'profitMarginLine';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chart & Data Table"),
      ),
      body: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/chart_datatable/quarterly_result.json'),
          builder: (context, snapshot) {
            final quarterResults = _getQuarterlyResults(snapshot);

            return Column(
              children: [
                SizedBox(
                  height: 300,
                  child: _createChart(quarterResults),
                ),
              ],
            );
          }),
    );
  }

  Widget _createChart(final quarterResults) {
    final defaultTitleStyleSpec = charts.TextStyleSpec(
      fontSize: 14,
    );
    final List<charts.Series<QuarterlyResult, String>> seriesList = [
      charts.Series<QuarterlyResult, String>(
        id: 'Revenue',
        domainFn: (QuarterlyResult result, _) => _getDomain(result),
        measureFn: (QuarterlyResult result, _) => result.quarterRevenue * 0.001,
        data: quarterResults,
        labelAccessorFn: (QuarterlyResult result, _) =>
            '${(result.quarterRevenue * 0.001).round()}',
      ),
      charts.Series<QuarterlyResult, String>(
        id: 'Profit',
        domainFn: (QuarterlyResult result, _) => _getDomain(result),
        measureFn: (QuarterlyResult result, _) => result.quarterProfit * 0.001,
        data: quarterResults,
        labelAccessorFn: (QuarterlyResult result, _) =>
            '${(result.quarterProfit * 0.001).round()}',
      ),
      charts.Series<QuarterlyResult, String>(
        id: 'Profit Margin',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (QuarterlyResult result, _) => _getDomain(result),
        measureFn: (QuarterlyResult result, _) =>
            result.quarterProfitMargin * 100,
        data: quarterResults,
      )
        ..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId)
        // Configure our custom line renderer for this series.
        ..setAttribute(charts.rendererIdKey, profitMarginLineRendererId),
    ];

    final midIndex = quarterResults.length ~/ 2;

    return charts.OrdinalComboChart(
      seriesList,
      animate: false,
      // Configure the default renderer as a bar renderer.
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        // Set a bar label decorator.
        // Example configuring different styles for inside/outside:
        //       barRendererDecorator: charts.BarLabelDecorator(
        //          insideLabelStyleSpec: charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: charts.TextStyleSpec(...)),
        barRendererDecorator: charts.BarLabelDecorator<String>(
          labelPosition: charts.BarLabelPosition.outside,
        ),
      ),
      // Custom renderer configuration for the line series. This will be used for
      // any series that does not define a rendererIdKey.
      customSeriesRenderers: [
        charts.LineRendererConfig(
          // ID used to link series to this renderer.
          customRendererId: profitMarginLineRendererId,
          //includePoints: true,
        )
      ],
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickFormatterSpec:
            charts.BasicNumericTickFormatterSpec.fromNumberFormat(
          NumberFormat.compact(),
        ),
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          desiredTickCount: 6,
        ),
      ),
      secondaryMeasureAxis: charts.NumericAxisSpec(
        /*tickFormatterSpec:
                          charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                        NumberFormat.percentPattern(),
                      ),*/
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          desiredTickCount: 6,
        ),
      ),

      // Set the initial viewport by providing a AxisSpec with the
      // desired viewport: a starting domain and the data size.
      domainAxis: charts.OrdinalAxisSpec(
          viewport: charts.OrdinalViewport(
        _getDomain(quarterResults[midIndex]),
        midIndex,
      )),
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.bottom,
        ), // legend display above the chart by default
        charts.PanAndZoomBehavior(),

        // chart titles
        charts.ChartTitle('Quarterly Results',
            subTitle: 'Revenue, Profit and Profit Margin',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start,
            // Set a larger inner padding than the default (10) to avoid
            // rendering the text too close to the top measure axis tick label.
            // The top tick label may extend upwards into the top margin region
            // if it is located at the top of the draw area.
            innerPadding: 18),
        charts.ChartTitle('Quarter',
            titleStyleSpec: defaultTitleStyleSpec,
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        charts.ChartTitle('Million',
            titleStyleSpec: defaultTitleStyleSpec,
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        charts.ChartTitle('Percentage',
            titleStyleSpec: defaultTitleStyleSpec,
            behaviorPosition: charts.BehaviorPosition.end,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
      ],
    );
  }

  List<QuarterlyResult> _getQuarterlyResults(snapshot) {
    final list = json.decode(snapshot.data.toString())['list'];

    print('list.length = ${list.length}');
    return List.generate(
            list.length, (index) => QuarterlyResult.fromJson(list[index]))
        .reversed
        .toList();
  }

  String _getDomain(QuarterlyResult result) {
    final dateFormat = DateFormat('yy');
    final year = dateFormat.format(result.financialYearEnd);
    return '${year}Q${result.quarter}';
  }
}
