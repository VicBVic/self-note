import 'package:flutter/material.dart';
import 'package:painter/painter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerButton extends StatefulWidget {
  final PainterController _controller;
  final bool _background;

  const ColorPickerButton(this._controller, this._background, {super.key});

  @override
  ColorPickerButtonState createState() => ColorPickerButtonState();
}

class ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        IconButton(
          icon: Icon(_iconData, color: _color),
          tooltip: widget._background
              ? 'Change background color'
              : 'Change draw color',
          onPressed: _pickColor,
        ),
      ],
    );
  }

  void _pickColor() {
    Color pickerColor = _color;
    Navigator.of(context)
        .push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Pick color'),
                  ),
                  body: Center(
                    child: Container(
                        alignment: Alignment.center,
                        child: ColorPicker(
                          pickerColor: pickerColor,
                          onColorChanged: (Color c) => pickerColor = c,
                        )),
                  ));
            }))
        .then((_) {
      setState(() {
        _color = pickerColor;
      });
    });
  }

  Color get _color => widget._background
      ? widget._controller.backgroundColor
      : widget._controller.drawColor;

  IconData get _iconData =>
      widget._background ? Icons.format_color_fill : Icons.brush;

  set _color(Color color) {
    if (widget._background) {
      widget._controller.backgroundColor = color;
    } else {
      widget._controller.drawColor = color;
    }
  }
}
