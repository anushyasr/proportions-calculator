import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Theme.of(context).primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Proportions Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _margin = 10.0;

  double _result = 0;

  double _a = 0;
  double _b = 0;
  double _c = 0;
  double _d = 0;

  void handleAChange(String value) {
    setState(() {
      this._a = double.parse(value ?? 0.0);
    });
  }

  void handleBChange(String value) {
    setState(() {
      this._b = double.parse(value ?? 0.0);
    });
  }

  void handleCChange(String value) {
    setState(() {
      this._c = double.parse(value ?? 0.0);
    });
  }

  void handleDChange(String value) {
    setState(() {
      this._d = double.parse(value ?? 0.0);
    });
  }

  void calculate() {
    setState(() {
      if (_a == 0) {
        this._result = _b * _c / _d;
      } else if (_b == 0) {
        this._result = _a * _d / _c;
      } else if (_c == 0) {
        this._result = _a * _d / _b;
      } else {
        this._result = _b * _c / _a;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(_margin),
        child: Column(children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: Text('A : B = C : D',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ))),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 160.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'A',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                        onChanged: this.handleAChange,
                  ),
                ),
                Container(
                  width: 160.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'B',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                        onChanged: this.handleBChange,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 160.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'C',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                        onChanged: this.handleCChange,
                  ),
                ),
                Container(
                  width: 160.0,
                  margin: EdgeInsets.symmetric(horizontal: _margin),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'D',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                        onChanged: this.handleDChange,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: RaisedButton(
              child: Text('Calculate'),
              onPressed: calculate,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('Result : $_result',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                )),
          )
        ]),
      ),
    );
  }
}
