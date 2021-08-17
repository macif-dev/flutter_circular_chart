import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter_circular_chart_two/src/animated_circular_chart.dart';
import 'package:flutter_circular_chart_two/src/circular_chart.dart';
import 'package:flutter_circular_chart_two/src/stack.dart';

class AnimatedCircularChartPainter extends CustomPainter {
  AnimatedCircularChartPainter(this.animation, this.labelPainter) : super(repaint: animation);

  final Animation<CircularChart> animation;
  final TextPainter? labelPainter;

  @override
  void paint(Canvas canvas, Size size) {
    _paintLabel(canvas, size, labelPainter);
    _paintChart(canvas, size, animation.value);
  }

  @override
  bool shouldRepaint(AnimatedCircularChartPainter old) => false;
}

class CircularChartPainter extends CustomPainter {
  CircularChartPainter(this.chart, this.labelPainter);

  final CircularChart chart;
  final TextPainter labelPainter;

  @override
  void paint(Canvas canvas, Size size) {
    _paintLabel(canvas, size, labelPainter);
    _paintChart(canvas, size, chart);
  }

  @override
  bool shouldRepaint(CircularChartPainter old) => false;
}

const double _kRadiansPerDegree = Math.pi / 180;

void _paintLabel(Canvas canvas, Size size, TextPainter? labelPainter) {
  if (labelPainter != null) {
    labelPainter.paint(
      canvas,
      Offset(
        size.width / 2 - labelPainter.width / 2,
        size.height / 2 - labelPainter.height / 2,
      ),
    );
  }
}

void _paintChart(Canvas canvas, Size size, CircularChart chart) {
  final Paint segmentPaint = Paint()
    ..style =
    chart.chartType == CircularChartType.Radial ? PaintingStyle.stroke : PaintingStyle.fill
    ..strokeCap = chart.edgeStyle == SegmentEdgeStyle.round ? StrokeCap.round : StrokeCap.butt;

  for (final CircularChartStack stack in chart.stacks) {
    for (final segment in stack.segments) {
      segmentPaint.color = segment.color!;
      segmentPaint.strokeWidth = stack.width!;

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: stack.radius!,
        ),
        stack.startAngle! * _kRadiansPerDegree,
        segment.sweepAngle! * _kRadiansPerDegree,
        chart.chartType == CircularChartType.Pie,
        segmentPaint,
      );
    }
  }
}
