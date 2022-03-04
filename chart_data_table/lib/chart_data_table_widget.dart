import 'dart:convert';

import 'package:flutter/material.dart';
import 'quarterly_result.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class ChartDataTableWidget extends StatelessWidget {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  static const profitMarginLineRendererId = 'profitMarginLine';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('packages/chart_data_table/assets/quarterly_result.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final quarterResults = _getQuarterlyResults(snapshot);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: _createChart(quarterResults),
                  ),
                  Divider(),
                  _createDataTable(quarterResults),
                ],
              ),
            ),
          );
        } else {
          return Text('No data loaded');
        }
      },
    );
  }

  Widget _createChart(final quarterResults) {
    var reversedQuarterResults = quarterResults.reversed.toList();
    final defaultTitleStyleSpec = charts.TextStyleSpec(
      fontSize: 14,
    );
    final seriesList = [
      charts.Series<QuarterlyResult, String>(
        id: 'Revenue',
        domainFn: (QuarterlyResult result, _) => _getDomain(result),
        measureFn: (QuarterlyResult result, _) => result.quarterRevenue * 0.001,
        data: reversedQuarterResults,
        labelAccessorFn: (QuarterlyResult result, _) =>
            '\$${(result.quarterRevenue * 0.001).round()}',
      ),
      charts.Series<QuarterlyResult, String>(
        id: 'Profit',
        domainFn: (QuarterlyResult result, _) => _getDomain(result),
        measureFn: (QuarterlyResult result, _) => result.quarterProfit * 0.001,
        data: reversedQuarterResults,
        labelAccessorFn: (QuarterlyResult result, _) =>
            '\$${(result.quarterProfit * 0.001).round()}',
      ),
      charts.Series<QuarterlyResult, String>(
        id: 'Profit Margin (%)',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (QuarterlyResult result, _) => _getDomain(result),
        measureFn: (QuarterlyResult result, _) =>
            result.quarterProfitMargin * 100,
        data: reversedQuarterResults,
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
          outsideLabelStyleSpec: charts.TextStyleSpec(
            fontSize: 10,
            color: charts.Color.black,
          ),

          //labelPadding: 0,
        ),
      ),
      // Custom renderer configuration for the line series. This will be used for
      // any series that does not define a rendererIdKey.
      customSeriesRenderers: [
        charts.LineRendererConfig(
          // ID used to link series to this renderer.
          customRendererId: profitMarginLineRendererId,
          includePoints: true,
        )
      ],
      primaryMeasureAxis: charts.NumericAxisSpec(
        //tickFormatterSpec:
        //    charts.BasicNumericTickFormatterSpec.fromNumberFormat(
        //  NumberFormat.compact(),
        //),
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
        _getDomain(reversedQuarterResults[midIndex]),
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

  Widget _createDataTable(List<QuarterlyResult> quarterResults) {
    final dateFormat = DateFormat('dd MMM yy');
    final quarterFormat = DateFormat('MMM yy');
    final numberFormat = NumberFormat('###,###,###,###');
    var year = quarterResults[0].financialYearEnd.year;
    Color? dataRowColor = Colors.transparent;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 28.0,
        dataRowHeight: 36.0,
        headingRowColor: MaterialStateProperty.resolveWith(
          (_) => Colors.grey[300],
        ),
        columns: [
          DataColumn(
            label: Text('Date'),
            numeric: false,
          ),
          DataColumn(
            label: Text('Financial Year'),
            numeric: false,
          ),
          DataColumn(
            label: Text('Quarter'),
            numeric: false,
          ),
          DataColumn(
            label: SizedBox(
              width: 100.0,
              //width: 100.0,
              child: Text(
                'Revenue (RM,000)',
                softWrap: true,
                textAlign: TextAlign.right,
              ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: SizedBox(
              width: 80.0,
              child: Text(
                'Profit (RM,000)',
                softWrap: true,
                textAlign: TextAlign.right,
              ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: SizedBox(
              width: 100.0,
              child: Text(
                'Profit Margin (%)',
                softWrap: true,
                textAlign: TextAlign.right,
              ),
            ),
            numeric: true,
          ),
        ],
        rows: quarterResults
            .map(
              (result) => DataRow(
                color: MaterialStateProperty.resolveWith(
                  (_) {
                    if (year != result.financialYearEnd.year) {
                      dataRowColor = dataRowColor == Colors.transparent
                          ? Colors.grey[300]
                          : Colors.transparent;
                      year = result.financialYearEnd.year;
                    }
                    return dataRowColor;
                  },
                ),
                cells: [
                  DataCell(
                    Text(dateFormat.format(result.dateAnnounced)),
                  ),
                  DataCell(
                    Text(dateFormat.format(result.financialYearEnd)),
                  ),
                  DataCell(
                    Text(
                        'Q${result.quarter} ${quarterFormat.format(result.quarterEnd)}'),
                  ),
                  DataCell(
                    Text(numberFormat.format(result.quarterRevenue)),
                  ),
                  DataCell(
                    Text(numberFormat.format(result.quarterProfit)),
                  ),
                  DataCell(
                    Text(NumberFormat.decimalPercentPattern(decimalDigits: 1)
                        .format(result.quarterProfitMargin)),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  List<QuarterlyResult> _getQuarterlyResults(snapshot) {
    final list = json.decode(snapshot.data.toString())['list'];

    print('list.length = ${list.length}');
    return List.generate(
        list.length, (index) => QuarterlyResult.fromJson(list[index]));
  }

  String _getDomain(QuarterlyResult result) {
    final dateFormat = DateFormat('yy');
    final year = dateFormat.format(result.financialYearEnd);
    return '${year}Q${result.quarter}';
  }
}
