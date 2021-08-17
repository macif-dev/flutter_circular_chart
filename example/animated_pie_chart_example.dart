import 'package:flutter/material.dart';
import 'package:flutter_circular_chart_two/flutter_circular_chart_two.dart';

void main() {
  runApp(MaterialApp(
    home: AnimatedPieChartExample(),
  ));
}

final List<List<CircularStackEntry>> _quarterlyProfitPieData = [
  <CircularStackEntry>[
    CircularStackEntry(
      <CircularSegmentEntry>[
        CircularSegmentEntry(500.0, Colors.red[200] ?? Colors.red, rankKey: 'Q1'),
        CircularSegmentEntry(1000.0, Colors.green[200] ?? Colors.green, rankKey: 'Q2'),
        CircularSegmentEntry(2000.0, Colors.blue[200] ?? Colors.blue, rankKey: 'Q3'),
        CircularSegmentEntry(1000.0, Colors.yellow[200] ?? Colors.yellow, rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ],
  <CircularStackEntry>[
    CircularStackEntry(
      <CircularSegmentEntry>[
        CircularSegmentEntry(1500.0, Colors.red[200] ?? Colors.red, rankKey: 'Q1'),
        CircularSegmentEntry(750.0, Colors.green[200] ?? Colors.green, rankKey: 'Q2'),
        CircularSegmentEntry(2000.0, Colors.blue[200] ?? Colors.blue, rankKey: 'Q3'),
        CircularSegmentEntry(1000.0, Colors.yellow[200] ?? Colors.yellow, rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ],
  <CircularStackEntry>[
    CircularStackEntry(
      <CircularSegmentEntry>[
        CircularSegmentEntry(1800.0, Colors.red[200] ?? Colors.red, rankKey: 'Q1'),
        CircularSegmentEntry(2900.0, Colors.green[200] ?? Colors.green, rankKey: 'Q2'),
        CircularSegmentEntry(4000.0, Colors.blue[200] ?? Colors.blue, rankKey: 'Q3'),
        CircularSegmentEntry(7000.0, Colors.yellow[200] ?? Colors.yellow, rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ],
];

class AnimatedPieChartExample extends StatefulWidget {
  @override
  _AnimatedPieChartExampleState createState() => _AnimatedPieChartExampleState();
}

class _AnimatedPieChartExampleState extends State<AnimatedPieChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(300.0, 300.0);
  int sampleIndex = 0;

  void _cycleSamples() {
    setState(() {
      sampleIndex++;
      List<CircularStackEntry> data = _quarterlyProfitPieData[sampleIndex % 3];
      var _state = _chartKey.currentState;
      if(_state !=null ) _state.updateData(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quarterly Profit'),
      ),
      body: Center(
        child: AnimatedCircularChart(
          key: _chartKey,
          size: _chartSize,
          initialChartData: _quarterlyProfitPieData[0],
          chartType: CircularChartType.Pie,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: _cycleSamples,
      ),
    );
  }
}
