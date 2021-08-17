import 'dart:math';

import 'package:flutter/material.dart';

class ColorPalette {
  static final ColorPalette primary = ColorPalette(<Color>[
    Colors.blue[400] ?? Colors.blue,
    Colors.blue[200] ?? Colors.blue,
    Colors.red[400] ?? Colors.red,
    Colors.red[200] ?? Colors.red,
    Colors.green[400] ?? Colors.green,
    Colors.green[200] ?? Colors.green,
    Colors.yellow[400] ?? Colors.yellow,
    Colors.yellow[200] ?? Colors.yellow,
    Colors.purple[400] ?? Colors.purple,
    Colors.purple[200] ?? Colors.purple,
    Colors.orange[400] ?? Colors.orange,
    Colors.orange[200] ?? Colors.orange,
    Colors.teal[400] ?? Colors.teal,
    Colors.teal[200] ?? Colors.teal,
    Colors.black,
  ]);

  ColorPalette(List<Color> colors) : _colors = colors {
    assert(colors.isNotEmpty);
  }

  final List<Color> _colors;

  Color operator [](int index) => _colors[index % length];

  int get length => _colors.length;

  Color random(Random random) => this[random.nextInt(length)];
}
