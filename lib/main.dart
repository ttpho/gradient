import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gradient',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color topLeftColor = const Color(0xFF9F015E);
  Color bottomRightColor = const Color(0xFFF9C929);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
          child: Card(
        child: Container(
          width: 204,
          height: 304,
          padding: EdgeInsets.all(2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [topLeftColor, bottomRightColor],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight,
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp)),
              ),
              ColorContainerWidget(
                  initColor: topLeftColor,
                  onColorChanged: (value) => {
                        setState(() {
                          topLeftColor = value;
                        })
                      }),
              ColorContainerWidget(
                  initColor: bottomRightColor,
                  onColorChanged: (value) => {
                        setState(() {
                          bottomRightColor = value;
                        })
                      }),
            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          setState(() {
            topLeftColor = const Color(0xFF9F015E);
            bottomRightColor = const Color(0xFFF9C929);
          })
        },
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class ColorContainerWidget extends StatefulWidget {
  final ValueChanged<Color> onColorChanged;
  final Color initColor;
  ColorContainerWidget({Key key, this.initColor, this.onColorChanged})
      : super(key: key);

  @override
  _ColorContainerState createState() => _ColorContainerState();
}

class _ColorContainerState extends State<ColorContainerWidget> {
  void _showPickerDialog(BuildContext buildContext, Color pickerColor,
      ValueChanged<Color> onColorChanged) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: pickerColor,
              onColorChanged: onColorChanged,
              enableLabel: true,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var hex = '#${widget.initColor.value.toRadixString(16)}';
    return Container(
      width: 200,
      height: 50,
      child: InkWell(
        onTap: () => {
          _showPickerDialog(context, widget.initColor, (value) {
            Navigator.pop(context);
            widget.onColorChanged(value);
          })
        },
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: widget.initColor,
              ),
              SizedBox(
                width: 10,
                height: 1,
              ),
              Text(hex,
                  style: TextStyle(
                    color: widget.initColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
