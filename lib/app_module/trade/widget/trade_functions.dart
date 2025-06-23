import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart'; // Make sure you import material.dart

Widget buildSparkline(List<double> dataPoints, bool isLoss) {
  if (dataPoints.isEmpty) {
    return SizedBox.shrink();
  }

  // Normalize data points between 0 and 1 for better curve
  double minValue = dataPoints.reduce(min);
  double maxValue = dataPoints.reduce(max);
  double range = maxValue - minValue;

  List<FlSpot> spots = List.generate(dataPoints.length, (i) {
    double y = range == 0 ? 0.5 : (dataPoints[i] - minValue) / range;
    return FlSpot(i.toDouble(), y);
  });

  return SizedBox(
    height: 40,
    width: 100,
    child: LineChart(
      LineChartData(
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.3, // Adjust for smoother curve (0-1)
            color: isLoss ? Colors.red : Colors.green,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
            barWidth: 2,
          )
        ],
      ),
    ),
  );
}