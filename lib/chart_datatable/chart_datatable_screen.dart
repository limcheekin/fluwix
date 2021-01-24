import 'dart:convert';

import 'package:flutter/material.dart';
import 'quarterly_result.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartDataTableScreen extends StatelessWidget {
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
            final list = json.decode(snapshot.data.toString());
            final quarterResults = List.generate(
                list.length, (index) => QuarterlyResult.fromJson(list[index]));
            //.reversed
            //.toList();

            final List<charts.Series<QuarterlyResult, String>> seriesList = [
              charts.Series<QuarterlyResult, String>(
                id: 'Revenue',
                domainFn: (QuarterlyResult result, _) =>
                    '${result.financialYearEnd.year}Q${result.quarter}',
                measureFn: (QuarterlyResult result, _) => result.quarterRevenue,
                data: quarterResults,
              ),
              charts.Series<QuarterlyResult, String>(
                id: 'Profit',
                domainFn: (QuarterlyResult result, _) =>
                    '${result.financialYearEnd.year}Q${result.quarter}',
                measureFn: (QuarterlyResult result, _) => result.quarterProfit,
                data: quarterResults,
              )
            ];

            return Column(
              children: [
                SizedBox(
                  height: 300,
                  child: charts.BarChart(
                    seriesList,
                    animate: false,
                    barGroupingType: charts.BarGroupingType.grouped,
                  ),
                ),
                Placeholder(
                  fallbackHeight: 300,
                ),
              ],
            );
          }),
    );
  }
}
