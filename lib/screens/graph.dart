import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/models/performance.dart';

class OrdinalComboBarLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  OrdinalComboBarLineChart(this.seriesList, {this.animate});

  factory OrdinalComboBarLineChart.withSampleData(
      PerformanceData performanceData) {
    return new OrdinalComboBarLineChart(
      _createSampleData(performanceData),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
//    List<charts.Series> seriesList = _createSampleData();

    return new charts.OrdinalComboChart(seriesList,
        animate: animate,

        // Configure the default renderer as a bar renderer.
        domainAxis: new charts.OrdinalAxisSpec(
            renderSpec: new charts.SmallTickRendererSpec(

                // Tick and Label styling here.
                labelStyle: new charts.TextStyleSpec(
                    fontSize: 15, // size in Pts.
                    color: Injector.isBusinessMode?charts.MaterialPalette.white:charts.MaterialPalette.black),

                // Change the line colors to match text color.
                lineStyle: new charts.LineStyleSpec(
                    color: charts.MaterialPalette.white))),
        primaryMeasureAxis: new charts.NumericAxisSpec(
            renderSpec: new charts.GridlineRendererSpec(

              // Tick and Label styling here.
                labelStyle: new charts.TextStyleSpec(
                    fontSize: 15, // size in Pts.
                    color: Injector.isBusinessMode?charts.MaterialPalette.white:charts.MaterialPalette.black),

                // Change the line colors to match text color.
                lineStyle: new charts.LineStyleSpec(
                    color: charts.MaterialPalette.black))),
        defaultRenderer: new charts.BarRendererConfig(
          groupingType: charts.BarGroupingType.grouped,
        ),
        // Custom renderer configuration for the line series. This will be used for
        // any series that does not define a rendererIdKey.
        customSeriesRenderers: [
          new charts.LineRendererConfig(
            // ID used to link serieste to this renderer.
            customRendererId: 'customLine',
          )
        ]);
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData(
      PerformanceData performanceData) {
    List<OrdinalSales> costData = List();
    List<OrdinalSales> revenueData = List();
    List<OrdinalSales> cashData = List();

    performanceData.graph?.forEach((graph) {
      costData.add(
        new OrdinalSales(graph.day.toString(), graph.cost),
      );
      revenueData.add(
        new OrdinalSales(graph.day.toString(), graph.revenue),
      );
      cashData.add(
        new OrdinalSales(graph.day.toString(), graph.cash),
      );
    });

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'cost',
          colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: costData),
      new charts.Series<OrdinalSales, String>(
          id: 'revenue',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: revenueData),
      new charts.Series<OrdinalSales, String>(
          id: 'cash',
          colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: cashData)
        // Configure our custom line renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
