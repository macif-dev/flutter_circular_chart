import 'package:flutter/material.dart';
import 'package:flutter_circular_chart_two/flutter_circular_chart_two.dart';

void main() {
  runApp(MaterialApp(
    home: AnimatedRadialChartExample(),
  ));
}

class AnimatedRadialChartExample extends StatefulWidget {
  @override
  _AnimatedRadialChartExampleState createState() => _AnimatedRadialChartExampleState();
}

class _AnimatedRadialChartExampleState extends State<AnimatedRadialChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(200.0, 200.0);

  double value = 50.0;
  Color labelColor = Colors.blue[200] ?? Colors.blue;

  void _increment() {
    setState(() {
      value += 10;
      List<CircularStackEntry> data = _generateChartData(value);
      var _state = _chartKey.currentState;
      if(_state !=null ) _state.updateData(data);
    });
  }

  void _decrement() {
    setState(() {
      value -= 10;
      List<CircularStackEntry> data = _generateChartData(value);
      var _state = _chartKey.currentState;
      if(_state !=null ) _state.updateData(data);
    });
  }

  List<CircularStackEntry> _generateChartData(double value) {
    Color dialColor = Colors.blue[200] ?? Colors.blue;
    if (value < 0) {
      dialColor = Colors.red[200] ?? Colors.red;
    } else if (value < 50) {
      dialColor = Colors.yellow[200] ?? Colors.yellow;
    }
    labelColor = dialColor;

    List<CircularStackEntry> data = <CircularStackEntry>[
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            value,
            dialColor,
            rankKey: 'percentage',
          )
        ],
        rankKey: 'percentage',
      ),
    ];

    if (value > 100) {
      labelColor = Colors.green[200] ?? Colors.green;

      data.add(CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            value - 100,
            labelColor,
            rankKey: 'percentage',
          ),
        ],
        rankKey: 'percentage2',
      ));
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle =
        Theme.of(context).textTheme.headline6!.merge(TextStyle(color: labelColor));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Percentage Dial'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: AnimatedCircularChart(
              key: _chartKey,
              size: _chartSize,
              initialChartData: _generateChartData(value),
              chartType: CircularChartType.Radial,
              edgeStyle: SegmentEdgeStyle.round,
              percentageValues: true,
              holeLabel: '$value%',
              labelStyle: _labelStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _decrement,
                icon: const Icon(Icons.remove),
                label: Text(''),
              ),
              ElevatedButton.icon(
                onPressed: _increment,
                icon: const Icon(Icons.add),
                label: Text(''),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
