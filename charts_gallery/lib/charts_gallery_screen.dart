import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';
import 'a11y/a11y_gallery.dart' as a11y show buildGallery;
import 'bar_chart/bar_gallery.dart' as bar show buildGallery;
import 'time_series_chart/time_series_gallery.dart' as time_series
    show buildGallery;
import 'line_chart/line_gallery.dart' as line show buildGallery;
import 'scatter_plot_chart/scatter_plot_gallery.dart' as scatter_plot
    show buildGallery;
import 'combo_chart/combo_gallery.dart' as combo show buildGallery;
import 'pie_chart/pie_gallery.dart' as pie show buildGallery;
import 'axes/axes_gallery.dart' as axes show buildGallery;
import 'behaviors/behaviors_gallery.dart' as behaviors show buildGallery;
import 'i18n/i18n_gallery.dart' as i18n show buildGallery;
import 'legends/legends_gallery.dart' as legends show buildGallery;

class ChartsGalleryScreen extends StatelessWidget {
  const ChartsGalleryScreen({Key? key}) : super(key: key);

  static const owner = 'google';
  static const repository = 'charts';
  static const branch = 'master';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Charts Gallery',
      widget: ChartsGalleryWidget(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: 'README.md',
      codePaths: [
        'charts_flutter/example/pubspec.yaml',
        'charts_flutter/example/lib/main.dart',
        'charts_flutter/example/lib/home.dart',
      ],
    );
  }
}

class ChartsGalleryWidget extends StatelessWidget {
  ChartsGalleryWidget({Key? key}) : super(key: key);
  final a11yGalleries = a11y.buildGallery();
  final barGalleries = bar.buildGallery();
  final timeSeriesGalleries = time_series.buildGallery();
  final lineGalleries = line.buildGallery();
  final scatterPlotGalleries = scatter_plot.buildGallery();
  final comboGalleries = combo.buildGallery();
  final pieGalleries = pie.buildGallery();
  final axesGalleries = axes.buildGallery();
  final behaviorsGalleries = behaviors.buildGallery();
  final i18nGalleries = i18n.buildGallery();
  final legendsGalleries = legends.buildGallery();

  @override
  Widget build(BuildContext context) {
    var galleries = <Widget>[];

    galleries.addAll(
        a11yGalleries.map((gallery) => gallery.buildGalleryListTile(context)));

    // Add example bar charts.
    galleries.addAll(
        barGalleries.map((gallery) => gallery.buildGalleryListTile(context)));

    // Add example time series charts.
    galleries.addAll(timeSeriesGalleries
        .map((gallery) => gallery.buildGalleryListTile(context)));

    // Add example line charts.
    galleries.addAll(
        lineGalleries.map((gallery) => gallery.buildGalleryListTile(context)));

    // Add example scatter plot charts.
    galleries.addAll(scatterPlotGalleries
        .map((gallery) => gallery.buildGalleryListTile(context)));

    // Add example pie charts.
    galleries.addAll(
        comboGalleries.map((gallery) => gallery.buildGalleryListTile(context)));

    // Add example pie charts.
    galleries.addAll(
        pieGalleries.map((gallery) => gallery.buildGalleryListTile(context)));

    // Add example custom axis.
    galleries.addAll(
        axesGalleries.map((gallery) => gallery.buildGalleryListTile(context)));

    galleries.addAll(behaviorsGalleries
        .map((gallery) => gallery.buildGalleryListTile(context)));

    // Add legends examples
    galleries.addAll(legendsGalleries
        .map((gallery) => gallery.buildGalleryListTile(context)));

    // Add examples for i18n.
    galleries.addAll(
        i18nGalleries.map((gallery) => gallery.buildGalleryListTile(context)));

    return ListView(padding: kMaterialListPadding, children: galleries);
  }
}
