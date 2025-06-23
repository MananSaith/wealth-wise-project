import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../model/candle_stick_model.dart';

SfCartesianChart buildCandleChart(List<CandleData> candleData) {
  return SfCartesianChart(
    backgroundColor: Colors.white,
    plotAreaBorderWidth: 0,
    title: ChartTitle(
      text: 'Candle Chart',
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    ),
    legend: Legend(isVisible: false),
    primaryXAxis: DateTimeAxis(
      majorGridLines: MajorGridLines(color: Colors.grey.shade300, width: 0.5),
      edgeLabelPlacement: EdgeLabelPlacement.shift,
      dateFormat: DateFormat.MMMd(), // May 28, etc.
      intervalType: DateTimeIntervalType.days,
      labelStyle: TextStyle(fontSize: 12, color: Colors.grey.shade700),
      enableAutoIntervalOnZooming: true,
    ),
    primaryYAxis: NumericAxis(
      opposedPosition: false,
      axisLine: AxisLine(width: 0),
      majorGridLines: MajorGridLines(color: Colors.grey.shade200),
      numberFormat: NumberFormat.compactCurrency(symbol: '\$'),
      labelStyle: TextStyle(fontSize: 12, color: Colors.grey.shade700),
    ),
    zoomPanBehavior: ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      zoomMode: ZoomMode.x,
      maximumZoomLevel: 0.4,
    ),
    trackballBehavior: TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: InteractiveTooltip(
        enable: true,
        format: 'point.x : \$point.close',
        borderColor: Colors.black,
        color: Colors.black87,
        textStyle: TextStyle(color: Colors.white),
      ),
    ),
    series: <CandleSeries>[
      CandleSeries<CandleData, DateTime>(
        dataSource: candleData,
        xValueMapper: (CandleData data, _) => data.date,
        lowValueMapper: (CandleData data, _) => data.low,
        highValueMapper: (CandleData data, _) => data.high,
        openValueMapper: (CandleData data, _) => data.open,
        closeValueMapper: (CandleData data, _) => data.close,
        bearColor: Colors.red.shade400,
        bullColor: Colors.green.shade600,
        enableTooltip: true,
        animationDuration: 800,
        dataLabelSettings: DataLabelSettings(isVisible: false),
      )
    ],
  );
}
